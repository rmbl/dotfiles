local awful = require("awful")
local beautiful = require("beautiful")
local lain = require("lain")

local config = {}

function config.init(context)

    awful.util.tagnames = { " www ", " </> ", " >_ ", " etc ", " # " }
    awful.layout.layouts = {
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
    awful.util.taglist_buttons = awful.util.table.join(
        awful.button({ }, 1, function(t)
            local i = awful.tag.getidx(t)
            for screen = 1, screen.count() do
                local tag = awful.tag.gettags(screen)[i]
                if tag then
                    awful.tag.viewonly(tag)
                end
            end
        end),
        awful.button({ modkey }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
        awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),
        awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
    )
    awful.util.tasklist_buttons = awful.util.table.join(
        awful.button({ }, 1, function (c)
            if c == client.focus then
                c.minimized = true
            else
                -- Without this, the following
                -- :isvisible() makes no sense
                c.minimized = false
                if not c:isvisible() and c.first_tag then
                    c.first_tag:view_only()
                end
                -- This will also un-minimize
                -- the client, if needed
                client.focus = c
                c:raise()
            end
        end),
        awful.button({ }, 3, function()
            local instance = nil

            return function ()
                if instance and instance.wibox.visible then
                    instance:hide()
                    instance = nil
                else
                    instance = awful.menu.clients({ theme = { width = 250 } })
                end
            end
        end),
        awful.button({ }, 4, function ()
            awful.client.focus.byidx(1)
        end),
        awful.button({ }, 5, function ()
            awful.client.focus.byidx(-1)
        end))

    lain.layout.termfair.nmaster           = 3
    lain.layout.termfair.ncol              = 1
    lain.layout.termfair.center.nmaster    = 3
    lain.layout.termfair.center.ncol       = 1
    lain.layout.cascade.tile.offset_x      = 2
    lain.layout.cascade.tile.offset_y      = 32
    lain.layout.cascade.tile.extra_padding = 5
    lain.layout.cascade.tile.nmaster       = 5
    lain.layout.cascade.tile.ncol          = 2

end

return config
