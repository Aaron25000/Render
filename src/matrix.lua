local matrix = {}

function matrix.multiply(matrix1, matrix2)
    local productMatrix = {}

    for i = 1, #matrix1 do
        productMatrix[i] = {}
        
        for j = 1, #matrix2[1] do
            local num = 0

            for n = 1, #matrix2 do
                num = num + matrix1[i][n] * matrix2[n][j]
            end

            productMatrix[i][j] = num
        end
    end

    return productMatrix
end

function matrix.rotateX(model, angle)
    local rotationMatrix = {
        {1, 0, 0},
        {0, math.cos(angle), -math.sin(angle)},
        {0, math.sin(angle), math.cos(angle)}
    }
    local productMatrix = Matrix.multiply(rotationMatrix, model)
    return productMatrix
end

function matrix.rotateY(model, angle)
    local rotationMatrix = {
        {math.cos(angle), 0, math.sin(angle)},
        {0, 1, 0},
        {-math.sin(angle), 0, math.cos(angle)}
    }
    local productMatrix = Matrix.multiply(rotationMatrix, model)
    return productMatrix
end

function matrix.rotateZ(model, angle)
    local rotationMatrix = {
        {math.cos(angle), -math.sin(angle), 0},
        {math.sin(angle), math.cos(angle), 0},
        {0, 0 ,1}
    }
    local productMatrix = Matrix.multiply(rotationMatrix, model)
    return productMatrix
end

return matrix