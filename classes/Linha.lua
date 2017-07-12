class.Linha()

-- Propriedades padrões
Linha.x1 = love.graphics.getWidth() / 2 / escala
Linha.y1 = love.graphics.getHeight() / 2 / escala
Linha.x2 = Linha.x1 + 1
Linha.y2 = Linha.y1
Linha.cor = {r = 255, g = 255, b = 255, a = 255}
Linha.info = ''
Linha.drawMode = "fill"
Linha.blendMode = "alpha"

function Linha:draw(dt)
	-- Armazena cores e BlendMode atuais.
	local rD, gD, bD, aD = love.graphics.getColor()
	local blendD = love.graphics.getBlendMode()

	if self.info ~= '' and self.info ~= nil then
		infoPos = infoPos + 1
	end

	-- Aplica as cores e BlendMode do objeto.
	love.graphics.setColor(self.cor.r, self.cor.g, self.cor.b, self.cor.a)
	love.graphics.setBlendMode(self.blendMode)

	-- Imprime objeto e info
	love.graphics.line(e(self.x1), e(self.y1), e(self.x2), e(self.y2))
	love.graphics.print(self.info, 10, infoPos * 80, 0, 5)

	-- Retorna a cor e BlendMode aos valores anteriores.
	love.graphics.setColor(rD, gD, bD, aD)
	love.graphics.setBlendMode(blendD)
end
