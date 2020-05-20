from __future__ import (absolute_import, division, print_function)

from ranger.colorschemes.default import Default
from ranger.gui.color import (
    black, blue, cyan, green, magenta, red, white, yellow, default,
    normal, bold, reverse, dim, BRIGHT, default_colors,
)


class Scheme(Default):
    """
    black          is color 0
    red            is color 1
    green          is color 2
    yellow         is color 3
    blue           is color 4
    magenta        is color 5
    cyan           is color 6
    white          is color 7
    black BRIGHT   is color 8
    red BRIGHT     is color 9
    green BRIGHT   is color 10
    yellow BRIGHT  is color 11
    blue BRIGHT    is color 12
    magenta BRIGHT is color 13
    cyan BRIGHT    is color 14
    white BRIGHT   is color 15
    """

    def use(self, context):
        fg, bg, attr = Default.use(self, context)

        if context.in_browser:
            if context.media:
                if context.image:
                    fg = magenta
                else:
                    fg = magenta
                    fg += BRIGHT

            if context.directory:
                attr |= bold
                fg = blue
            elif context.executable and not \
                    any((context.media, context.container,
                         context.fifo, context.socket)):
                attr |= bold
                fg = green

            if context.fifo or context.device:
                fg = yellow
                if context.device:
                    attr |= bold

            if context.link:
                fg = cyan if context.good else red
                if not context.good:
                    bg = black

        return fg, bg, attr
