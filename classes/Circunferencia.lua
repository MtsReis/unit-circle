class.Circunferencia()

-- Propriedades padrões
Circunferencia.x = love.graphics.getWidth() / 2 / escala
Circunferencia.y = love.graphics.getHeight() / 2 / escala
Circunferencia.raio = 1
Circunferencia.cor = {r = 155, g = 155, b = 155, a = 255}
Circunferencia.drawMode = "line"
Circunferencia.blendMode = "alpha"

function Circunferencia:draw(dt)
	-- Armazena cores e BlendMode atuais.
	local rD, gD, bD, aD = love.graphics.getColor()
	local blendD = love.graphics.getBlendMode()

	-- Aplica as cores e BlendMode do objeto.
	love.graphics.setColor(self.cor.r, self.cor.g, self.cor.b, self.cor.a)
	love.graphics.setBlendMode(self.blendMode)
	love.graphics.circle(self.drawMode, e(self.x), e(self.y), e(self.raio))

	-- Retorna a cor e BlendMode aos valores anteriores.
	love.graphics.setColor(rD, gD, bD, aD)
	love.graphics.setBlendMode(blendD)
end
