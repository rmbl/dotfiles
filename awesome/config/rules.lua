local awful = require("awful")
local beautiful = require("beautiful")

local config = {}

function config.init(context)

    -- Rules to apply to new clients (through the "manage" signal).
    awful.rules.rules = {
        -- All clients will match this rule.
        {
            rule = { },
            properties = {
                border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                focus = awful.client.focus.filter,
                raise = true,
                keys = context.keys.client,
                buttons = context.mouse.client,
                screen = awful.screen.preferred,
                placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                size_hints_honor = false,
                titlebars_enabled = true
            }
        },

        -- Titlebars
        {
            rule_any = { type = { "dialog", "normal" } },
            properties = { titlebars_enabled = true }
        },


        -- No borders if maximized
        {
            rule = {
                maximized = true,
            },
            properties = {
                border_width = 0,
            },
        },

        -- Set Firefox to always map on the first tag on screen 1.
        {
            rule = { class = "Firefox" },
            properties = { screen = 1, tag = awful.util.tagnames[1] }
        },

        {
            rule = { class = "Gimp", role = "gimp-image-window" },
            properties = { maximized = true }
        },

                -- Clients that should float
        {
            rule_any = {
                class = {
                    "Git-gui",
                    "feh",
                    "Lxappearance",
                    "Lxsession-edit",
                    "Lxsession-default-apps",
                    "Oomox",
                    "Gpick",
                    "System-config-printer.py",
                    "Pinentry",
                    "Event Tester",
                    "alsamixer",
                },
                name = {
                    "Event Tester",
                },
            },
            properties = {
                floating = true,
                placement = awful.placement.centered,
            },
        },
    }

end

return config
