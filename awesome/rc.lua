--[[

     Awesome WM configuration

--]]

-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")

local config        = require("config")
-- }}}

-- {{{ Localize date/time
os.setlocale(os.getenv("LANG"))
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

local themes = {
    "multicolor",        -- 1
    "darkblue",          -- 2
    "blackout",          -- 3
    "powerarrow-gruvbox" -- 4
}
context.theme = themes[4]

context.keys = { }
context.keys.modkey = "Mod4"
context.keys.altkey = "Mod1"

-- {{{ Variable definitions

context.vars = { }
context.vars.scripts_dir = os.getenv("HOME") .. "/.bin"

context.vars.terminal        = "urxvt"
context.vars.editor          = os.getenv("EDITOR") or "vim"
context.vars.gui_editor      = "code"
context.vars.browser         = "firefox"
context.vars.rofi_settings   = "rofi -show combi"

context.vars.tags = { " www ", " </> ", " >_ ", " etc ", " # " }
context.vars.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    --lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    lain.layout.termfair,
    --lain.layout.termfair.center,
}

awful.util.terminal = context.vars.terminal
awful.util.tagnames = context.vars.tags
awful.layout.layouts = context.vars.layouts

-- }}}

config.util.init(context)

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), context.theme)
beautiful.init(theme_path)

config.widgets.init(context)
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

