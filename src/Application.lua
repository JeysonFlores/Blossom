--package.path = package.path .. ";/app/bin/alivio/?.lua;/app/share/lua/5.1/?.lua"
--package.cpath = package.cpath .. ";/app/lib/lua/5.1/?.so"

local lgi = require 'lgi'
local Gtk = lgi.require('Gtk')
local Gio = lgi.require('Gio')
local Granite = lgi.require('Granite')
local Gdk = lgi.require('Gdk')

require "src.MainWindow"

app = Gtk.Application {
    application_id = "com.github.jeysonflores.alivio"
}


function app:on_activate()
    main_window.application = self

    local settings = Gio.Settings {
        schema_id = app_id
    }

    screen = Gdk.Screen.get_default()
    provider = Gtk.CssProvider{}
    
    local granite_settings = Granite.Settings{}
    local gtk_settings = Gtk.Settings:get_default()
    

    if granite_settings.prefers_color_scheme == "DARK" then
        gtk_settings.gtk_application_prefer_dark_theme = true
        provider:load_from_path("/home/jeyson/Proyectos/Lua/Blossom/data/style-dark.css")
        Gtk.StyleContext.add_provider_for_screen(screen, provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION)
    else
        gtk_settings.gtk_application_prefer_dark_theme = false
        provider:load_from_path("/home/jeyson/Proyectos/Lua/Blossom/data/style.css")
        Gtk.StyleContext.add_provider_for_screen(screen, provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION)
    end

    granite_settings.on_notify["prefers-color-scheme"] = function(self, pspec)
        if granite_settings.prefers_color_scheme == "DARK" then
            gtk_settings.gtk_application_prefer_dark_theme = true
            provider:load_from_path("/home/jeyson/Proyectos/Lua/Blossom/data/style-dark.css")
            Gtk.StyleContext.add_provider_for_screen(screen, provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION)
        else
            gtk_settings.gtk_application_prefer_dark_theme = false
            provider:load_from_path("/home/jeyson/Proyectos/Lua/Blossom/data/style.css")
            Gtk.StyleContext.add_provider_for_screen(screen, provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION)
        end
    end

    main_window:resize(settings:get_int("window-width"), settings:get_int("window-height"))
    main_window:move(settings:get_int("pos-x"), settings:get_int("pos-y"))
    
    main_window:show_all()
end
