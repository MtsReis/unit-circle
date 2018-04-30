require "lib/gooi"

function love.load()
	love.graphics.setNewFont(54)

	angle = 0
	scale = 297
	currentTouch = {
		x = 0,
		y = 0,
		angleControl = false
	}

	require("util")
	require("classes/Arc")
	require("classes/Circle")
	require("classes/Line")
	require("classes/Triangle")

	unitCircle = Circle()
	triangle = Triangle()
	sine = Line()
	cosine = Line()
	tangent = Line()
	cotangent = Line()
	secant = Line()
	cosecant = Line()
	unitArc = Arc()
	angMark = Arc()

	-- Properties
	sine.color = {r = 255, g = 25, b = 25, a = 255}
	cosine.color = {r = 25, g = 255, b = 25, a = 255}
	tangent.color = {r = 158, g = 102, b = 225, a = 255}
	cotangent.color = {r = 225, g = 178, b = 102, a = 255}
	cosecant.color = {r = 255, g = 255, b = 102, a = 255}
	secant.color = {r = 102, g = 178, b = 255, a = 255}
	sine.infoPrefix = "Sin: "
	cosine.infoPrefix = "Cos: "
	tangent.infoPrefix = "Tg: "
	cotangent.infoPrefix = "Ctg: "
	cosecant.infoPrefix = "Cosec: "
	secant.infoPrefix = "Sec: "
	unitArc.infoPrefix = "Angle: "
	unitArc.infoSufix = "°"

	triangle.blendMode = 'add'
	secant.blendMode = 'add'
	cosecant.blendMode = 'add'

	unitArc.importantAngles = {
		[30] = "π/6 rad",
		[45] = "π/4 rad",
		[60] = "π/3 rad",
		[90] = "π/2 rad",
		[120] = "2π/3 rad",
		[135] = "3π/4 rad",
		[150] = "5π/6 rad",
		[180] = "π rad",
		[210] = "7π/6 rad",
		[225] = "5π/4 rad",
		[240] = "4π/3 rad",
		[270] = "3π/2 rad",
		[300] = "5π/3 rad",
		[315] = "7π/4 rad",
		[330] = "11π/6 rad",
		[360] = "2π rad"
	}

	sine.importantAngles = {
		[30] = "1/2",
		[45] = "√2/2",
		[60] = "√3/2",
		[120] = "√3/2",
		[135] = "√2/2",
		[150] = "1/2",
		[210] = "-1/2",
		[225] = "-√2/2",
		[240] = "-√3/2",
		[300] = "-√3/2",
		[315] = "-√2/2",
		[330] = "-1/2"
	}

	cosine.importantAngles = {
		[30] = "√3/2",
		[45] = "√2/2",
		[60] = "1/2",
		[120] = "-1/2",
		[135] = "-√2/2",
		[150] = "-√3/2",
		[210] = "-√3/2",
		[225] = "-√2/2",
		[240] = "-1/2",
		[300] = "1/2",
		[315] = "√2/2",
		[330] = "√3/2"
	}

	tangent.importantAngles = {
		[30] = "√3/3",
		[60] = "√3",
		[120] = "-√3",
		[150] = "-√3/3",
		[210] = "√3/3",
		[240] = "√3",
		[300] = "-√3",
		[330] = "-√3/3"
	}

	cotangent.importantAngles = {
		[30] = "√3",
		[60] = "√3/3",
		[120] = "-√3/3",
		[150] = "-√3",
		[210] = "√3",
		[240] = "√3/3",
		[300] = "-√3/3",
		[330] = "-√3"
	}

	cosecant.importantAngles = {
		[45] = "√2",
		[60] = "2√3/3",
		[120] = "2√3/3",
		[135] = "√2",
		[225] = "-√2",
		[240] = "-2√3/3",
		[300] = "-2√3/3",
		[315] = "-√2"
	}

	secant.importantAngles = {
		[30] = "2√3/3",
		[45] = "√2",
		[135] = "-√2",
		[150] = "-2√3/3",
		[210] = "-2√3/3",
		[225] = "-√2",
		[315] = "√2",
		[330] = "2√3/3"
	}

	precisionCheck = gooi.newCheck({
		text = "Precision",
		x = love.graphics.getWidth() * 0.04,
		y = love.graphics.getHeight() * 0.95,
		w = 66 + gooi.getFont():getWidth("Precision"),
		h = love.graphics.getHeight() * 0.05
	})

	scaleSlider = gooi.newSlider({
		value = (scale - 50)/950,
		x = love.graphics.getWidth() * 0.96,
		y = love.graphics.getHeight() * 0.2,
		w = love.graphics.getHeight() * 0.05,
		h = love.graphics.getHeight() * 0.6
	})

	scaleSlider:vertical()
end

function love.update(dt)
	gooi.update(dt)

	-- Get the sliders values
	scale = (scaleSlider:getValue() * 950) + 50

	-- Keep the circle centered in case of screen resolution changes
	unitCircle.x = love.graphics.getWidth() / 2 / scale
	unitCircle.y = love.graphics.getHeight() / 2 / scale
	unitArc.x = unitCircle.x
	unitArc.y = unitCircle.y
	angMark.x = unitCircle.x
	angMark.y = unitCircle.y
	angMark.radius = 0.1
	triangle.x = unitCircle.x
	triangle.y = unitCircle.y

	sine.x1 = unitCircle.x
	sine.y1 = unitCircle.y
	sine.x2 = unitCircle.x
	sine.y2 = sine.y1 - math.sin(math.rad(angle))
	sine.info = tonumber(string.format("%.3f", math.sin(math.rad(angle))))
	sine:checkSufix(angle)

	cosine.x1 = unitCircle.x
	cosine.y1 = unitCircle.y
	cosine.x2 = cosine.x1 + math.cos(math.rad(angle))
	cosine.y2 = unitCircle.y
	cosine.info = tonumber(string.format("%.3f", math.cos(math.rad(angle))))
	cosine:checkSufix(angle)

	tangent.x1 = unitCircle.x + unitCircle.radius
	tangent.y1 = unitCircle.y
	tangent.x2 = tangent.x1
	tangent.y2 = tangent.y1 - math.tan(math.rad(angle))
	if (angle == 90 or angle == 270) then
		tangent.info = "Undefined"
	else
		tangent.info = tonumber(string.format("%.3f", math.tan(math.rad(angle))))
		tangent:checkSufix(angle)
	end

	cotangent.x1 = unitCircle.x
	cotangent.y1 = unitCircle.y - unitCircle.radius
	cotangent.x2 = cotangent.x1 + 1/math.tan(math.rad(angle))
	cotangent.y2 = cotangent.y1
	if (angle == 0 or angle == 360 or angle == 180) then
		cotangent.info = "Undefined"
	else
		cotangent.info = tonumber(string.format("%.3f", 1 / math.tan(math.rad(angle))))
		cotangent:checkSufix(angle)
	end

	cosecant.x1 = unitCircle.x
	cosecant.y1 = unitCircle.y
	cosecant.x2 = cotangent.x2
	cosecant.y2 = cotangent.y2
	if (angle == 0 or angle == 360 or angle == 180) then
		cosecant.info = "Undefined"
	else
		cosecant.info = tonumber(string.format("%.3f", 1 / math.sin(math.rad(angle))))
		cosecant:checkSufix(angle)
	end

	secant.x1 = unitCircle.x
	secant.y1 = unitCircle.y
	secant.x2 = tangent.x2
	secant.y2 = tangent.y2
	if (angle == 90 or angle == 270) then
		secant.info = "Undefined"
	else
		secant.info = tonumber(string.format("%.3f", 1 / math.cos(math.rad(angle))))
		secant:checkSufix(angle)
	end

	unitArc.angle2 = angle
	unitArc.info = tonumber(string.format("%.3f", angle)) .. "°"
	unitArc:checkSufix(angle)

	angMark.angle2 = angle

	precisionCheck.x = love.graphics.getWidth() * 0.04
	precisionCheck.y = love.graphics.getHeight() * 0.95

	scaleSlider.x = love.graphics.getWidth() * 0.96
	scaleSlider.y = love.graphics.getHeight() * 0.2

	-- Calculate the hypotenuse position
	triangle.height = math.sin(math.rad(angle)) * unitCircle.radius
	triangle.base = math.cos(math.rad(angle)) * unitCircle.radius

	-- Update the angle if the screen is being touched
	if currentTouch.id ~= nil and currentTouch.angleControl then
		setAngle(love.touch.getPosition(currentTouch.id))
	end

	-- Update the angle if the mouse button 1 is being pressed
	if love.mouse.isDown(1) and currentTouch.angleControl then
		setAngle(love.mouse.getPosition())
	end

	if not precisionCheck.checked then
		angle = math.ceil(angle)
	end

	-- Reset the info printing position for the next frame
	infoPos = 0
end

function love.draw()
	gridDraw()
	unitCircle:draw()
	triangle:draw()
	unitArc:draw()
	angMark:draw()
	sine:draw()
	cosine:draw()
	tangent:draw()
	cotangent:draw()
	cosecant:draw()
	secant:draw()
	gooi.draw()
	love.graphics.print("Scale: "..scale, 10, 0, 0, 1)
end

function love.touchpressed(touchid)
	currentTouch.id = touchid
end

function love.touchreleased(touchid)
	currentTouch.id = nil
end

function love.mousepressed(x, y, button)
	gooi.pressed()

	-- Check if the interaction is with the angle
	if x < scaleSlider.x and y < precisionCheck.y then
		currentTouch.angleControl = true
	end
end
function love.mousereleased(x, y, button)
	gooi.released()
	currentTouch.angleControl = false
end
