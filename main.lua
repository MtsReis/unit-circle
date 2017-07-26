require "gooi"

function love.load()
	love.keyboard.setKeyRepeat(true)

	angulo = 0
	escala = 300
	useAcceleration = false

	require("util")
	require("classes/Arco")
	require("classes/Circunferencia")
	require("classes/Linha")
	require("classes/Triangulo")

	circ = Circunferencia()
	triangulo = Triangulo()
	tangent = Linha()
	cotangent = Linha()
	sec = Linha()
	cosec = Linha()
	sin = Linha()
	cos = Linha()
	angArco = Arco()

	-- Propriedades
	sin.cor = {r = 255, g = 75, b = 75, a = 255}
	cos.cor = {r = 102, g = 255, b = 102, a = 255}
	tangent.cor = {r = 158, g = 102, b = 225, a = 255}
	cotangent.cor = {r = 225, g = 178, b = 102, a = 255}
	cosec.cor = {r = 255, g = 255, b = 102, a = 255}
	sec.cor = {r = 102, g = 178, b = 255, a = 255}

	triangulo.blendMode = 'add'
	sec.blendMode = 'add'
	cosec.blendMode = 'add'

	anguloSlider = gooi.newSlider({
		value = angulo / 360,
		x = love.graphics.getWidth() * 0.04,
		y = love.graphics.getHeight() * 0.9,
		w = love.graphics.getWidth() * 0.92,
		h = love.graphics.getHeight() * 0.05
	})

	escalaSlider = gooi.newSlider({
		value = 250/950,
		x = love.graphics.getWidth() * 0.96,
		y = love.graphics.getHeight() * 0.2,
		w = anguloSlider.h,
		h = love.graphics.getHeight() * 0.6
	})

	escalaSlider:vertical()
end

function love.update(dt)
	gooi.update(dt)

	-- Mantém a circunferência no centro em caso de alterações nas dimensões da tela
	circ.x = love.graphics.getWidth() / 2 / escala
	circ.y = love.graphics.getHeight() / 2 / escala
	angArco.x = circ.x
	angArco.y = circ.y
	triangulo.x = circ.x
	triangulo.y = circ.y

	sin.x1 = circ.x
	sin.y1 = circ.y
	sin.x2 = circ.x
	sin.y2 = sin.y1 - math.sin(math.rad(angulo))
	sin.info = "Sin: "..tonumber(string.format("%.3f", math.sin(math.rad(angulo))))

	cos.x1 = circ.x
	cos.y1 = circ.y
	cos.x2 = cos.x1 + math.cos(math.rad(angulo))
	cos.y2 = circ.y
	cos.info = 	"Cos: "..tonumber(string.format("%.3f", math.cos(math.rad(angulo))))

	tangent.x1 = circ.x + circ.raio
	tangent.y1 = circ.y
	tangent.x2 = tangent.x1
	tangent.y2 = tangent.y1 - math.tan(math.rad(angulo))
	tangent.info = "Tg: "..tonumber(string.format("%.3f", math.tan(math.rad(angulo))))

	cotangent.x1 = circ.x
	cotangent.y1 = circ.y - circ.raio
	cotangent.x2 = cotangent.x1 + 1/math.tan(math.rad(angulo))
	cotangent.y2 = cotangent.y1
	cotangent.info = "Ctg: "..tonumber(string.format("%.3f", 1 / math.tan(math.rad(angulo))))

	cosec.x1 = circ.x
	cosec.y1 = circ.y
	cosec.x2 = cotangent.x2
	cosec.y2 = cotangent.y2
	cosec.info = "Cosec: "..tonumber(string.format("%.3f", 1 / math.sin(math.rad(angulo))))

	sec.x1 = circ.x
	sec.y1 = circ.y
	sec.x2 = tangent.x2
	sec.y2 = tangent.y2
	sec.info = "Sec: "..tonumber(string.format("%.3f", 1 / math.cos(math.rad(angulo))))

	angArco.angulo2 = angulo
	angArco.info = "Degree: "..tonumber(string.format("%.3f", angulo))

	-- Calcula posicão da hipotenusa de acordo com os outros valores
	triangulo.altura = math.sin(math.rad(angulo)) * circ.raio
	triangulo.base = math.cos(math.rad(angulo)) * circ.raio

	-- Zera posição das infos a serem impressas no prox frame
	infoPos = 0

	angulo = math.ceil(angulo)

	-- Pega valores dos sliders
	angulo = anguloSlider:getValue() * 360
	escala = (escalaSlider:getValue() * 950) + 50
end

function love.draw()
	gridDraw()
	circ:draw()
	triangulo:draw()
	sin:draw()
	cos:draw()
	tangent:draw()
	cotangent:draw()
	cosec:draw()
	sec:draw()
	angArco:draw()
	gooi.draw()
end

function love.joystickaxis(joystick, axis, value)
	if axis == 1 and useAcceleration then
		angulo = angulo + value
	end
end

function love.mousepressed(x, y, button)  gooi.pressed() end
function love.mousereleased(x, y, button) gooi.released() end
