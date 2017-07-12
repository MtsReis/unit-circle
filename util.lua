--[[Retorna argumento com escala correta.
todo: Verificar possibilidade do uso de metatables]]--
function e(valor)
	return valor * escala
end

function gridDraw()
	-- Armazena cor atual.
	local rD, gD, bD, aD = love.graphics.getColor()

	-- Pega dimensões da tela
	screenW = love.graphics.getWidth()
	screenH = love.graphics.getHeight()

	-- Define o tamanho de cada décimo
	gridLength = escala / 10

	-- Linha verticais
	line = 0
	for xPos = screenW/2, screenW, gridLength do
		line = drawGridLine(line, xPos, true)
	end

	line = 0
	for xPos = screenW/2, 0, -gridLength do
		line = drawGridLine(line, xPos, true)
	end

	-- Linha horizontais
	line = 0
	for yPos = screenH/2, screenH, gridLength do
		line = drawGridLine(line, yPos, false)
	end

	line = 0
	for yPos = screenH/2, 0, -gridLength do
		line = drawGridLine(line, yPos, false)
	end

	-- Retorna à cor padrao de execução.
	love.graphics.setColor(rD, gD, bD, aD)
end

function drawGridLine(lineNumber, pos, vert)
	-- Aplica cor dos décimos
	love.graphics.setColor(255, 255, 255, 100)

	if lineNumber == 0 or lineNumber % 10 == 0 then
		-- Cor das unidades
		love.graphics.setColor(255, 255, 255, 255)
	end

	-- Desenha a linha
	if vert then
		love.graphics.line(pos, 0, pos, love.graphics.getHeight())
	else
		love.graphics.line(0, pos, love.graphics.getWidth(), pos)
	end

	return lineNumber + 1
end
