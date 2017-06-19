--[[Retorna argumento com escala correta.
todo: Verificar possibilidade do uso de metatables]]--
function e(valor)
	return valor * escala
end

function gridDraw()
	-- Armazena cor atual.
	local rD, gD, bD, aD = love.graphics.getColor()

	-- Cor das unidades
	love.graphics.setColor(255, 255, 255, 100)

	-- Pega dimensões da tela
	screenW = love.graphics.getWidth()
	screenH = love.graphics.getHeight()

	-- Define o tamanho de cada unidade
	gridLength = escala / 10

	-- Valor que compensa posicionamento do grid caso as dimensões da tela não sejam divisíveis pelo gridLength
	xOffset = (screenW % gridLength) / 2
	yOffset = math.floor((screenH % gridLength) / 2)

	-- Número de unidades que restam após dividir grid em dezenas
	xRemainingGrids = math.ceil((screenW % escala) / gridLength)
	xOffsetUnidades = xRemainingGrids / 2 * gridLength
	yRemainingGrids = math.ceil((screenH % escala) / gridLength)
	yOffsetUnidades = yRemainingGrids / 2 * gridLength

	-- Linhas horizontais
	for xPos = -xOffset, screenW, gridLength do
		-- Caso a linha esteja no lugar de uma marcação de dezena (considerando offsets)
		if ((xPos + xOffset) - xOffsetUnidades) % escala == 0 then
			-- Cor das dezenas
			love.graphics.setColor(255, 255, 255, 255)
		end

		-- Desenha a linha
		love.graphics.line(xPos, 0, xPos, screenH)

		-- Retorna à cor das unidades
		love.graphics.setColor(255, 255, 255, 100)
	end

	-- Linhas verticais
	for yPos = -yOffset, screenH, gridLength do
		-- Caso a linha esteja no lugar de uma marcação de dezena (considerando offsets)
		if ((yPos + yOffset) - yOffsetUnidades) % escala == 0 then
			-- Cor das dezenas
			love.graphics.setColor(255, 255, 255, 255)
		end

		-- Desenha a linha
		love.graphics.line(0, yPos, screenW, yPos)

		-- Retorna à cor das unidades
		love.graphics.setColor(255, 255, 255, 100)
	end

	-- Retorna a cor e BlendMode aos valores anteriores.
	love.graphics.setColor(rD, gD, bD, aD)

	love.graphics.print(screenH, 10, 5 * 80, 0, 5)
	love.graphics.print(gridLength, 10, 6 * 80, 0, 5)
	love.graphics.print(screenH % gridLength, 10, 7 * 80, 0, 5)
	love.graphics.print(yOffset, 10, 8 * 80, 0, 5)
end
