--[[

     Awesome WM configuration template
     github.com/lcpz

--]]

-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local beautiful     = require("beautiful")
local naughty       = require("naughty")

local config        = require("config")
-- }}}

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

config.context = { }
local context = config.context

context.vars = { }
context.vars.scripts_dir = os.getenv("HOME") .. "/.bin"

context.keys = { }
context.keys.modkey = "Mod4"
context.keys.altkey = "Mod1"

-- {{{ Variable definitions

local themes = {
    "multicolor",      -- 1
    "darkblue"         -- 2
}
context.theme                = themes[2]
context.vars.terminal        = "urxvt"
context.vars.editor          = os.getenv("EDITOR") or "vim"
context.vars.gui_editor      = "code"
context.vars.browser         = "google-chrome-stable"
context.vars.rofi_settings   = "rofi -show combi"

awful.util.terminal = context.vars.terminal

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), context.theme)
beautiful.init(theme_path)
-- }}}

config.widgets.init(context)
config.util.init(context)
config.menu.init(context)
config.keys.init(context)
config.keys_client.init(context)
config.rules.init(context)
config.signals.init(context)
config.screen.init(context)

-- {{{ Autostart windowless processes

context.util.run_once({
    "unclutter -root",
    "compton --config ~/.config/compton.conf",
    "nm-applet --sm-disable",
    "xautolock -time 10 -locker '/usr/bin/betterlockscreen -l dimblur'"
})

-- }}}

