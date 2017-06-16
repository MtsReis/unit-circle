class.Arco()

-- Propriedades padrões
Arco.x = love.graphics.getWidth() / 2 / escala
Arco.y = love.graphics.getHeight() / 2 / escala
Arco.angulo1 = 0
Arco.angulo2 = 90
Arco.raio = 1
Arco.cor = {r = 155, g = 100, b = 255, a = 255}
Arco.drawMode = "line"
Arco.blendMode = "alpha"

function Arco:draw(dt)
	-- Armazena cores e BlendMode atuais.
	local rD, gD, bD, aD = love.graphics.getColor()
	local blendD = love.graphics.getBlendMode()

	-- Aplica as cores e BlendMode do objeto.
	love.graphics.setColor(self.cor.r, self.cor.g, self.cor.b, self.cor.a)
	love.graphics.setBlendMode(self.blendMode)
	love.graphics.arc(self.drawMode, e(self.x), e(self.y), e(self.raio), -math.rad(self.angulo1), -math.rad(self.angulo2))

	-- Retorna a cor e BlendMode aos valores anteriores.
	love.graphics.setColor(rD, gD, bD, aD)
	love.graphics.setBlendMode(blendD)
end
