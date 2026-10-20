import time

import kitty.tab_bar as _kitty_tab_bar
from kitty.fast_data_types import Screen, add_timer, get_boss, wakeup_main_loop
from kitty.tab_bar import DrawData, ExtraData, TabBarData

# ---- settings ----
BLINK_INTERVAL = 0.2  # seconds per phase
ACTIVE_FG = 0x282828
ACTIVE_BG = 0xD79921
INACTIVE_FG = 0x282828
INACTIVE_BG = 0xD79921

TITLE_WIDTH = 15      # width of the title window (MIDDLE)
IDLE_MAX = 5          # titles with <= this many chars stay still
ROTATE_INTERVAL = 0.2 # seconds per carousel step (right -> left)
LOOP_GAP = "     "    # blank space between the end and the start of the title
GAP_BG = 0x282828     # background of the gaps between the pieces (terminal bg)
LINE_FG = ACTIVE_BG   # color of the connection line (golden)
LINE_CHAR = "═"       # connection line; use "-" if your font lacks box drawing
# ------------------

# Blink state lives on kitty's own tab_bar module, which is never reloaded.
# kitty re-executes this file on config reload; keeping the state here stops
# a second timer chain from starting.
_S = _kitty_tab_bar.__dict__.setdefault(
    "_blink_state", {"swapped": False, "running": False}
)


def _rgb(color: int) -> int:
    # kitty's internal encoding for an RGB color
    return (color << 8) | 2


def _arm() -> None:
    # One-shot timer aimed at the next slot on a fixed grid, so latency
    # never accumulates (kitty re-arms repeating timers as "now + interval").
    delay = BLINK_INTERVAL - (time.monotonic() % BLINK_INTERVAL)
    add_timer(_tick, max(delay, 0.01), False)


def _tick(timer_id=None) -> None:
    try:
        # The timer is the single source of truth for the phase.
        _S["swapped"] = not _S["swapped"]
        boss = get_boss()
        if boss is not None:
            for tm in boss.all_tab_managers:
                tm.mark_tab_bar_dirty()
        # mark_tab_bar_dirty() only sets a flag. kitty redraws the tab bar in
        # its main-loop tick, and that tick only runs when the loop is woken
        # by something (a key press, terminal output, its own cursor-blink
        # timer). A plain timer firing does NOT wake it, which is why the
        # blink used to depend on what the terminal was doing. Wake it here.
        wakeup_main_loop()
    finally:
        _arm()


def _carousel(title: str, width: int) -> str:
    # Fixed-width window over the title. Stateless: the offset comes from the
    # wall clock, so it needs no timer of its own and survives config reloads.
    title = title.upper()
    if len(title) <= IDLE_MAX:
        return title.center(width)
    loop = title + LOOP_GAP
    pos = int(time.monotonic() / ROTATE_INTERVAL) % len(loop)
    return (loop * 3)[pos : pos + width]


_cur = {"index": 1, "title": ""}  # info of the active tab


def _paint(screen: Screen, fg: int, bg: int, text: str) -> None:
    screen.cursor.fg = _rgb(fg)
    screen.cursor.bg = _rgb(bg)
    screen.cursor.bold = False
    screen.cursor.italic = False
    screen.draw(text)


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    if not _S["running"]:
        _S["running"] = True
        _arm()

    # Everything is drawn in ONE call: the one for the LAST tab. kitty adds
    # an ellipsis over the end of the bar when a tab that is not the last one
    # fills the line, which is what replaced the count with "...". The last
    # tab is exempt from that check. Every other call only records data.
    if tab.is_active:
        _cur["index"] = index
        _cur["title"] = tab.title
    if not is_last:
        return screen.cursor.x

    left = f"[{_cur['index']}]"
    right = f"[{str(index)}]"  # last tab's index == number of tabs
    mid = max(screen.columns - before - len(left) - len(right), 0)
    width = min(TITLE_WIDTH, mid)
    lpad = (mid - width) // 2
    rpad = mid - width - lpad
    title = _carousel(_cur["title"], width) if width > 0 else ""

    # LEFT edge: [index], blinks
    if _S["swapped"]:
        fg, bg = ACTIVE_BG, ACTIVE_FG
    else:
        fg, bg = ACTIVE_FG, ACTIVE_BG
    _paint(screen, fg, bg, left)

    # CENTER: carousel title, RIGHT edge: tab count (solid pieces),
    # with the terminal background in the gaps between pieces
    _paint(screen, LINE_FG, GAP_BG, LINE_CHAR * lpad)
    _paint(screen, ACTIVE_FG, ACTIVE_BG, title)
    _paint(screen, LINE_FG, GAP_BG, LINE_CHAR * rpad)
    _paint(screen, ACTIVE_BG, ACTIVE_FG, right)

    return screen.cursor.x
