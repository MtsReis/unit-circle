class.Triangle()

-- Default properties
Triangle.x = love.graphics.getWidth() / 2 / scale
Triangle.y = love.graphics.getHeight() / 2 / scale
Triangle.base = 1
Triangle.height = 0.5
Triangle.color = {r = 155, g = 155, b = 155, a = 155}
Triangle.drawMode = "fill"
Triangle.blendMode = "alpha"

function Triangle:draw(dt)
	-- Save the corrent LÖVE color and blendmode
	local rD, gD, bD, aD = love.graphics.getColor()
	local blendD = love.graphics.getBlendMode()

	-- Print the object and its info
	love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
	love.graphics.setBlendMode(self.blendMode)
	love.graphics.polygon("fill", e(self.x), e(self.y), e(self.x + self.base), e(self.y), e(self.x + self.base), e(self.y - self.height))

	-- Restore to the previous color and blendmode
	love.graphics.setColor(rD, gD, bD, aD)
	love.graphics.setBlendMode(blendD)
end
