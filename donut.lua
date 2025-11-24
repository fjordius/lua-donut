-- Learnt the importance of comments so I'll be using them more in my code.

local io = require("io")
local math = require("math")
local os = require("os")

local sin, cos = math.sin, math.cos
local pi = math.pi

local function main()
    local A = 0
    local B = 0
    
    -- Screen dimensions
    local screen_width = 80
    local screen_height = 22
    
    -- Clear screen sequence (ANSI)
    -- \27[2J clears the screen, \27[H moves cursor to top-left
    io.write("\27[2J")

    while true do
        local b = {} -- brightness buffer
        local z = {} -- z-buffer
        
        -- Initialize buffers
        for i = 0, screen_width * screen_height do
            b[i] = " "
            z[i] = 0
        end

        local cA = cos(A)
        local sA = sin(A)
        local cB = cos(B)
        local sB = sin(B)

        -- Theta goes around the cross-sectional circle of a torus
        for theta = 0, 2 * pi, 0.07 do
            local ct = cos(theta)
            local st = sin(theta)

            -- Phi goes around the center of revolution of a torus
            for phi = 0, 2 * pi, 0.02 do
                local cp = cos(phi)
                local sp = sin(phi)

                local h = ct + 2 -- R2 distance from torus center
                local D = 1 / (sp * h * sA + st * cA + 5) -- 1/z
                local t = sp * h * cA - st * sA

                -- Project to 2D screen coordinates
                local x = math.floor(screen_width / 2 + 30 * D * (cp * h * cB - t * sB))
                local y = math.floor(screen_height / 2 + 15 * D * (cp * h * sB + t * cB))
                
                local o = x + screen_width * y
                local N = math.floor(8 * ((st * sA - sp * ct * cA) * cB - sp * ct * sA - st * cA - cp * ct * sB))

                -- Update buffers if the point is visible
                if y > 0 and y < screen_height and x > 0 and x < screen_width and D > z[o] then
                    z[o] = D
                    -- ASCII luminance characters: .,-~:;=!*#$@
                    local chars = ".,-~:;=!*#$@"
                    local luminance_index = math.max(1, math.min(12, N + 1))
                    b[o] = string.sub(chars, luminance_index, luminance_index)
                end
            end
        end

        -- Render frame
        io.write("\27[H") -- Move cursor home
        for i = 0, screen_width * screen_height do
            io.write(b[i] or " ")
            if i % screen_width == screen_width - 1 then
                io.write("\n")
            end
        end
        
        io.flush()

        -- Rotate
        A = A + 0.04
        B = B + 0.02
        
        -- Simple delay hack to prevent 100% CPU usage and control speed
        local start = os.clock()
        while os.clock() - start < 0.03 do end
    end
end

main()
