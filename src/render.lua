local love = require('love')

local render = {}

function render.update()
    ScreenWidth = love.graphics.getWidth()
    ScreenHeight = love.graphics.getHeight()

    X = ScreenWidth/2
    Y = ScreenHeight/2
end

function render.point(point, focal)
    local projectX = (focal * point.x) / (focal + point.z)
    local projectY = (focal * point.y) / (focal + point.z)

    local point2d = {x = projectX, y = projectY}
    return point2d
end

function render.edge(matrix2d, p1, p2)
    love.graphics.line(matrix2d[1][p1]+X, matrix2d[2][p1]+Y, matrix2d[1][p2]+X, matrix2d[2][p2]+Y)
end

function render.edges(matrix2d, edgeTable, focal)

    for i = 1, #edgeTable do
        local p1 = edgeTable[i][1]
        local p2 = edgeTable[i][2]

        local point1 = {x = matrix2d[1][p1], y = matrix2d[2][p1], z = matrix2d[3][p1]}
        local point2 = {x = matrix2d[1][p2], y = matrix2d[2][p2], z = matrix2d[3][p2]}

        --local projected1 = render.point(point1, focal)
        --local projected2 = render.point(point2, focal)

        local projected1 = {x = point1.x, y = point1.y}
        local projected2 = {x = point2.x, y = point2.y}

        love.graphics.line(projected1.x+X, projected1.y+Y, projected2.x+X, projected2.y+Y)
    end
end

local function isBackface(p1, p2, p3)
    local a = {
        x = p3.x - p1.x,
        y = p3.y - p1.y,
        z = p3.z - p1.z
    }
    local b = {
        x = p2.x - p1.x,
        y = p2.y - p1.y,
        z = p2.z - p1.z
    }

    local normal = {
        x = a.y * b.z - a.z * b.y,
        y = a.z * b.x - a.x * b.z,
        z = a.x * b.y - a.y * b.x
    }

    local l = math.sqrt(normal.x * normal.x + normal.y * normal.y + normal.z * normal.z)

    normal.x = normal.x / l
    normal.y = normal.y / l
    normal.z = normal.z / l

    if normal.z < 0 then
        local light = {x = 0, y = 0, z = -1}

        l = math.sqrt(normal.x * light.x + normal.y * light.y + normal.z * light.z)

        light.x = light.x / l
        light.y = light.y / l
        light.z = light.z / l

        DotProduct = normal.x * light.x + normal.y * light.y + normal.z * light.z

        --love.graphics.setColor(0*dotProduct, 0*dotProduct, 0.5*dotProduct)
        --print(1*dotProduct)
        return false
    else
        return true
    end
end

function render.faces(matrix2d, faceTable, color)

    for i = 1, #faceTable do
        local p1 = faceTable[i][1]
        local p2 = faceTable[i][2]
        local p3 = faceTable[i][3]

        local point1 = {x = matrix2d[1][p1], y = matrix2d[2][p1], z = matrix2d[3][p1]}
        local point2 = {x = matrix2d[1][p2], y = matrix2d[2][p2], z = matrix2d[3][p2]}
        local point3 = {x = matrix2d[1][p3], y = matrix2d[2][p3], z = matrix2d[3][p3]}

        local projected1 = {x = point1.x, y = point1.y}
        local projected2 = {x = point2.x, y = point2.y}
        local projected3 = {x = point3.x, y = point3.y}

        if not isBackface(point1, point2, point3) then
            love.graphics.setColor(color.r * DotProduct, color.g * DotProduct, color.b * DotProduct)
            love.graphics.polygon('fill', projected1.x+X, projected1.y+Y, projected2.x+X, projected2.y+Y, projected3.x+X, projected3.y+Y)
        end
    end
end

return render