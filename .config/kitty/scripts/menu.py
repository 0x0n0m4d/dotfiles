#!/usr/bin/env python3
import os, re, select, subprocess, sys, termios, time, tty

# ctrl+<key> opens a row. Excluded: c/d/u/q (close/page/quit) and h/i/j/m,
# because terminals send the same byte for them as Backspace/Tab/Enter.
KEYS = "asfgewrtyopzxvbnlk"
MAX_VISIBLE = 14
MAX_WIDTH = 44
BLINK_INTERVAL = 0.2                         # same as the tab bar
LEFT_T, CLOSER, PAGER = "MENU", "[x]", "ctrl+u/d"

CWD = os.environ.get("KH_CWD", "")
BUFFER = os.environ.get("KH_BUFFER", "")
word = os.environ.get("KH_WORD", "")
cand_path = os.environ["KH_CANDS"]
cands = [l for l in open(cand_path).read().splitlines() if l]
os.unlink(cand_path)

snapshot = sys.stdin.read().split("\n")
tin = open("/dev/tty", "rb", buffering=0)
fd = tin.fileno()
out = open("/dev/tty", "w")
cols, rows = os.get_terminal_size(fd)

BASE, KEY, TITLE, HIT, CNT = (
    "\x1b[100;33m", "\x1b[32m", "\x1b[95m", "\x1b[91m", "\x1b[43;30m",
)
Y = 1                                        # top
STAY = object()                              # an action returns this to keep the menu open


def clean(s):
    return re.sub(r"[^\x20-\x7e]", "?", s)


# ---------------------------------------------------------------- pages

class Page:
    """A list of (label, action). An action returns a Page to open it, STAY to
    keep the menu as it is, or None to close the menu."""

    def __init__(self, title, items, filterable=False, counter=False):
        self.title = title
        self.items = items or [("(none)", lambda: STAY)]
        self.filterable, self.counter = filterable, counter
        self.lows = [l.lower() for l, _ in self.items]
        self.flt, self.top, self.matches = "", 0, self.items
        n = len(self.items)
        self.vis = max(1, min(n, len(KEYS), MAX_VISIBLE, rows - 3))
        # size comes from ALL items, so the box never resizes while filtering
        count_len = len(f"+{n}") if counter else 0
        self.W = min(max(
            max(len(l) for l, _ in self.items) + 11,   # "ctrl+a" label + borders
            len(title) + 14,
            len(LEFT_T) + count_len + len(CLOSER) + 4,
            28,
        ), MAX_WIDTH, cols)
        self.X = cols - self.W + 1           # flush to the right edge

    def refilter(self):
        q = self.flt.lower()
        self.matches = [it for it, l in zip(self.items, self.lows) if q in l]
        self.top = 0


# -------------------------------------------------------------- drawing

def draw_background():
    out.write("\x1b[?25l\x1b[0m\x1b[2J\x1b[H"
              + "\r\n".join(snapshot[:rows]) + "\x1b[0m")


def draw_box(p, blink):
    W, X, q = p.W, p.X, p.flt.lower()
    b = []
    at = lambda r, s: b.append(f"\x1b[{r};{X}H{s}")

    # top bar: blinking MENU on the left edge, [count] and [x] on the right edge
    count = f"+{len(p.matches)}" if p.counter else ""
    fill = "═" * max(W - 2 - len(LEFT_T) - len(count) - len(CLOSER), 0)
    menu = f"\x1b[7m{LEFT_T}\x1b[27m" if blink else LEFT_T
    count_s = f"{CNT}{count}{BASE}" if count else ""
    at(Y, f"{BASE}╔{menu}{fill}{count_s}{CLOSER}╗")

    # title row: page title on the left, filter input on the right (if any)
    inp = (p.flt + "_")[-max(W - 4 - len(p.title), 1):] if p.filterable else ""
    gap = " " * max(W - 2 - len(p.title) - len(inp) - 1, 0)
    at(Y + 1, f"{BASE}║{TITLE}{p.title}{gap}{inp} {BASE}║")

    # rows: each ctrl key belongs to the ROW, not to the item
    page = p.matches[p.top:p.top + p.vis]
    for n in range(p.vis):
        if n < len(page):
            name = page[n][0][:W - 10]
            i = name.lower().find(q) if q else -1
            if i >= 0:
                j = i + len(q)
                shown = f"{name[:i]}{HIT}{name[i:j]}{BASE}{name[j:]}"
            else:
                shown = name
            body = shown + " " * (W - 12 - len(name))
            at(Y + 2 + n, f"{BASE}║ {KEY}'ctrl+{KEYS[n]}'{BASE} {body}║")
        else:
            at(Y + 2 + n, f"{BASE}║{' ' * (W - 2)}║")

    # bottom bar: page keys on the right edge, only when there is more than a page
    pager = PAGER if len(p.matches) > p.vis else ""
    at(Y + p.vis + 2, f"{BASE}╚{'═' * (W - 2 - len(pager))}{pager}╝\x1b[0m")
    out.write("".join(b)); out.flush()


# -------------------------------------------------------------- actions

SPLIT = r'''
sleep 0.15
kitten @ close-window --match var:plugin=templeos
new=$(kitten @ launch --location=hsplit --var plugin=templeos "$@")
kitten @ action --match id:"$new" layout_action move_to_screen_edge bottom
kitten @ action --match id:"$new" layout_action bias 65
'''


def split(*cmd):
    """Open `cmd` in the bottom pane (what clipout.sh did with launch/hsplit)."""
    cwd = f"--cwd={CWD}" if CWD else "--cwd=current"
    subprocess.Popen(["sh", "-c", SPLIT, "_", cwd, *cmd], start_new_session=True,
                     stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL,
                     stderr=subprocess.DEVNULL)


def open_man(name):
    split("zsh", "-ic",
          'man "$1" || { echo "no man page: $1"; read -r _; }', "_", name)


def complete_page():
    items = [(clean(c), (lambda c=c: open_man(c))) for c in cands]
    return Page(" man: " + clean(word), items, filterable=True, counter=True)


PATH_LINE = re.compile(r"^(.+?):(\d+)(?::(\d+))?:?$")      # file:line[:col]


def resolve(p):
    return os.path.join(CWD, os.path.expanduser(p))


def command_plan(text):
    """Decide what the text means; returns the command for the bottom pane."""
    if not text:
        return None
    # 1. a plain `cat ...` becomes `c ...`, shown directly in the pane
    if re.match(r"cat(\s|$)", text) and not re.search(r"[|;&<>]", text):
        return ["zsh", "-ic", "c" + text[3:]]
    #    a command that already goes through `c` is run as it is
    if re.search(r"(^|[|;&]\s*)c(\s|$)", text):
        return ["zsh", "-ic", text]
    # 2. anything else is a command: run it, the output goes to an nvim buffer
    return ["zsh", "-ic", 'eval "$1" 2>&1 | nvim -', "_", text]


def file_plan(text):
    """Decide what the text means; returns the command for the bottom pane."""
    if not text:
        return None
    # 1. an existing file or directory (the whole text, so spaces are fine)
    if os.path.exists(resolve(text)):
        return os.path.expanduser(text)
    return None


def exec_command():
    cmd = command_plan(BUFFER.strip())
    if cmd is None:
        return STAY                          # empty prompt: nothing to open
    split(*cmd)


def open_file():
    file = file_plan(BUFFER.strip())
    if file is None:
        return STAY                          # empty prompt: nothing to open
    split("zsh", "-ic", f"v {file}")


def open_history():
    split("zsh", "-ic", "v ~/.zsh_history")


root = Page(" home", [
    ("execute command", exec_command),
    ("open file",       open_file),
    ("history",         open_history),
])

# An "incomplete bin": the prompt holds a single word that is not a command
# yet, but is the start of at least one. Then skip the home page.
incomplete = bool(word) and BUFFER == word and bool(cands) and word not in cands

# ----------------------------------------------------------------- loop

old = termios.tcgetattr(fd)
tty.setraw(fd)
try:
    stack = [root, complete_page()] if incomplete else [root]
    blink, fresh, done = False, True, False
    nxt = time.monotonic() + BLINK_INTERVAL

    while not done:
        p = stack[-1]
        if fresh:                            # new page: repaint the background
            draw_background(); fresh = False
        draw_box(p, blink)
        ready = select.select([fd], [], [], max(nxt - time.monotonic(), 0))[0]

        if time.monotonic() >= nxt:          # blink on a fixed grid
            blink = not blink
            while nxt <= time.monotonic():
                nxt += BLINK_INTERVAL
        if not ready:
            continue

        data = os.read(fd, 32)
        if data.startswith(b"\x1b"):         # Esc, arrows, Alt+key...: ignored
            continue

        for ch in data.decode(errors="ignore"):
            if ch in ("\x11", "\x03"):               # ctrl+q (ctrl+c as a fallback)
                done = True; break
            elif ch == "\x04":                       # ctrl+d: page down
                p.top = min(p.top + p.vis, max(len(p.matches) - p.vis, 0))
            elif ch == "\x15":                       # ctrl+u: page up
                p.top = max(p.top - p.vis, 0)
            elif ch in ("\x7f", "\x08"):             # Backspace
                if p.filterable:
                    p.flt = p.flt[:-1]; p.refilter()
            elif 1 <= ord(ch) <= 26:                 # ctrl+<letter>: open the row
                n = KEYS.find(chr(ord(ch) + 96))
                if 0 <= n < p.vis and p.top + n < len(p.matches):
                    res = p.matches[p.top + n][1]()
                    if isinstance(res, Page):
                        stack.append(res); fresh = True
                    elif res is not STAY:
                        done = True
                    break
            elif p.filterable and " " < ch < "\x7f": # typed letter -> filter
                p.flt += ch; p.refilter()
finally:
    termios.tcsetattr(fd, termios.TCSADRAIN, old)
    out.write("\x1b[?25h"); out.flush()
