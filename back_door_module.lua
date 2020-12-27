btn = { -- {x, y, w, h, btntext, channel}
    {5, 24, 12, 7, "SI", 1}, -- Slider moving in - Channel 1
    {21, 24, 22, 7, "LCK", 2}, -- Stop slider - Channel 3
    {47, 24, 12, 7, "SO", 3}, -- Slider moving out - Channel 2

    {5, 5, 20, 7, "HUP", 4}, -- Hatch Moving up - Channel 4
    {5, 14, 20, 7, "HDN", 4}, -- Hatch Moving down - Channel 4

    {39, 5, 20, 7, "MUP", 5}, -- Main Moving up - Channel 5
    {39, 14, 20, 7, "MDN", 5} -- Main Moving up - Channel 5
}

lock = true
function switchLock()
    if lock == true then
        lock = false
    else
        lock = true
    end
    return lock
end

-- function rb(btnW, btnH, what)
--     w = screen.getWidth()
--     h = screen.getHeight()
--     if w>h then
--         scale = w/btnW
--         if (btnH*scale)>h then
--             scale = h/btnH
--         end
--     else
--         scale = h / btnH;
--         if btnW * scale > w then
--             scale = w / btnW;
--         end
--     end
    
--     if what == "w" then
--         return math.floor(btnW * scale)
--     end

--     return math.floor(btnH * scale)
-- end

function onTick()
    -- Read the touchscreen data from the script's composite input
    inputX = input.getNumber(3)
    inputY = input.getNumber(4)
    isPressed = input.getBool(1)
    canBeLocked = input.getBool(3)

    -- Check if the player is pressing the rectangles with relative widths and heights
    -- Slider
    isPressingRectangle1 = isPressed and isPointInRectangle(inputX, inputY, btn[1][1], btn[1][2], btn[1][3], btn[1][4])
    isPressingRectangle2 = isPressed and isPointInRectangle(inputX, inputY, btn[2][1], btn[2][2], btn[2][3], btn[2][4]) -- Lock
    isPressingRectangle3 = isPressed and isPointInRectangle(inputX, inputY, btn[3][1], btn[3][2], btn[3][3], btn[3][4])

    -- Hatch
    isPressingRectangle4 = isPressed and isPointInRectangle(inputX, inputY, btn[4][1], btn[4][2], btn[4][3], btn[4][4])
    isPressingRectangle5 = isPressed and isPointInRectangle(inputX, inputY, btn[5][1], btn[5][2], btn[5][3], btn[5][4])

    -- Main Door
    isPressingRectangle6 = isPressed and isPointInRectangle(inputX, inputY, btn[6][1], btn[6][2], btn[6][3], btn[6][4])
    isPressingRectangle7 = isPressed and isPointInRectangle(inputX, inputY, btn[7][1], btn[7][2], btn[7][3], btn[7][4])

    -- Set the composite output, on/off channel 1
    output.setBool(btn[1][6], isPressingRectangle1)
    if isPressingRectangle2 then
        output.setBool(btn[2][6], switchLock())
    end
    output.setBool(btn[3][6], isPressingRectangle3)

    if isPressingRectangle4 then
        output.setNumber(btn[4][6], -1)
    elseif isPressingRectangle5 then
        output.setNumber(btn[5][6], 1)
    elseif isPressingRectangle6 then
         output.setNumber(btn[6][6], -1)
    elseif isPressingRectangle7 then
        output.setNumber(btn[7][6], 1)
    else
        output.setNumber(4, 0) -- Stop Hatch
        output.setNumber(5, 0) -- Stop Main Door
    end

end

-- Returns true if the point (x, y) is inside the rectangle at (rectX, rectY) with width rectW and height rectH
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
    return x > rectX and y > rectY and x < rectX + rectW and y < rectY + rectH
end

function onDraw()

    -- Scale buttons
    -- for i=1, #btn do
    --     btn[i][1] = btn[i][1] + rb(btn[i][3], btn[i][4], "w") -- X
    --     btn[i][2] = btn[i][2] + rb(btn[i][3], btn[i][4], "h") -- Y
    --     btn[i][3] = rb(btn[i][3], btn[i][4], "w") -- Width
    --     btn[i][4] = rb(btn[i][3], btn[i][4], "h") -- Height
    -- end

    -- Draw a rectangle that fills in when the player is pressing it
    if isPressingRectangle1 then
        screen.setColor(0, 200, 0)
        screen.drawRectF(btn[1][1], btn[1][2], btn[1][3], btn[1][4])
        screen.setColor(255, 255, 255)
        screen.drawTextBox(btn[1][1], btn[1][2], btn[1][3], btn[1][4], btn[1][5], 0, 0)
    elseif isPressingRectangle3 then
        screen.setColor(0, 200, 0)
        screen.drawRectF(btn[3][1], btn[3][2], btn[3][3], btn[3][4])
        screen.setColor(255, 255, 255)
        screen.drawTextBox(btn[3][1], btn[3][2], btn[3][3], btn[3][4], btn[3][5], 0, 0)
    elseif isPressingRectangle4 then
        screen.setColor(0, 200, 0)
        screen.drawRectF(btn[4][1], btn[4][2], btn[4][3], btn[4][4])
        screen.setColor(255, 255, 255)
        screen.drawTextBox(btn[4][1], btn[4][2], btn[4][3], btn[4][4], btn[4][5], 0, 0)
    elseif isPressingRectangle5 then
        screen.setColor(0, 200, 0)
        screen.drawRectF(btn[5][1], btn[5][2], btn[5][3], btn[5][4])
        screen.setColor(255, 255, 255)
        screen.drawTextBox(btn[5][1], btn[5][2], btn[6][3], btn[5][4], btn[5][5], 0, 0)
    elseif isPressingRectangle6 then
        screen.setColor(0, 200, 0)
        screen.drawRectF(btn[6][1], btn[6][2], btn[6][3], btn[6][4])
        screen.setColor(255, 255, 255)
        screen.drawTextBox(btn[6][1], btn[6][2], btn[6][3], btn[6][4], btn[6][5], 0, 0)
    elseif isPressingRectangle7 then
        screen.setColor(0, 200, 0)
        screen.drawRectF(btn[7][1], btn[7][2], btn[7][3], btn[7][4])
        screen.setColor(255, 255, 255)
        screen.drawTextBox(btn[7][1], btn[7][2], btn[7][3], btn[7][4], btn[7][5], 0, 0)
    end

    if isPressingRectangle2 or lock then
        screen.setColor(0, 200, 0)
        screen.drawRectF(btn[2][1], btn[2][2], btn[2][3], btn[2][4])
        screen.setColor(255, 255, 255)
        screen.drawTextBox(btn[2][1], btn[2][2], btn[2][3], btn[2][4], btn[2][5], 0, 0)
    end

    for i=1, #btn do
        if i ~= 2 then
            screen.drawRect(btn[i][1], btn[i][2], btn[i][3], btn[i][4])
            screen.drawTextBox(btn[i][1], btn[i][2], btn[i][3], btn[i][4], btn[i][5], 0, 0)
        else
            if canBeLocked then
                screen.drawRect(btn[i][1], btn[i][2], btn[i][3], btn[i][4])
                screen.drawTextBox(btn[i][1], btn[i][2], btn[i][3], btn[i][4], btn[i][5], 0, 0)
            end
        end
    end
end
