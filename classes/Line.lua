class.Line()

-- Propriedades padrões
Line.x1 = love.graphics.getWidth() / 2 / scale
Line.y1 = love.graphics.getHeight() / 2 / scale
Line.x2 = Line.x1 + 1
Line.y2 = Line.y1
Line.color = {r = 255, g = 255, b = 255, a = 255}
Line.info = ''
Line.blendMode = "alpha"

function Line:draw(dt)
	-- Save the corrent LÖVE color and blendmode
	local rD, gD, bD, aD = love.graphics.getColor()
	local blendD = love.graphics.getBlendMode()

	if self.info ~= '' and self.info ~= nil then
		infoPos = infoPos + 1
	end

	-- Apply the object color and blendmode
	love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
	love.graphics.setBlendMode(self.blendMode)

	-- Print the object and its info
	love.graphics.line(e(self.x1), e(self.y1), e(self.x2), e(self.y2))
	love.graphics.print(self.info, 10, infoPos * 80, 0, 5)

	-- Restore to the previous color and blendmode
	love.graphics.setColor(rD, gD, bD, aD)
	love.graphics.setBlendMode(blendD)
end
