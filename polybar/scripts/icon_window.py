import i3ipc

i3 = i3ipc.Connection()

def get_ws_icon(e):
    default_icon = ''
    focused_window = i3.get_tree().find_focused()
    title = focused_window.name.lower()
    wclass = focused_window.window_class

    if wclass is None:
        return default_icon
    wclass = wclass.lower()


    if wclass in ['gnome-terminal']:
        if title.startswith('vim'): return ''
        if title == 'ranger': return ''
        if title == 'htop': return ''
        if title.startswith('python') or title.startswith('ipython'): return ''
        if title == 'wget': return ''
        if title.startswith('sudo apt'): return 'ﮮ'
        return ''

    if wclass in ['firefox']:
        title = title.replace(' - mozilla firefox', '')
        if title.endswith('github'): return ''
        if title.endswith('stack overflow'): return ''
        if title.endswith('youtube'): return ''
        if title.endswith('slack'): return ''
        if title.endswith('telegram web'): return ''
        if title.endswith('font awesome'): return ''
        return ''

    if wclass == 'slack': return ''
    if wclass == 'eog': return ''
    if wclass.endswith('nautilus'): return ''
    if wclass == 'gnome-control-center': return ''

    return default_icon

def on_window_title(i3, e):
    print(get_ws_icon(e))

i3.on("window::focus", on_window_title)
i3.on("window::title", on_window_title)
i3.on("window::close", on_window_title)
i3.on("workspace", on_window_title)

i3.main()
