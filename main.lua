function love.load()
	angulo = 0;
	escala = 300

	require("util")
	require("classes/Circunferencia")
	require("classes/Linha")
	require("classes/Triangulo")

	-- Propriedades da circunferência
	circ = Circunferencia()
	raio = Linha()
	triangulo = Triangulo()
	tangent = Linha()
	
	triangulo.cor = {r = 255, g = 255, b = 255, a = 255}
	tangent.cor = {r = 255, g = 155, b = 0, a = 255}
	
	info1 = ''
	info2 = 	''
	info3 = ''
	info4 = ''
end

function love.update(dt)
 raio.y = circ.y
 raio.x = circ.x
 raio.largura = circ.raio
 
 tangent.x1 = circ.x + circ.raio
 tangent.y1 = circ.y
 
 tangent.x2 = tangent.x1
 tangent.y2 = tangent.y1 - math.tan(math.rad(angulo))
 
 info1 = "Sin: "..math.sin(math.rad(angulo))
	info2 = 	"Cos: "..math.cos(math.rad(angulo))
	info3 = "Tg: "..math.tan(math.rad(angulo))
	info4 = "Degree: "..angulo

 
 -- Calcula posicão da hipotenusa de acordo com os outroe valores
 
 triangulo.altura = math.sin(math.rad(angulo)) * circ.raio
 triangulo.base = math.cos(math.rad(angulo)) * circ.raio
end

function love.draw()
	circ:draw()
	raio:draw()
	triangulo:draw()
	tangent:draw()
	
	--debug
	love.graphics.print(info1, 10, 80, 0, 5)
	love.graphics.print(info2, 10, 2 * 80, 0, 5)
	love.graphics.print(info3, 10, 3 * 80, 0, 5)
	love.graphics.print(info4, 10, 4 * 80, 0, 5)
end

function love.joystickaxis(joystick, axis, value) 
	if axis == 1 then
	 angulo = angulo + value
	end
end