local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local cyclefocus = require("cyclefocus")
local lain = require("lain")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local config = {}

function config.init(context)

    context.keys = context.keys or { }
    context.mouse = context.mouse or { }

    local modkey = context.keys.modkey
    local altkey = context.keys.altkey

    root.buttons(awful.util.table.join(
        awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
        awful.button({ }, 4, awful.tag.viewnext),
        awful.button({ }, 5, awful.tag.viewprev)
    ))

    globalkeys = awful.util.table.join(
        -- Take a screenshot
        -- https://github.com/lcpz/dots/blob/master/bin/screenshot
        awful.key({ altkey }, "p", function() os.execute("screenshot") end,
                  {description = "take a screenshot", group = "hotkeys"}),

        -- Hotkeys
        awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
                  {description = "show help", group="awesome"}),
        -- Tag browsing
        awful.key({ modkey,           }, "Left",
            function()
                for i = 1, screen.count() do
                    awful.tag.viewprev(i)
                end
            end,
            {description = "view previous", group = "tag"}),
        awful.key({ modkey,           }, "Right",
            function()
                for i = 1, screen.count() do
                    awful.tag.viewnext(i)
                end
            end,
            {description = "view next", group = "tag"}),
        awful.key({ modkey,           }, "Escape",
            function()
                for i = 1, screen.count() do
                    awful.tag.history.restore(i)
                end
            end,
            {description = "go back", group = "tag"}),

        -- Non-empty tag browsing
        awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
                  {description = "view  previous nonempty", group = "tag"}),
        awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
                  {description = "view  previous nonempty", group = "tag"}),

        -- Default client focus
        awful.key({ altkey,           }, "j",
            function ()
                awful.client.focus.byidx( 1)
            end,
            {description = "focus next by index", group = "client"}
        ),
        awful.key({ altkey,           }, "k",
            function ()
                awful.client.focus.byidx(-1)
            end,
            {description = "focus previous by index", group = "client"}
        ),

        -- By direction client focus
        awful.key({ modkey }, "j",
            function()
                awful.client.focus.bydirection("down")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus down", group = "client"}),
        awful.key({ modkey }, "k",
            function()
                awful.client.focus.bydirection("up")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus up", group = "client"}),
        awful.key({ modkey }, "h",
            function()
                awful.client.focus.bydirection("left")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus left", group = "client"}),
        awful.key({ modkey }, "l",
            function()
                awful.client.focus.bydirection("right")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus right", group = "client"}),
        awful.key({ modkey,           }, "q", function () awful.util.mymainmenu:show() end,
                  {description = "show main menu", group = "awesome"}),

        -- Layout manipulation
        awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
                  {description = "swap with next client by index", group = "client"}),
        awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
                  {description = "swap with previous client by index", group = "client"}),
        awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
                  {description = "focus the next screen", group = "screen"}),
        awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
                  {description = "focus the previous screen", group = "screen"}),
        awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
                  {description = "jump to urgent client", group = "client"}),

        -- Show/Hide Wibox
        awful.key({ modkey }, "b",
            function ()
                for s in screen do
                    s.mywibox.visible = not s.mywibox.visible
                    if s.mybottomwibox then
                        s.mybottomwibox.visible = not s.mybottomwibox.visible
                    end
                end
            end,
            {description = "toggle wibox", group = "awesome"}),

        -- On the fly useless gaps change
        awful.key({ altkey, "Control" }, "+", function () lain.util.useless_gaps_resize(1) end,
                  {description = "increment useless gaps", group = "tag"}),
        awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end,
                  {description = "decrement useless gaps", group = "tag"}),

        -- Dynamic tagging
        awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
                  {description = "add new tag", group = "tag"}),
        awful.key({ modkey, "Shift" }, "r", function () lain.util.rename_tag() end,
                  {description = "rename tag", group = "tag"}),
        awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
                  {description = "move tag to the left", group = "tag"}),
        awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
                  {description = "move tag to the right", group = "tag"}),
        awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end,
                  {description = "delete tag", group = "tag"}),

        -- Standard program
        awful.key({ modkey,           }, "Return", function () awful.spawn(context.vars.terminal) end,
                  {description = "open a terminal", group = "launcher"}),
        awful.key({ modkey, "Control" }, "r", awesome.restart,
                  {description = "reload awesome", group = "awesome"}),
        -- awful.key({ modkey, "Shift"   }, "q", awesome.quit,
        --          {description = "quit awesome", group = "awesome"}),

        awful.key({ altkey, "Shift"   }, "l",     function () awful.tag.incmwfact( 0.05)          end,
                  {description = "increase master width factor", group = "layout"}),
        awful.key({ altkey, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
                  {description = "decrease master width factor", group = "layout"}),
        awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
                  {description = "increase the number of master clients", group = "layout"}),
        awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
                  {description = "decrease the number of master clients", group = "layout"}),
        awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
                  {description = "increase the number of columns", group = "layout"}),
        awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
                  {description = "decrease the number of columns", group = "layout"}),
        awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
                  {description = "select next", group = "layout"}),
        awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
                  {description = "select previous", group = "layout"}),

        awful.key({ modkey, "Control" }, "n",
            function ()
                local c = awful.client.restore()
                -- Focus restored client
                if c then
                    client.focus = c
                    c:raise()
                end
            end,
            {description = "restore minimized", group = "client"}),

        -- Dropdown application
        awful.key({ modkey, }, "z", function () awful.screen.focused().quake:toggle() end,
                  {description = "dropdown application", group = "launcher"}),

        -- Widgets popups
        awful.key({ altkey, }, "c", function () lain.widget.calendar.show(7) end,
                  {description = "show calendar", group = "widgets"}),
        awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
                  {description = "show filesystem", group = "widgets"}),
        awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
                  {description = "show weather", group = "widgets"}),

        -- Brightness
        awful.key({ }, "XF86MonBrightnessUp", function () awful.util.spawn("brightnessctl set +10%") end,
                  {description = "+10%", group = "hotkeys"}),
        awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn("brightnessctl set 10%-") end,
                  {description = "-10%", group = "hotkeys"}),

        -- ALSA volume control
        awful.key({}, "XF86AudioRaiseVolume",
            function ()
                os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
                beautiful.volume.update()
            end),
        awful.key({ altkey }, "Up",
            function ()
                os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
                beautiful.volume.update()
            end,
            {description = "volume up", group = "hotkeys"}),
        awful.key({}, "XF86AudioLowerVolume",
            function ()
                os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
                beautiful.volume.update()
            end),
        awful.key({ altkey }, "Down",
            function ()
                os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
                beautiful.volume.update()
            end,
            {description = "volume down", group = "hotkeys"}),
        awful.key({}, "XF86AudioMute",
            function ()
                os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
                beautiful.volume.update()
            end,
            {description = "toggle mute", group = "hotkeys"}),
        awful.key({ altkey }, "m",
            function ()
                os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
                beautiful.volume.update()
            end,
            {description = "toggle mute", group = "hotkeys"}),
        awful.key({ altkey, "Control" }, "m",
            function ()
                os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
                beautiful.volume.update()
            end,
            {description = "volume 100%", group = "hotkeys"}),
        awful.key({ altkey, "Control" }, "0",
            function ()
                os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
                beautiful.volume.update()
            end,
            {description = "volume 0%", group = "hotkeys"}),

        -- Copy primary to clipboard (terminals to gtk)
        awful.key({ modkey }, "c", function () awful.util.spawn("xsel | xsel -i -b") end,
                  {description = "copy terminal to gtk", group = "hotkeys"}),    -- Copy clipboard to primary (gtk to terminals)
        awful.key({ modkey }, "v", function () awful.util.spawn("xsel -b | xsel") end,
                  {description = "copy gtk to terminal", group = "hotkeys"}),

        -- User programs
        awful.key({ modkey }, "e", function () awful.util.spawn(context.vars.gui_editor) end,
                  {description = "run gui editor", group = "launcher"}),
        awful.key({ modkey }, "w", function () awful.util.spawn(context.vars.browser) end,
                  {description = "run browser", group = "launcher"}),

        -- Lock screen
        awful.key({ modkey, "Control" }, "l", function () awful.util.spawn("xautolock -locknow") end,
                  {description = "Lock screen", group = "screen"}),
        awful.key({ modkey, "Control" }, "q", function () awful.util.spawn(context.vars.scripts_dir .. "/rofi-session") end,
                  {description = "session action prompt", group = "launcher"}),

        -- Prompt
        awful.key({ modkey }, "r", function () awful.screen.focused().mypromptbox:run() end,
                  {description = "run prompt", group = "launcher"}),

        awful.key({ modkey }, "x", function () awful.util.spawn(context.vars.rofi_settings) end,
                  {description = "rofi prompt", group = "launcher"}),

        -- Cyclefocus
        awful.key({ modkey }, "Tab", function(c) cyclefocus.cycle({modifier="Super_L"}) end),
        awful.key({ modkey, "Shift" }, "Tab", function(c) cyclefocus.cycle({modifier="Super_L"}) end)
    )

    -- Bind all key numbers to tags.
    -- Be careful: we use keycodes to make it works on any keyboard layout.
    -- This should map on the top row of your keyboard, usually 1 to 9.
    for i = 1, 9 do
        -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
        local descr_view, descr_toggle, descr_move, descr_toggle_focus
        if i == 1 or i == 9 then
            descr_view = {description = "view tag #", group = "tag"}
            descr_toggle = {description = "toggle tag #", group = "tag"}
            descr_move = {description = "move focused client to tag #", group = "tag"}
            descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
        end

        globalkeys = awful.util.table.join(globalkeys,
            -- View tag only.
            awful.key({ modkey }, "#" .. i + 9,
                function ()
                    for screen = 1, screen.count() do
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                            tag:view_only()
                        end
                    end
                end,
                descr_view),
            -- Toggle tag display.
            awful.key({ modkey, "Control" }, "#" .. i + 9,
                function ()
                    for screen = 1, screen.count() do
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                            awful.tag.viewtoggle(tag)
                        end
                    end
                end,
                descr_toggle),
            -- Move client to tag.
            awful.key({ modkey, "Shift" }, "#" .. i + 9,
                function ()
                    if client.focus then
                        local tag = client.focus.screen.tags[i]
                        if tag then
                            client.focus:move_to_tag(tag)
                        end
                    end
                end,
                descr_move),
            -- Toggle tag on focused client.
            awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                function ()
                    if client.focus then
                        local tag = client.focus.screen.tags[i]
                        if tag then
                            client.focus:toggle_tag(tag)
                        end
                    end
                end,
                descr_toggle_focus)
        )
    end

    root.keys(globalkeys)

end

return config
