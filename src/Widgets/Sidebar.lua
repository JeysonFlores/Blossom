

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
    name = "All Items"
}
all_item.icon = Gio.Icon.new_for_string("mail-mailbox-symbolic")

favorites_item = Granite.WidgetsSourceListItem{
    name = "Favorites"
}
favorites_item.icon = Gio.Icon.new_for_string("help-about-symbolic")

favorites_category = Granite.WidgetsSourceListExpandableItem{
    name = "Favorites"
}

favorites_category:expand_all()
favorites_category:add(all_item)
favorites_category:add(favorites_item)

logins_item = Granite.WidgetsSourceListItem{
    name = "Logins"
}
logins_item.icon = Gio.Icon.new_for_string("dialog-password-symbolic")

credit_cards_item = Granite.WidgetsSourceListItem{
    name = "Credit Cards"
}
credit_cards_item.icon = Gio.Icon.new_for_string("payment-card-symbolic")

identities_item = Granite.WidgetsSourceListItem{
    name = "Identities"
}
identities_item.icon = Gio.Icon.new_for_string("avatar-default-symbolic")

location_category = Granite.WidgetsSourceListExpandableItem{
    name = "Categories"
}


location_category:expand_all()
location_category:add(logins_item)
location_category:add(credit_cards_item)
location_category:add(identities_item)


source_list = Granite.WidgetsSourceList{
    root = Granite.WidgetsSourceListExpandableItem {
        name = "root"
    }
}
root = source_list.root
root:add(favorites_category)
root:add(location_category)

grid = Gtk.Grid{
    expand = true,
    orientation = Gtk.Orientation.VERTICAL
}

grid:add(sidebar_header)
grid:add(source_list)

sidebar = Gtk.EventBox{}
sidebar:add(grid)
sidebar:get_style_context():add_class(Gtk.STYLE_CLASS_SIDEBAR)
