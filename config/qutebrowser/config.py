import subprocess

# Read colour values from xresources
def read_xresources(prefix):
    props = {}
    x = subprocess.run(['xrdb', '-query'], stdout=subprocess.PIPE)
    lines = x.stdout.decode().split('\n')
    for line in filter(lambda l : l.startswith(prefix), lines):
        prop, _, value = line.partition(':\t')
        props[prop] = value
    return props

# apply x resources colours
def load_from_xresources(xresources):
    c.colors.statusbar.normal.bg = xresources['*.background']

    # set qutebrowser colors

    # Text color of the completion widget. May be a single color to use for
    # all columns or a list of three colors, one for each column.
    c.colors.completion.fg = xresources['*.color7']

    # Background color of the completion widget for odd rows.
    c.colors.completion.odd.bg = xresources['*.color0']

    # Background color of the completion widget for even rows.
    c.colors.completion.even.bg = xresources['*.color0']

    # Foreground color of completion widget category headers.
    c.colors.completion.category.fg = xresources['*.color10']

    # Background color of the completion widget category headers.
    c.colors.completion.category.bg = xresources['*.color0']

    # Top border color of the completion widget category headers.
    c.colors.completion.category.border.top = xresources['*.color0']

    # Bottom border color of the completion widget category headers.
    c.colors.completion.category.border.bottom = xresources['*.color0']

    # Foreground color of the selected completion item.
    c.colors.completion.item.selected.fg = xresources['*.color1']

    # Background color of the selected completion item.
    c.colors.completion.item.selected.bg = xresources['*.color10']

    # Top border color of the selected completion item.
    c.colors.completion.item.selected.border.top = xresources['*.color10']

    # Bottom border color of the selected completion item.
    c.colors.completion.item.selected.border.bottom = xresources['*.color10']

    # Foreground color of the matched text in the selected completion item.
    c.colors.completion.item.selected.match.fg = xresources['*.color8']

    # Foreground color of the matched text in the completion.
    c.colors.completion.match.fg = xresources['*.color11']

    # Color of the scrollbar handle in the completion view.
    c.colors.completion.scrollbar.fg = xresources['*.color7']

    # Color of the scrollbar in the completion view.
    c.colors.completion.scrollbar.bg = xresources['*.color0']

    # Background color of the context menu. If set to null, the Qt default is used.
    c.colors.contextmenu.menu.bg = xresources['*.color0']

    # Foreground color of the context menu. If set to null, the Qt default is used.
    c.colors.contextmenu.menu.fg = xresources['*.color7']

    # Background color of the context menu’s selected item. If set to null, the Qt default is used.
    c.colors.contextmenu.selected.bg = xresources['*.color10']

    #Foreground color of the context menu’s selected item. If set to null, the Qt default is used.
    c.colors.contextmenu.selected.fg = xresources['*.color1']

    # Background color for the download bar.
    c.colors.downloads.bar.bg = xresources['*.color0']

    # Color gradient start for download text.
    c.colors.downloads.start.fg = xresources['*.color0']

    # Color gradient start for download backgrounds.
    c.colors.downloads.start.bg = xresources['*.color8']

    # Color gradient end for download text.
    c.colors.downloads.stop.fg = xresources['*.color0']

    # Color gradient stop for download backgrounds.
    c.colors.downloads.stop.bg = xresources['*.color12']

    # Foreground color for downloads with errors.
    c.colors.downloads.error.fg = xresources['*.color8']

    # Font color for hints.
    c.colors.hints.fg = xresources['*.color0']

    # Background color for hints. Note that you can use a `rgba(...)` value
    # for transparency.
    c.colors.hints.bg = xresources['*.color10']

    # Font color for the matched part of hints.
    c.colors.hints.match.fg = xresources['*.color5']

    # Text color for the keyhint widget.
    c.colors.keyhint.fg = xresources['*.color5']

    # Highlight color for keys to complete the current keychain.
    c.colors.keyhint.suffix.fg = xresources['*.color5']

    # Background color of the keyhint widget.
    c.colors.keyhint.bg = xresources['*.color0']

    # Foreground color of an error message.
    c.colors.messages.error.fg = xresources['*.color0']

    # Background color of an error message.
    c.colors.messages.error.bg = xresources['*.color8']

    # Border color of an error message.
    c.colors.messages.error.border = xresources['*.color8']

    # Foreground color of a warning message.
    c.colors.messages.warning.fg = xresources['*.color0']

    # Background color of a warning message.
    c.colors.messages.warning.bg = xresources['*.color14']

    # Border color of a warning message.
    c.colors.messages.warning.border = xresources['*.color14']

    # Foreground color of an info message.
    c.colors.messages.info.fg = xresources['*.color5']

    # Background color of an info message.
    c.colors.messages.info.bg = xresources['*.color0']

    # Border color of an info message.
    c.colors.messages.info.border = xresources['*.color0']

    # Foreground color for prompts.
    c.colors.prompts.fg = xresources['*.color5']

    # Border used around UI elements in prompts.
    c.colors.prompts.border = xresources['*.color0']

    # Background color for prompts.
    c.colors.prompts.bg = xresources['*.color0']

    # Background color for the selected item in filename prompts.
    c.colors.prompts.selected.bg = xresources['*.color10']

    # Foreground color of the statusbar.
    c.colors.statusbar.normal.fg = xresources['*.color11']

    # Background color of the statusbar.
    c.colors.statusbar.normal.bg = xresources['*.color0']

    # Foreground color of the statusbar in insert mode.
    c.colors.statusbar.insert.fg = xresources['*.color7']

    # Background color of the statusbar in insert mode.
    c.colors.statusbar.insert.bg = xresources['*.color0']

    # Foreground color of the statusbar in passthrough mode.
    c.colors.statusbar.passthrough.fg = xresources['*.color0']

    # Background color of the statusbar in passthrough mode.
    c.colors.statusbar.passthrough.bg = xresources['*.color12']

    # Foreground color of the statusbar in private browsing mode.
    c.colors.statusbar.private.fg = xresources['*.color0']

    # Background color of the statusbar in private browsing mode.
    c.colors.statusbar.private.bg = xresources['*.color3']

    # Foreground color of the statusbar in command mode.
    c.colors.statusbar.command.fg = xresources['*.color7']

    # Background color of the statusbar in command mode.
    c.colors.statusbar.command.bg = xresources['*.color0']

    # Foreground color of the statusbar in private browsing + command mode.
    c.colors.statusbar.command.private.fg = xresources['*.color7']

    # Background color of the statusbar in private browsing + command mode.
    c.colors.statusbar.command.private.bg = xresources['*.color0']

    # Foreground color of the statusbar in caret mode.
    c.colors.statusbar.caret.fg = xresources['*.color0']

    # Background color of the statusbar in caret mode.
    c.colors.statusbar.caret.bg = xresources['*.color14']

    # Foreground color of the statusbar in caret mode with a selection.
    c.colors.statusbar.caret.selection.fg = xresources['*.color0']

    # Background color of the statusbar in caret mode with a selection.
    c.colors.statusbar.caret.selection.bg = xresources['*.color8']

    # Background color of the progress bar.
    c.colors.statusbar.progress.bg = xresources['*.color8']

    # Default foreground color of the URL in the statusbar.
    c.colors.statusbar.url.fg = xresources['*.color5']

    # Foreground color of the URL in the statusbar on error.
    c.colors.statusbar.url.error.fg = xresources['*.color8']

    # Foreground color of the URL in the statusbar for hovered links.
    c.colors.statusbar.url.hover.fg = xresources['*.color5']

    # Foreground color of the URL in the statusbar on successful load
    # (http).
    c.colors.statusbar.url.success.http.fg = xresources['*.color12']

    # Foreground color of the URL in the statusbar on successful load
    # (https).
    c.colors.statusbar.url.success.https.fg = xresources['*.color11']

    # Foreground color of the URL in the statusbar when there's a warning.
    c.colors.statusbar.url.warn.fg = xresources['*.color14']

    # Background color of the tab bar.
    c.colors.tabs.bar.bg = xresources['*.color0']

    # Color gradient start for the tab indicator.
    c.colors.tabs.indicator.start = xresources['*.color8']

    # Color gradient end for the tab indicator.
    c.colors.tabs.indicator.stop = xresources['*.color12']

    # Color for the tab indicator on errors.
    c.colors.tabs.indicator.error = xresources['*.color8']

    # Foreground color of unselected odd tabs.
    c.colors.tabs.odd.fg = xresources['*.color7']

    # Background color of unselected odd tabs.
    c.colors.tabs.odd.bg = xresources['*.color8']

    # Foreground color of unselected even tabs.
    c.colors.tabs.even.fg = xresources['*.color7']

    # Background color of unselected even tabs.
    c.colors.tabs.even.bg = xresources['*.color8']

    # Background color of pinned unselected even tabs.
    c.colors.tabs.pinned.even.bg = xresources['*.color12']

    # Foreground color of pinned unselected even tabs.
    c.colors.tabs.pinned.even.fg = xresources['*.color7']

    # Background color of pinned unselected odd tabs.
    c.colors.tabs.pinned.odd.bg = xresources['*.color11']

    # Foreground color of pinned unselected odd tabs.
    c.colors.tabs.pinned.odd.fg = xresources['*.color7']

    # Background color of pinned selected even tabs.
    c.colors.tabs.pinned.selected.even.bg = xresources['*.color7']

    # Foreground color of pinned selected even tabs.
    c.colors.tabs.pinned.selected.even.fg = xresources['*.color0']

    # Background color of pinned selected odd tabs.
    c.colors.tabs.pinned.selected.odd.bg = xresources['*.color7']

    # Foreground color of pinned selected odd tabs.
    c.colors.tabs.pinned.selected.odd.fg = xresources['*.color14']

    # Foreground color of selected odd tabs.
    c.colors.tabs.selected.odd.fg = xresources['*.color0']

    # Background color of selected odd tabs.
    c.colors.tabs.selected.odd.bg = xresources['*.color7']

    # Foreground color of selected even tabs.
    c.colors.tabs.selected.even.fg = xresources['*.color0']

    # Background color of selected even tabs.
    c.colors.tabs.selected.even.bg = xresources['*.color7']

    # Background color for webpages if unset (or empty to use the theme's
    # color).
    c.colors.webpage.bg = xresources['*.color0']


# Load a fixed theme
def load_theme():
    # base16-qutebrowser (https://github.com/theova/base16-qutebrowser)
    # Base16 qutebrowser template by theova
    # Grayscale Dark scheme by Alexandre Gavioli (https://github.com/Alexx2/)

    base00 = "#101010"
    base01 = "#252525"
    base02 = "#464646"
    base03 = "#525252"
    base04 = "#ababab"
    base05 = "#b9b9b9"
    base06 = "#e3e3e3"
    base07 = "#f7f7f7"
    base08 = "#7c7c7c"
    base09 = "#999999"
    base0A = "#a0a0a0"
    base0B = "#8e8e8e"
    base0C = "#868686"
    base0D = "#686868"
    base0E = "#747474"
    base0F = "#5e5e5e"

    # set qutebrowser colors

    # Text color of the completion widget. May be a single color to use for
    # all columns or a list of three colors, one for each column.
    c.colors.completion.fg = base05

    # Background color of the completion widget for odd rows.
    c.colors.completion.odd.bg = base03

    # Background color of the completion widget for even rows.
    c.colors.completion.even.bg = base00

    # Foreground color of completion widget category headers.
    c.colors.completion.category.fg = base0A

    # Background color of the completion widget category headers.
    c.colors.completion.category.bg = base00

    # Top border color of the completion widget category headers.
    c.colors.completion.category.border.top = base00

    # Bottom border color of the completion widget category headers.
    c.colors.completion.category.border.bottom = base00

    # Foreground color of the selected completion item.
    c.colors.completion.item.selected.fg = base01

    # Background color of the selected completion item.
    c.colors.completion.item.selected.bg = base0A

    # Top border color of the selected completion item.
    c.colors.completion.item.selected.border.top = base0A

    # Bottom border color of the selected completion item.
    c.colors.completion.item.selected.border.bottom = base0A

    # Foreground color of the matched text in the selected completion item.
    c.colors.completion.item.selected.match.fg = base08

    # Foreground color of the matched text in the completion.
    c.colors.completion.match.fg = base0B

    # Color of the scrollbar handle in the completion view.
    c.colors.completion.scrollbar.fg = base05

    # Color of the scrollbar in the completion view.
    c.colors.completion.scrollbar.bg = base00

    # Background color of the context menu. If set to null, the Qt default is used.
    c.colors.contextmenu.menu.bg = base00

    # Foreground color of the context menu. If set to null, the Qt default is used.
    c.colors.contextmenu.menu.fg =  base05

    # Background color of the context menu’s selected item. If set to null, the Qt default is used.
    c.colors.contextmenu.selected.bg = base0A

    #Foreground color of the context menu’s selected item. If set to null, the Qt default is used.
    c.colors.contextmenu.selected.fg = base01

    # Background color for the download bar.
    c.colors.downloads.bar.bg = base00

    # Color gradient start for download text.
    c.colors.downloads.start.fg = base00

    # Color gradient start for download backgrounds.
    c.colors.downloads.start.bg = base0D

    # Color gradient end for download text.
    c.colors.downloads.stop.fg = base00

    # Color gradient stop for download backgrounds.
    c.colors.downloads.stop.bg = base0C

    # Foreground color for downloads with errors.
    c.colors.downloads.error.fg = base08

    # Font color for hints.
    c.colors.hints.fg = base00

    # Background color for hints. Note that you can use a `rgba(...)` value
    # for transparency.
    c.colors.hints.bg = base0A

    # Font color for the matched part of hints.
    c.colors.hints.match.fg = base05

    # Text color for the keyhint widget.
    c.colors.keyhint.fg = base05

    # Highlight color for keys to complete the current keychain.
    c.colors.keyhint.suffix.fg = base05

    # Background color of the keyhint widget.
    c.colors.keyhint.bg = base00

    # Foreground color of an error message.
    c.colors.messages.error.fg = base00

    # Background color of an error message.
    c.colors.messages.error.bg = base08

    # Border color of an error message.
    c.colors.messages.error.border = base08

    # Foreground color of a warning message.
    c.colors.messages.warning.fg = base00

    # Background color of a warning message.
    c.colors.messages.warning.bg = base0E

    # Border color of a warning message.
    c.colors.messages.warning.border = base0E

    # Foreground color of an info message.
    c.colors.messages.info.fg = base05

    # Background color of an info message.
    c.colors.messages.info.bg = base00

    # Border color of an info message.
    c.colors.messages.info.border = base00

    # Foreground color for prompts.
    c.colors.prompts.fg = base05

    # Border used around UI elements in prompts.
    c.colors.prompts.border = base00

    # Background color for prompts.
    c.colors.prompts.bg = base00

    # Background color for the selected item in filename prompts.
    c.colors.prompts.selected.bg = base0A

    # Foreground color of the statusbar.
    c.colors.statusbar.normal.fg = base0B

    # Background color of the statusbar.
    c.colors.statusbar.normal.bg = base00

    # Foreground color of the statusbar in insert mode.
    c.colors.statusbar.insert.fg = base00

    # Background color of the statusbar in insert mode.
    c.colors.statusbar.insert.bg = base0D

    # Foreground color of the statusbar in passthrough mode.
    c.colors.statusbar.passthrough.fg = base00

    # Background color of the statusbar in passthrough mode.
    c.colors.statusbar.passthrough.bg = base0C

    # Foreground color of the statusbar in private browsing mode.
    c.colors.statusbar.private.fg = base00

    # Background color of the statusbar in private browsing mode.
    c.colors.statusbar.private.bg = base03

    # Foreground color of the statusbar in command mode.
    c.colors.statusbar.command.fg = base05

    # Background color of the statusbar in command mode.
    c.colors.statusbar.command.bg = base00

    # Foreground color of the statusbar in private browsing + command mode.
    c.colors.statusbar.command.private.fg = base05

    # Background color of the statusbar in private browsing + command mode.
    c.colors.statusbar.command.private.bg = base00

    # Foreground color of the statusbar in caret mode.
    c.colors.statusbar.caret.fg = base00

    # Background color of the statusbar in caret mode.
    c.colors.statusbar.caret.bg = base0E

    # Foreground color of the statusbar in caret mode with a selection.
    c.colors.statusbar.caret.selection.fg = base00

    # Background color of the statusbar in caret mode with a selection.
    c.colors.statusbar.caret.selection.bg = base0D

    # Background color of the progress bar.
    c.colors.statusbar.progress.bg = base0D

    # Default foreground color of the URL in the statusbar.
    c.colors.statusbar.url.fg = base05

    # Foreground color of the URL in the statusbar on error.
    c.colors.statusbar.url.error.fg = base08

    # Foreground color of the URL in the statusbar for hovered links.
    c.colors.statusbar.url.hover.fg = base05

    # Foreground color of the URL in the statusbar on successful load
    # (http).
    c.colors.statusbar.url.success.http.fg = base0C

    # Foreground color of the URL in the statusbar on successful load
    # (https).
    c.colors.statusbar.url.success.https.fg = base0B

    # Foreground color of the URL in the statusbar when there's a warning.
    c.colors.statusbar.url.warn.fg = base0E

    # Background color of the tab bar.
    c.colors.tabs.bar.bg = base00

    # Color gradient start for the tab indicator.
    c.colors.tabs.indicator.start = base0D

    # Color gradient end for the tab indicator.
    c.colors.tabs.indicator.stop = base0C

    # Color for the tab indicator on errors.
    c.colors.tabs.indicator.error = base08

    # Foreground color of unselected odd tabs.
    c.colors.tabs.odd.fg = base05

    # Background color of unselected odd tabs.
    c.colors.tabs.odd.bg = base03

    # Foreground color of unselected even tabs.
    c.colors.tabs.even.fg = base05

    # Background color of unselected even tabs.
    c.colors.tabs.even.bg = base00

    # Background color of pinned unselected even tabs.
    c.colors.tabs.pinned.even.bg = base0C

    # Foreground color of pinned unselected even tabs.
    c.colors.tabs.pinned.even.fg = base07

    # Background color of pinned unselected odd tabs.
    c.colors.tabs.pinned.odd.bg = base0B

    # Foreground color of pinned unselected odd tabs.
    c.colors.tabs.pinned.odd.fg = base07

    # Background color of pinned selected even tabs.
    c.colors.tabs.pinned.selected.even.bg = base05

    # Foreground color of pinned selected even tabs.
    c.colors.tabs.pinned.selected.even.fg = base00

    # Background color of pinned selected odd tabs.
    c.colors.tabs.pinned.selected.odd.bg = base05

    # Foreground color of pinned selected odd tabs.
    c.colors.tabs.pinned.selected.odd.fg = base0E

    # Foreground color of selected odd tabs.
    c.colors.tabs.selected.odd.fg = base00

    # Background color of selected odd tabs.
    c.colors.tabs.selected.odd.bg = base05

    # Foreground color of selected even tabs.
    c.colors.tabs.selected.even.fg = base00

    # Background color of selected even tabs.
    c.colors.tabs.selected.even.bg = base05

    # Background color for webpages if unset (or empty to use the theme's
    # color).
    # c.colors.webpage.bg = base00

c.url.searchengines = {
    'DEFAULT': 'https://searx.be/?q={}'
}

c.url.default_page = "about:blank"

#load_theme()

# load theme from xresources if desired
xresources = read_xresources('*')
load_from_xresources(xresources)
