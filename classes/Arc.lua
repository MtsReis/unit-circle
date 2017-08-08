class.Arco()

-- Propriedades padrões
Arco.x = love.graphics.getWidth() / 2 / escala
Arco.y = love.graphics.getHeight() / 2 / escala
Arco.angulo1 = 0
Arco.angulo2 = 90
Arco.raio = 1
Arco.cor = {r = 200, g = 255, b = 255, a = 255}
Arco.info = ''
Arco.drawMode = "line"
Arco.blendMode = "alpha"

function Arco:draw(dt)
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
	love.graphics.arc(self.drawMode, e(self.x), e(self.y), e(self.raio), -math.rad(self.angulo1), -math.rad(self.angulo2))
	love.graphics.print(self.info, 10, infoPos * 80, 0, 5)

	-- Retorna a cor e BlendMode aos valores anteriores.
	love.graphics.setColor(rD, gD, bD, aD)
	love.graphics.setBlendMode(blendD)
end
