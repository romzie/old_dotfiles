import i3ipc
import re
import getpass

i3 = i3ipc.Connection()

user = getpass.getuser()

to_remove = [' - mozilla firefox', 'vim ']

def get_ws_icon(e):
    focused_window = i3.get_tree().find_focused()

    title = focused_window.name.lower()
    w_class = focused_window.window_class

    if w_class is None:
        return ''

    for s in to_remove:
        title = title.replace(s, '')

    title = title.replace('/home/{}'.format(user), '~')
    title = re.sub(r'@.*:', ':', title)

    return title

def on_window_title(i3, e):
    print(get_ws_icon(e))

i3.on("window::focus", on_window_title)
i3.on("window::title", on_window_title)
i3.on("window::close", on_window_title)
i3.on("workspace", on_window_title)

i3.main()
