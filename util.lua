--[[Return the arg with the right scale
todo: Check the possibility of using metatables]]--
function e(value)
	return value * scale
end

function gridDraw()
	-- Save the corrent LÖVE color
	local rD, gD, bD, aD = love.graphics.getColor()

	-- Get screen dimensions
	screenW = love.graphics.getWidth()
	screenH = love.graphics.getHeight()

	-- Define the size of decimals
	gridLength = scale / 10

	-- Vertical lines
	line = 0
	for xPos = screenW/2, screenW, gridLength do
		line = drawGridLine(line, xPos, true)
	end

	line = 0
	for xPos = screenW/2, 0, -gridLength do
		line = drawGridLine(line, xPos, true)
	end

	-- Horizontal lines
	line = 0
	for yPos = screenH/2, screenH, gridLength do
		line = drawGridLine(line, yPos, false)
	end

	line = 0
	for yPos = screenH/2, 0, -gridLength do
		line = drawGridLine(line, yPos, false)
	end

	-- Restore to the previous color
	love.graphics.setColor(rD, gD, bD, aD)
end

function drawGridLine(lineNumber, pos, vert)
	-- Apply the decimals color
	love.graphics.setColor(255, 255, 255, 55)

	if lineNumber == 0 or lineNumber % 10 == 0 then
		-- unit color
		love.graphics.setColor(255, 255, 255, 100)
	end

	-- Draw the line
	if vert then
		love.graphics.line(pos, 0, pos, love.graphics.getHeight())
	else
		love.graphics.line(0, pos, love.graphics.getWidth(), pos)
	end

	return lineNumber + 1
end

function setAngle(targetx, targety)
	opposite = love.graphics.getHeight()/2 - targety
	adjacent = targetx - love.graphics.getWidth()/2

	arcTg = math.atan2(opposite, adjacent)

	if arcTg < 0 then
		angle = 360 + math.deg(arcTg)
	else
		angle = math.deg(arcTg)
	end
end
