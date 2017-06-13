-- Pff, this is not a line

class.Linha()

-- Propriedades padrões
Linha.x1 = 	love.graphics.getWidth() / 2 / escala
Linha.y1 = love.graphics.getHeight() / 2 / escala
Linha.x2 = Linha.x1 + 1
Linha.y2 = Linha.y1
Linha.cor = {r = 255, g = 255, b = 255, a = 255}
Linha.drawMode = "fill"
Linha.blendMode = "alpha"

function Linha:draw(dt)
	-- Armazena cores e BlendMode atuais.
	local rD, gD, bD, aD = love.graphics.getColor()
	local blendD = love.graphics.getBlendMode()

	-- Aplica as cores e BlendMode do objeto.
	love.graphics.setColor(self.cor.r, self.cor.g, self.cor.b, self.cor.a)
	love.graphics.setBlendMode(self.blendMode)
	love.graphics.line(e(self.x1), e(self.y1), e(self.x2), e(self.y2))

	-- Retorna a cor e BlendMode aos valores anteriores.
	love.graphics.setColor(rD, gD, bD, aD)
	love.graphics.setBlendMode(blendD)
end
