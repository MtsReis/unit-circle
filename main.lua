function love.load()
	angulo = 0
	escala = 300

	require("util")
	require("classes/Arco")
	require("classes/Circunferencia")
	require("classes/Linha")
	require("classes/Triangulo")

	circ = Circunferencia()
	xaxis = Linha()
	yaxis = Linha()
	triangulo = Triangulo()
	tangent = Linha()
	sin = Linha()
	cos = Linha()
	angArco = Arco()

	-- Propriedades
	tangent.cor = {r = 255, g = 155, b = 0, a = 255}
	sin.cor = {r = 255, g = 155, b = 155, a = 255}
	cos.cor = {r = 255, g = 0, b = 55, a = 255}
	triangulo.blendMode = 'add'

	info1 = ''
	info2 = ''
	info3 = ''
	info4 = ''
end

function love.update(dt)
	xaxis.y1 = circ.y
	xaxis.x1 = 0
	xaxis.y2 = circ.y
	xaxis.x2 = love.graphics.getWidth() / escala

	yaxis.y1 = 0
	yaxis.x1 = circ.x
	yaxis.y2 = love.graphics.getHeight() / escala
	yaxis.x2 = circ.x

	tangent.x1 = circ.x + circ.raio
	tangent.y1 = circ.y
	tangent.x2 = tangent.x1
	tangent.y2 = tangent.y1 - math.tan(math.rad(angulo))
 
	sin.x1 = circ.x
	sin.y1 = circ.y
	sin.x2 = circ.x
	sin.y2 = sin.y1 - math.sin(math.rad(angulo))
 
	cos.x1 = circ.x
	cos.y1 = circ.y
	cos.x2 = cos.x1 + math.cos(math.rad(angulo))
	cos.y2 = circ.y
 
	angArco.angulo2 = angulo
 
	-- Calcula posicão da hipotenusa de acordo com os outros valores
	triangulo.altura = math.sin(math.rad(angulo)) * circ.raio
	triangulo.base = math.cos(math.rad(angulo)) * circ.raio
 
	info1 = "Sin: "..tonumber(string.format("%.3f", math.sin(math.rad(angulo))))
	info2 = 	"Cos: "..tonumber(string.format("%.3f", math.cos(math.rad(angulo))))
	info3 = "Tg: "..tonumber(string.format("%.3f", math.tan(math.rad(angulo))))
	info4 = "Degree: "..tonumber(string.format("%.3f", angulo))

end

function love.draw()
	gridDraw()
	--love.graphics.draw(background, 0, 0, 0, bgsx, bgsy)
	circ:draw()
	angArco:draw()
	--xaxis:draw()
	--yaxis:draw()
	triangulo:draw()
	tangent:draw()
	sin:draw()
	cos:draw()

	--debug
	love.graphics.print(info1, 10, 80, 0, 5)
	love.graphics.print(info2, 10, 2 * 80, 0, 5)
	love.graphics.print(info3, 10, 3 * 80, 0, 5)
	love.graphics.print(info4, 10, 4 * 80, 0, 5)
end

function love.joystickaxis(joystick, axis, value)
	if axis == 1 then
	 angulo = angulo + value
	 
	 if angulo >= 360 then
	 	angulo = 0
	 elseif angulo < 0 then
	 	angulo = 360
	 end
	end
end

function love.keypressed(key)
	if key == "up" then
		angulo = angulo + 1
	elseif key == "down" then
		angulo = angulo - 1
	end
	
	if angulo >= 360 then
 	angulo = 0
	elseif angulo < 0 then
 	angulo = 359
 end
end
