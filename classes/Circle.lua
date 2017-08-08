class.Circle()

-- Default properties
Circle.x = love.graphics.getWidth() / 2 / scale
Circle.y = love.graphics.getHeight() / 2 / scale
Circle.radius = 1
Circle.color = {r = 155, g = 155, b = 155, a = 255}
Circle.drawMode = "line"
Circle.blendMode = "alpha"

function Circle:draw(dt)
	-- Save the corrent LÖVE color and blendmode
	local rD, gD, bD, aD = love.graphics.getColor()
	local blendD = love.graphics.getBlendMode()

	-- Print the object and its info
	love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
	love.graphics.setBlendMode(self.blendMode)
	love.graphics.circle(self.drawMode, e(self.x), e(self.y), e(self.radius))

	-- Restore to the previous color and blendmode
	love.graphics.setColor(rD, gD, bD, aD)
	love.graphics.setBlendMode(blendD)
end
