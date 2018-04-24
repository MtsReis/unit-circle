class.Arc()

-- Default properties
Arc.x = love.graphics.getWidth() / 2 / scale
Arc.y = love.graphics.getHeight() / 2 / scale
Arc.angle1 = 0
Arc.angle2 = 90
Arc.radius = 1
Arc.color = {r = 200, g = 255, b = 255, a = 255}
Arc.info = ''
Arc.infoPrefix = ''
Arc.infoSufix = ''
Arc.importantAngles = {}
Arc.drawMode = "line"
Arc.blendMode = "alpha"

function Arc:draw(dt)
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
	love.graphics.arc(self.drawMode, e(self.x), e(self.y), e(self.radius), -math.rad(self.angle1), -math.rad(self.angle2))
	love.graphics.print(self.infoPrefix .. self.info .. self.infoSufix, 10, infoPos * 80, 0, 5)

	-- Restore to the previous color and blendmode
	love.graphics.setColor(rD, gD, bD, aD)
	love.graphics.setBlendMode(blendD)
end

function Arc:checkSufix(angleValue)
	if self.importantAngles[angleValue] then
		self.infoSufix = " (" .. self.importantAngles[angleValue] .. ")"
	else
		self.infoSufix = ""
	end
end
