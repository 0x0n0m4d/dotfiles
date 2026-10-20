c = c
config = config

c.colors.statusbar.normal.bg = "#282828"
c.colors.statusbar.normal.fg = "#458588"
c.colors.statusbar.command.bg = "#504945"
c.colors.statusbar.command.fg = "#d79921"
c.colors.statusbar.insert.bg = "#282828"
c.colors.statusbar.insert.fg = "#fe8019"
c.colors.statusbar.caret.bg = "#282828"
c.colors.statusbar.caret.fg = "#b16286"
c.colors.statusbar.caret.selection.bg = "#b16286"
c.colors.statusbar.caret.selection.fg = "#282828"
c.colors.statusbar.passthrough.bg = "#282828"
c.colors.statusbar.passthrough.fg = "#fb4934"
c.colors.statusbar.url.fg = "#b8bb26"
c.colors.statusbar.url.success.http.fg = "#b8bb26"
c.colors.statusbar.url.success.https.fg = "#b8bb26"
c.colors.statusbar.url.warn.fg = "#d79921"
c.colors.statusbar.url.hover.fg = "#8ec07c"

c.colors.tabs.even.bg = "#504945"
c.colors.tabs.odd.bg = "#3c3836"
c.colors.tabs.bar.bg = "#282828"
c.colors.tabs.even.fg = "#d79921"
c.colors.tabs.odd.fg = "#d79921"
c.colors.tabs.selected.even.bg = "#d79921"
c.colors.tabs.selected.odd.bg = "#d79921"
c.colors.tabs.selected.even.fg = "#282828"
c.colors.tabs.selected.odd.fg = "#282828"
c.colors.tabs.indicator.error = "#fb4934"
c.colors.tabs.indicator.start = "#458588"
c.colors.tabs.indicator.stop = "#504945"
c.tabs.show = "multiple"

c.colors.hints.bg = "#d79921"
c.colors.hints.fg = "#282828"
c.colors.hints.match.fg = "#ebdbb2"

c.colors.keyhint.bg = "#504945"
c.colors.keyhint.fg = "#ebdbb2"
c.colors.keyhint.suffix.fg = "#8ec07c"

c.colors.completion.odd.bg = "#504945"
c.colors.completion.even.bg = "#3c3836"
c.colors.completion.fg = "#ebdbb2"
c.colors.completion.match.fg = "#458588"
c.colors.completion.category.bg = "#504945"
c.colors.completion.category.fg = "#ebdbb2"
c.colors.completion.item.selected.bg = "#504945"
c.colors.completion.item.selected.fg = "#ebdbb2"
c.colors.completion.item.selected.match.fg = "#458588"

c.colors.messages.info.bg = "#458588"
c.colors.messages.info.fg = "#1d2021"
c.colors.messages.info.border = "#fbf1c7"
c.colors.messages.error.bg = "#fb4934"
c.colors.messages.error.fg = "#1d2021"
c.colors.messages.error.border = "#fbf1c7"
c.colors.messages.warning.bg = "#fabd2f"
c.colors.messages.warning.fg = "#1d2021"
c.colors.messages.warning.border = "#fbf1c7"

c.colors.downloads.error.bg = "#fb4934"
c.colors.downloads.error.fg = "#1d2021"
c.colors.downloads.bar.bg = "#504945"
c.colors.downloads.start.bg = "#b8bb26"
c.colors.downloads.start.fg = "#1d2021"
c.colors.downloads.stop.bg = "#504945"
c.colors.downloads.stop.fg = "#b8bb26"

c.colors.prompts.bg = "#504945"
c.colors.prompts.fg = "#ebdbb2"
c.colors.prompts.selected.bg = "#d79921"
c.colors.prompts.selected.bg = "#1d2021"

c.colors.tooltip.bg = "#504945"
c.colors.webpage.bg = "#1d2021"
c.hints.border = "#ebdbb2"

c.colors.contextmenu.menu.bg = "#504945"
c.colors.contextmenu.menu.fg = "#ebdbb2"
c.colors.contextmenu.disabled.bg = "#282828"
c.colors.contextmenu.disabled.fg = "#a89984"
c.colors.contextmenu.selected.bg = "#458588"
c.colors.contextmenu.selected.fg = "#1d2021"

c.url.start_pages = ['file:///home/n0m4d/.config/qutebrowser/default_page.html']
c.url.default_page = 'file:///home/n0m4d/.config/qutebrowser/default_page.html'
c.downloads.location.directory = '~/Downloads'
c.downloads.location.prompt = False

c.tabs.title.format = "{audio}{current_title}"
c.fonts.web.size.default = 15

c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    '!sdm': 'https://{}',
    '!dm':  'http://{}',
    '!wp':  'https://en.wikipedia.org/w/index.php?fulltext=1&search={}',
    '!gg':  'https://www.google.com/search?client=firefox-b-e&channel=entpr&q={}',
    '!gh':  'https://github.com/search?o=desc&q={}&s=stars',
    '!gp':  'https://github.com/{}',
    '!yt':  'https://www.youtube.com/results?search_query={}',
}

c.completion.open_categories = ['searchengines', 'quickmarks', 'bookmarks', 'history', 'filesystem']

config.load_autoconfig() # load settings done via the gui

c.auto_save.session = True # save tabs on quit/restart

# keybinding changes
config.unbind("M")
config.unbind("m")
config.unbind("gf")
config.bind('e', 'edit-url')
config.bind('Qs', 'quickmark-save')
config.bind('Qd', 'cmd-set-text -s :quickmark-del')
config.bind('Qo', 'cmd-set-text -s :quickmark-load')
config.bind('QO', 'cmd-set-text -s :quickmark-load -t')
config.bind('Mo', 'cmd-set-text -s :bookmark-load')
config.bind('MO', 'cmd-set-text -s :bookmark-load -t')
config.bind('Ml', 'bookmark-list')
config.bind('ML', 'bookmark-list -t')
config.bind('Ma', 'cmd-set-text -s :bookmark-add')
config.bind('Md', 'cmd-set-text -s :bookmark-del')
config.bind('ma', 'cmd-set-text -s :set-mark')
config.bind('mj', 'cmd-set-text -s :jump-mark')
config.bind('pp', 'open -- {clipboard}')
config.bind('pt', 'open -t -- {clipboard}')
config.bind('<ctrl-shift-tab>', 'tab-prev')
config.bind('<ctrl-tab>', 'tab-next')
config.bind('>', 'tab-move +')
config.bind('<', 'tab-move -')
config.bind('cs', 'config-source')
config.bind('yf', 'hint links yank')
config.bind('\\/', 'jseval -q document.activeElement.blur()')
config.bind('ap', "set content.proxy http://0.0.0.0:8080")
config.bind('ar', "set content.proxy none")
config.bind("gf", "view-source --edit")

# dark mode setup
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.policy.images = 'never'
config.set('colors.webpage.darkmode.enabled', False, 'file://*')

# Tabs style
c.tabs.padding = {'top': 2, 'bottom': 2, 'left': 0, 'right': 0}
c.tabs.indicator.width = 0
c.tabs.width = '7%'

# fonts
c.fonts.default_family = ["BigBlueTerm437 Nerd Font"]
c.fonts.default_size = '12pt'
c.fonts.web.size.default = 16

config.set("content.webgl", False, "*")
config.set("content.geolocation", False)
c.content.javascript.log_message.levels['userscript:*'] = []

c.content.blocking.enabled = True

# editor
c.editor.command = ['/home/n0m4d/.config/qutebrowser/editor.sh', '{file}']
