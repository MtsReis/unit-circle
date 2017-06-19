--[[Retorna argumento com escala correta.
todo: Verificar possibilidade do uso de metatables]]--
function e(valor)
	return valor * escala
end

function gridDraw()
	-- Armazena cor atual.
	local rD, gD, bD, aD = love.graphics.getColor()

	-- Cor dos décimos
	love.graphics.setColor(255, 255, 255, 100)

	screenW = love.graphics.getWidth()
	screenH = love.graphics.getHeight()
	gridLength = escala / 10
	xOffset = (screenW % escala) / 2
	yOffset = (screenH % escala) / 20

	for xPos = 0, screenW, gridLength do
		if (xPos - xOffset) % escala == 0 then
			love.graphics.setColor(255, 255, 255, 255)
		end
		
		love.graphics.line(xPos, 0, xPos, screenH)
		
		love.graphics.setColor(255, 255, 255, 100)
	end

	for yPos = 0, screenH, gridLength do
		if (yPos - yOffset) % escala == 0 then
			love.graphics.setColor(255, 255, 255, 255)
		end
		love.graphics.line(0, yPos, screenW, yPos)
		
		love.graphics.setColor(255, 255, 255, 100)
	end
	
	-- Retorna a cor e BlendMode aos valores anteriores.
	love.graphics.setColor(rD, gD, bD, aD)
	
	love.graphics.print(0, 10, 5 * 80, 0, 5)
end