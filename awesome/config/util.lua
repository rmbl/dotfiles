local awful = require("awful")
local beautiful = require("beautiful")

local config = {}

function config.init(context)

    context.util = context.util or {}

    context.util.run_once = function(cmd_arr)
        for _, cmd in ipairs(cmd_arr) do
            findme = cmd
            firstspace = cmd:find(" ")
            if firstspace then
                findme = cmd:sub(0, firstspace-1)
            end
            awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
        end
    end

    context.util.spawn_once = function(args)
        if not args and args.command then return end
        args.callback = args.callback or function() end

        -- Create move callback
        local f
        f = function(c)
            if c.class == args.class then
                c:move_to_tag(tag)
                client.disconnect_signal("manage", f)
                args.callback(c)
            end
        end
        client.connect_signal("manage", f)

        -- Now check if not already running
        local findme = args.command
        local firstspace = findme:find(" ")
        if firstspace then
            findme = findme:sub(0, firstspace-1)
        end

        awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, args.command))
    end

    context.util.easy_async_with_unfocus = function(cmd, callback)
        local c = client.focus
        callback = callback or function() end
        if c then c:emit_signal("unfocus") end
        awful.spawn.easy_async(cmd, function(stdout, stderr, reason, exit_code)
            callback(stdout, stderr, reason, exit_code)
            if c then c:emit_signal("focus") end
        end)
    end

end

return config
