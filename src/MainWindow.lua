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


code_grid = Gtk.Grid{
    expand = true,
    orientation = Gtk.Orientation.VERTICAL
}

code_grid:add(Gtk.Label{
    label = "Lista de Comandos"
})

paned_start = Gtk.Paned{
    orientation = Gtk.Orientation.HORIZONTAL
}
paned_start:pack1(sidebar, false, false);
paned_start:pack2(code_grid, true, false);

command_grid = Gtk.Grid{
    expand = true,
    orientation = Gtk.Orientation.VERTICAL
}

command_grid:add(Gtk.Label{
    label = "Detalle de Comandos"
})

paned_end = Gtk.Paned{
    orientation = Gtk.Orientation.HORIZONTAL
}

paned_end:pack1(paned_start, false, false);
paned_end:pack2(command_grid, false, false);


main_window:add(paned_end)


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