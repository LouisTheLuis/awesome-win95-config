local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local battery_widget = wibox.widget {
    {
        {
            {
                id = "text",
                text = "50%",
                widget = wibox.widget.textbox,
            },
            id      = "theinnermargin",
            margins = beautiful.widget_margin_inner,
            widget  = wibox.container.margin,
        },
        id                 = "thebackground",
        bg                 = beautiful.bg_normal,
        shape_border_width = beautiful.widget_border_width,
        shape_border_color = beautiful.border_focus,
        widget             = wibox.container.background,
        layout = wibox.layout.align.horizontal,
    },
    id     = "theoutermargin",
    left   = beautiful.widget_margin_outer,
    right  = beautiful.widget_margin_outer,
    widget = wibox.container.margin,
}

local text = battery_widget:get_children_by_id("text")[1]
-- local progressbar = battery_widget:get_children_by_id("progress_bar")[1]
mytimer = timer({ timeout = 30 })
mytimer:connect_signal("timeout", function()
                                      f = io.popen('acpi -b', r)
                                      --s, p = string.match(f:read(), 'Battery %d: (%w+), (%d+)%%') 
                                      state, percent = string.match(f:read(), 'Battery %d: (%w+), (%d+)%%')
                                      f:close()
                                      text:set_text(state .. " | " .. percent .. "%")
                                      percent = tonumber(percent)/100
                                    --   progressbar:set_value(percent)
                                  end)
mytimer:start()
mytimer:emit_signal("timeout")

return battery_widget

    -- {
    --     id     = "progress_bar",
    --     widget = wibox.widget.progressbar,
    --     color  = "#000000",
    --     background_color = beautiful.bg_normal,
    --     border_color = "#000000",
    --     border_width = 2,
    --     forced_width = 40,
    --     clip = 1,R
    --     paddings = 1,
    --     margins = {
    --         top = 3,
    --         bottom = 3,
    --         left = 3,
    --         right = 3,
    --     },
    --     visible = 0,
    -- },
