local awful = require("awful")
local beautiful = require("beautiful")
local freedesktop = require("freedesktop")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local config = {}

function config.init(context)

    local myawesomemenu = {
        { "hotkeys", function() return false, hotkeys_popup.show_help end },
        { "manual", context.vars.terminal .. " -e man awesome" },
        { "edit config", string.format("%s -e %s %s", context.vars.terminal, context.vars.editor, awesome.conffile) },
        { "restart", awesome.restart },
        { "quit", function() awesome.quit() end }
    }
    awful.util.mymainmenu = freedesktop.menu.build({
        icon_size = beautiful.menu_height or 16,
        before = {
            { "Awesome", myawesomemenu, beautiful.awesome_icon },
            -- other triads can be put here
        },
        after = {
            { "Open terminal", context.vars.terminal },
            -- other triads can be put here
        }
    })

    -- Set the Menubar terminal for applications that require it
    menubar.utils.terminal = context.vars.terminal

end

return config
