local Render = require('render')

local editor = {}

local origin = {
    {0, 10, 0, 0},
    {0, 0, -10, 0},
    {0, 0, 0, -10}
}

function editor.drawOrigin(angleX, angleY)
    OriginRot = Matrix.rotateX(origin, angleX)
    OriginRot = Matrix.rotateY(OriginRot, angleY)
    --Render.points(OriginRot)
    love.graphics.setColor(1, 0, 0)
    Render.edge(OriginRot, 1, 2)

    love.graphics.setColor(0, 1, 0)
    Render.edge(OriginRot, 1, 3)

    love.graphics.setColor(0, 0, 1)
    Render.edge(OriginRot, 1, 4)
end

return editor