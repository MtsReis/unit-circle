require "lib/gooi"

function love.load()
	angle = 0
	scale = 300
	currentTouch = {
		x = 0,
		y = 0
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

	triangle.blendMode = 'add'
	cosine.blendMode = 'replace'
	secant.blendMode = 'add'
	cosecant.blendMode = 'add'

	precisionCheck = gooi.newCheck({
		text = "Precision",
		x = love.graphics.getWidth() * 0.04,
		y = love.graphics.getHeight() * 0.95,
		w = 66 + gooi.getFont():getWidth(" Precision"),
		h = love.graphics.getHeight() * 0.05
	})

	scaleSlider = gooi.newSlider({
		value = 250/950,
		x = love.graphics.getWidth() * 0.96,
		y = love.graphics.getHeight() * 0.2,
		w = love.graphics.getHeight() * 0.05,
		h = love.graphics.getHeight() * 0.6
	})

	scaleSlider:vertical()
end

function love.update(dt)
	gooi.update(dt)

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
	sine.info = "Sin: "..tonumber(string.format("%.3f", math.sin(math.rad(angle))))

	cosine.x1 = unitCircle.x
	cosine.y1 = unitCircle.y
	cosine.x2 = cosine.x1 + math.cos(math.rad(angle))
	cosine.y2 = unitCircle.y
	cosine.info = 	"Cos: "..tonumber(string.format("%.3f", math.cos(math.rad(angle))))

	tangent.x1 = unitCircle.x + unitCircle.radius
	tangent.y1 = unitCircle.y
	tangent.x2 = tangent.x1
	tangent.y2 = tangent.y1 - math.tan(math.rad(angle))
	if (angle == 90 or angle == 270) then
		tangent.info = "Tg: Undefined"
	else
		tangent.info = "Tg: "..tonumber(string.format("%.3f", math.tan(math.rad(angle))))
	end

	cotangent.x1 = unitCircle.x
	cotangent.y1 = unitCircle.y - unitCircle.radius
	cotangent.x2 = cotangent.x1 + 1/math.tan(math.rad(angle))
	cotangent.y2 = cotangent.y1
	if (angle == 0 or angle == 360 or angle == 180) then
		cotangent.info = "Ctg: Undefined"
	else
		cotangent.info = "Ctg: "..tonumber(string.format("%.3f", 1 / math.tan(math.rad(angle))))
	end

	cosecant.x1 = unitCircle.x
	cosecant.y1 = unitCircle.y
	cosecant.x2 = cotangent.x2
	cosecant.y2 = cotangent.y2
	if (angle == 0 or angle == 360 or angle == 180) then
		cosecant.info = "Cosec: Undefined"
	else
		cosecant.info = "Cosec: "..tonumber(string.format("%.3f", 1 / math.sin(math.rad(angle))))
	end

	secant.x1 = unitCircle.x
	secant.y1 = unitCircle.y
	secant.x2 = tangent.x2
	secant.y2 = tangent.y2
	if (angle == 90 or angle == 270) then
		secant.info = "Sec: Undefined"
	else
		secant.info = "Sec: "..tonumber(string.format("%.3f", 1 / math.cos(math.rad(angle))))
	end

	unitArc.angle2 = angle
	unitArc.info = "Angle: "..tonumber(string.format("%.3f", angle)).."°"

	angMark.angle2 = angle

	precisionCheck.x = love.graphics.getWidth() * 0.04
	precisionCheck.y = love.graphics.getHeight() * 0.95

	scaleSlider.x = love.graphics.getWidth() * 0.96
	scaleSlider.y = love.graphics.getHeight() * 0.2

	-- Calculate the hypotenuse position
	triangle.height = math.sin(math.rad(angle)) * unitCircle.radius
	triangle.base = math.cos(math.rad(angle)) * unitCircle.radius

	-- Update the angle if the screen is being touched
	if currentTouch.id ~= nil then
		setAngle(love.touch.getPosition(currentTouch.id))
	end

	-- Update the angle if the mouse button 1 is being pressed
	if love.mouse.isDown(1) then
		setAngle(love.mouse.getPosition())
	end

	if not precisionCheck.checked then
		angle = math.ceil(angle)
	end

	-- Get the sliders values
	scale = (scaleSlider:getValue() * 950) + 50

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
	love.graphics.print("Scale: "..scale, 10, 0, 0, 5)
end

function love.touchpressed(touchid)
	currentTouch.id = touchid
end

function love.touchreleased(touchid)
	currentTouch.id = nil
end

function love.mousepressed(x, y, button)  gooi.pressed() end
function love.mousereleased(x, y, button) gooi.released() end
