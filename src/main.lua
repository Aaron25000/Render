local love = require('love')

Matrix = require('matrix')
Render = require('render')
Editor = require('editor')

local angleX = 0
local angleY = 0

function love.load()
    Cube = {
        {-40, -40, -40, -40, 40, 40, 40, 40, 0, 0},
        {-40, 40, -40, 40, -40, 40, -40, 40, -80, -80},
        {40, 40, -40, -40, 40, 40, -40, -40, -40, 40}
    }

    Faces = {
        {1, 2, 4},
        {4, 3, 1},
        {3, 4, 8},
        {8, 7, 3},
        {7, 8, 6},
        {6, 5, 7},
        {5, 6, 2},
        {2, 1, 5},
        {8, 4, 2},
        {2, 6, 8},
        {10, 9, 7},
        {7, 5, 10},
        {9, 10, 1},
        {1, 3, 9},
        {5, 1, 10}
    }

    Color = {
        r = 0,
        g = 0.5,
        b = 0.5
    }
end

function love.update(dt)

    Render.update()

    if love.keyboard.isDown("right") then
        angleY = angleY - dt
    elseif love.keyboard.isDown("left") then
        angleY = angleY + dt
    end

    if love.keyboard.isDown("up") then
        angleX = angleX - dt
    elseif love.keyboard.isDown("down") then
        angleX = angleX + dt
    end

    --CubeTranslated = Render.translate(Cube, 0, 0, 0)
    CubeRotated = Matrix.rotateX(Cube, angleX)
    CubeRotated = Matrix.rotateY(CubeRotated, angleY)

    --HouseRotated = Render.rotateZ(HouseRotated, -math.pi/4)
end

function love.draw()
    --love.graphics.setColor(0.8, 0, 0)
    --love.graphics.line(X, 0, X, ScreenHeight)
    --love.graphics.setColor(0, 0.8, 0)
    --love.graphics.line(0, Y, ScreenWidth, Y)
    --love.graphics.setColor(0, 0, 0.8)
    --love.graphics.circle('fill', X, Y, 2)

    --CubeProjected = Render.project(Cube2)

    --Render.points(HouseRotated)

    --Render.edges(HouseRotated, Edges, 200)

    --love.graphics.setColor(1, 1, 1)
    Render.faces(CubeRotated, Faces, Color)

    --Editor.drawOrigin(angleX, angleY)
end