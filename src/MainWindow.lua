--package.path = package.path .. ";/app/bin/alivio/?.lua;/app/share/lua/5.1/?.lua"
--package.cpath = package.cpath .. ";/app/lib/lua/5.1/?.so"

local lgi = require 'lgi'
local Gtk = lgi.require('Gtk')
local Handy = lgi.require('Handy')
local Gio = lgi.require('Gio')

require "src.Widgets.Sidebar"
require "src.Constants"
-- Window Building

Handy:init()


main_window = Handy.Window {}

main_window:add(sidebar)


function main_window:on_delete_event()
    
    local settings = Gio.Settings {
        schema_id = app_id
    }

    local root_x, root_y = main_window:get_position()
    local width, height = main_window:get_size()

    settings:set_int("pos-x", root_x)
    settings:set_int("pos-y", root_y)

    settings:set_int("window-width", width)
    settings:set_int("window-height", height)

    Gtk:main_quit()
end