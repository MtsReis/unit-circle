function love.load()
	love.keyboard.setKeyRepeat(true)

	angulo = 0
	escala = 300
	useAcceleration = false
	currentTouch = {
		x = 0,
		y = 0
	}

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
	
	-- TODO: Add an active status
	degreeBar = {
		pos = {x = love.graphics.getWidth() * 0.04, y = love.graphics.getHeight() * 0.9},
		width = love.graphics.getWidth() * 0.92,
		height = 10,
		mode = 'fill',
		active = '',
		cor = {r = 155, g = 155, b = 155, a = 255}
	}
	
	degreeMark = {
		pos = {x = degreeBar.pos.x, y = love.graphics.getHeight() * 0.9 - 50},
		width = 50,
		height = 100,
		mode = 'fill',
		cor = {r = 55, g = 55, b = 55, a = 255}
	}

	scaleBar = {
		pos = {x = love.graphics.getWidth() * 0.96, y = love.graphics.getHeight() * 0.2},
		width = 10,
		height = love.graphics.getHeight() * 0.60,
		mode = 'fill',
		cor = {r = 155, g = 155, b = 155, a = 255}
	}
	
	scaleMark = {
		pos = {x = scaleBar.pos.x - 50, y = scaleBar.pos.y},
		width = 100,
		height = 50,
		mode = 'fill',
		cor = {r = 255, g = 55, b = 55, a = 255}
	}


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
end

function love.update(dt)
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

	-- Interação com barra
	if currentTouch.id ~= nil then
		currentTouch.x, currentTouch.y = love.touch.getPosition(currentTouch.id)
		-- Ângulo
		if (currentTouch.y > degreeBar.pos.y - 100 and currentTouch.x < scaleBar.pos.x) then
			segments = degreeBar.width / 360
			angulo = math.ceil((currentTouch.x - degreeBar.pos.x) / segments)
			degreeMark.pos.x = currentTouch.x
			
			if degreeMark.pos.x < degreeBar.pos.x then
				degreeMark.pos.x = degreeBar.pos.x
			elseif degreeMark.pos.x > degreeBar.pos.x + degreeBar.width then
				degreeMark.pos.x = degreeBar.pos.x + degreeBar.width
			end
		end
		
		-- Escala
		if (currentTouch.x > scaleBar.pos.x - 100 and currentTouch.y < degreeBar.pos.y - 100) then
			segments = scaleBar.height / 1000
			escala = (currentTouch.y - scaleBar.pos.y) / segments
			scaleMark.pos.y = currentTouch.y
			
			if scaleMark.pos.y < scaleBar.pos.y then
				scaleMark.pos.y = scaleBar.pos.y
			elseif scaleMark.pos.y > scaleBar.pos.y + scaleBar.height then
				scaleMark.pos.y = scaleBar.pos.y + scaleBar.height
			end
		end
		
		-- Correção de ângulo pra barra
		if angulo > 360 then
			angulo = 360
		elseif angulo < 0 then
			angulo = 0
		end
	end
	
	
	-- Correção global de ângulo
	if angulo > 360 then
		angulo = 0
	elseif angulo < 0 then
		angulo = 360
	end
	
	-- Limita valores da escala
	if escala <= 50 then
		escala = 50
	elseif escala >= 1000 then
		escala = 1000
	end
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
	-- Degree Ui
	love.graphics.rectangle(degreeBar.mode, degreeBar.pos.x, degreeBar.pos.y, degreeBar.width, degreeBar.height)
	love.graphics.rectangle(degreeMark.mode, degreeMark.pos.x, degreeMark.pos.y, degreeMark.width, degreeMark.height)
	
	--Scale UI
	love.graphics.rectangle(scaleBar.mode, scaleBar.pos.x, scaleBar.pos.y, scaleBar.width, scaleBar.height)
	love.graphics.rectangle(scaleMark.mode, scaleMark.pos.x, scaleMark.pos.y, scaleMark.width, scaleMark.height)
	love.graphics.print("Escala: "..tonumber(string.format("%.2f", escala)), 10, 0, 0, 5)
end

function love.joystickaxis(joystick, axis, value)
	if axis == 1 and useAcceleration then
		angulo = angulo + value
	end
end

function love.keypressed(key, scancode, isrepeat)
	-- Aumenta valor de alteração progressivamente
	if isrepeat then
		valueChange = valueChange + 0.1
	else
		valueChange = 1
	end

	-- Controle do ângulo
	if key == "up" then
		angulo = angulo + 1
	elseif key == "down" then
		angulo = angulo - 1
	end

	-- Controle da escala
	if key == "i" then
		escala = escala + valueChange
	elseif key == "o" then
		escala = escala - valueChange
	end

	-- Limita valores do ângulo
	if angulo >= 360 then
		angulo = 0
	elseif angulo < 0 then
		angulo = 359
	end

end

function love.touchpressed(touchid)
	if (currentTouch.y > degreeBar.pos.y - 100 and currentTouch.x < scaleBar.pos.x) then
		degreeBar.active = touchid
	end
 currentTouch.id = touchid
end

function love.touchreleased(touchid)
 currentTouch.id = nil
 degreeBar.active = ''
end

