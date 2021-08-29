

local lgi = require 'lgi'
local Gtk = lgi.require('Gtk')
local Handy = lgi.require('Handy')
local Gio = lgi.require('Gio')
local Granite = lgi.require('Granite')
local GLib = lgi.require('GLib')

sidebar_header = Handy.HeaderBar{}
sidebar_header.decoration_layout = "close:"
sidebar_header.has_subtitle = false
sidebar_header.show_close_button = true
sidebar_header:get_style_context():add_class(Gtk.STYLE_CLASS_FLAT);

all_item = Granite.WidgetsSourceListItem{
    name = "All Commands",
    badge = "15"
}
all_item.icon = Gio.Icon.new_for_string("utilities-terminal-symbolic")

favorites_item = Granite.WidgetsSourceListItem{
    name = "Favorites",
    badge = "5"
}
favorites_item.icon = Gio.Icon.new_for_string("help-about-symbolic")

settings_item = Granite.WidgetsSourceListItem{
    name = "Settings"
}
settings_item.icon = Gio.Icon.new_for_string("emblem-system-symbolic")

about_item = Granite.WidgetsSourceListItem{
    name = "About"
}
about_item.icon = Gio.Icon.new_for_string("dialog-information-symbolic")

home_category = Granite.WidgetsSourceListExpandableItem{
    name = "Home",
    expanded = true,
    collapsible = false
}

home_category:expand_all()
home_category:add(all_item)
home_category:add(favorites_item)
home_category:add(settings_item)
home_category:add(about_item)

logins_item = Granite.WidgetsSourceListItem{
    name = "Blossom",
    badge = "2"
}
logins_item.icon = Gio.Icon.new_for_string("mail-mark-important-symbolic")

credit_cards_item = Granite.WidgetsSourceListItem{
    name = "Flatpak",
    badge = "5"
}
credit_cards_item.icon = Gio.Icon.new_for_string("mail-mark-important-symbolic")

identities_item = Granite.WidgetsSourceListItem{
    name = "Scripts",
    badge = "8"
}
identities_item.icon = Gio.Icon.new_for_string("mail-mark-important-symbolic")

tags_category = Granite.WidgetsSourceListExpandableItem{
    name = "Tags",
}


tags_category:expand_all()
tags_category:add(logins_item)
tags_category:add(credit_cards_item)
tags_category:add(identities_item)


source_list = Granite.WidgetsSourceList{
    root = Granite.WidgetsSourceListExpandableItem {
        name = "root"
    }
}
root = source_list.root
root:add(home_category)
root:add(tags_category)

grid = Gtk.Grid{
    expand = true,
    orientation = Gtk.Orientation.VERTICAL
}

grid:add(sidebar_header)
grid:add(source_list)

sidebar = Gtk.EventBox{}
sidebar:add(grid)
sidebar:get_style_context():add_class(Gtk.STYLE_CLASS_SIDEBAR)
