function read_file(filename) 
    local file = {}
    for line in io.lines(filename) do 
        table.insert(file, line)
    end
    return file
end

function table_length(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function update_position(input, offsetRight, offsetDown, currentPos)
    local newPos = {}
    newPos["y"] = currentPos["y"] + offsetDown

    if string.len(input[currentPos["y"]]) < (currentPos["x"] + offsetRight) then
        newPos["x"] = (currentPos["x"] + offsetRight) - string.len(input[currentPos["y"]])
    else
        newPos["x"] = currentPos["x"] + offsetRight
    end

    return newPos
end

function walk(input, offsetRight, offsetDown)
    local currentPos = {}
    currentPos["y"] = offsetDown + 1
    currentPos["x"] = offsetRight + 1
    return walk_recur(input, offsetRight, offsetDown, currentPos, 0)
end

function walk_recur(input, offsetRight, offsetDown, currentPos, result)
    if currentPos["y"] > table_length(input) then
        return result
    else
        local newResult = result
        if string.char(string.byte(input[currentPos["y"]], currentPos["x"])) == "#" then
            newResult = newResult + 1
        end
        return walk_recur(input, offsetRight, offsetDown, update_position(input, offsetRight, offsetDown, currentPos), newResult)
    end
end

function run()
    local input = read_file("input.txt")
    
    local product = walk(input, 1, 1) * walk(input, 3, 1) * walk(input, 5, 1) * walk(input, 7, 1) * walk(input, 1, 2)

    print("Tree slope product: ", product)
end

run()