class.Triangulo()

-- Propriedades padrões
Triangulo.x = 	love.graphics.getWidth() / 2 / escala
Triangulo.y = love.graphics.getHeight() / 2 / escala
Triangulo.base = 1
Triangulo.altura = 0.5
Triangulo.cor = {r = 155, g = 155, b = 155, a = 255}
Triangulo.drawMode = "fill"
Triangulo.blendMode = "alpha"

function Triangulo:draw(dt)
	-- Armazena cores e BlendMode atuais.
	local rD, gD, bD, aD = love.graphics.getColor()
	local blendD = love.graphics.getBlendMode()

	-- Aplica as cores e BlendMode do objeto.
	love.graphics.setColor(self.cor.r, self.cor.g, self.cor.b, self.cor.a)
	love.graphics.setBlendMode(self.blendMode)
	love.graphics.polygon("fill", e(self.x), e(self.y), e(self.x + self.base), e(self.y), e(self.x + self.base), e(self.y - self.altura))

	-- Retorna a cor e BlendMode aos valores anteriores.
	love.graphics.setColor(rD, gD, bD, aD)
	love.graphics.setBlendMode(blendD)
end
