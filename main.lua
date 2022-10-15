local utilities = require("utilities")

local tableHasValue = utilities.tableHasValue
local copyTable = utilities.copyTable
local printTable = utilities.printTable

--- A table containing the available sorting algorithms.
local sorters = {
    ["bubble"] = require("sorters.bubble"),
    ["insertion"] = require("sorters.insertion"),
    ["binary_insertion"] = require("sorters.binary_insertion"),
    ["merge"] = require("sorters.merge"),
    ["quick"] = require("sorters.quick")
}

--- Implementation of comptSort.
-- @tparam table the original unsorted data.
-- @tparam string the sorting algorithm to be used.
-- @tparam bool whether the data should be sorted into ascending or descending order.
-- @treturn table the sorted data.
local function comptSort(uData, sort, asc)
    local sorter = sorters[sort]
    assert(sorter, "Could not find a sorter named " .. sort .. ".")

    return sorter(uData, asc)
end

--- Reads the contents from a given file.
-- @tparam string the path of the file to read from.
-- @treturn string the contents of the file.
local function readFileText(filePath)
    local file = io.open(filePath, "r")

    if file then
        local contents = file:read("*a")
        file:close()
        return contents
    end

    return ""
end

--- Returns the contents of the given file as a table of numbers.
-- @tparam string the path of the file to read from.
-- @treturn table the contents of the file as a table of numbers.
local function readNumbersFromFile(filePath)
    local numbers = {}

    for number in readFileText(filePath):gmatch("%w+") do -- Iterate over every word in the file.
    	numbers[#numbers + 1] = tonumber(number) or 0
    end

    return numbers
end

--- Returns the contents of the given file as a table of words.
-- @tparam string the path of the file to read from.
-- @treturn table the contents of the file as a table of words.
local function readWordsFromFile(filePath)
    local words = {}

    for word in readFileText(filePath):gmatch("%w+") do -- Iterate over every word in the file.
    	words[#words + 1] = word
    end

    return words
end

--- Prompts the user to input one of the given acceptable inputs.
-- @tparam string the message to show to the user.
-- @tparam table a table of acceptable inputs.
-- @tparam string the default input if the user presses enter.
local function prompt(message, acceptableInputs, default)
    local input

    -- Append a list of acceptable inputs to the prompt.
    message = message .. " (" .. table.concat(acceptableInputs, "/") .. "):"

    repeat
        print(message) -- Print the prompt and read the response in lower case.
        input = io.read():lower()

        -- If the user pressed enter and we have a default input set, use it.
        if default and input == "" then
            input = default
            print("Using default value: " .. default)
        	break
        end
    until tableHasValue(acceptableInputs, input) -- Repeat until the input given is valid.

    return input
end

-- Load the numbers and strings from their files.
local numbers = readNumbersFromFile("numbers.txt")
local strings = readWordsFromFile("strings.txt")

local algorithmNames = {}
for algorithmName, _ in pairs(sorters) do -- Create a table of available algorithm names.
    algorithmNames[#algorithmNames + 1] = algorithmName
end

while true do
    local datasetChoice = prompt("What dataset would you like to use?", {"numbers", "strings"}, "numbers")
    local dataset = copyTable(datasetChoice == "numbers" and numbers or strings) -- Create a copy of the preffered dataset.

    local orderChoice = prompt("How would you like the list to be ordered?", {"ascending", "descending"}, "ascending")
    local ascending = orderChoice == "ascending" -- Get the order choice as a boolean.

    local algorithmChoice = prompt("Which sorting algorithm would you like to use?", algorithmNames)

    print("===========================================================")

    print("Dataset before sort:")
    printTable(dataset)

    print()

    local sortedDataset = comptSort(dataset, algorithmChoice, ascending) -- Execute comptSort with the requested parameters.
    print("Dataset after sort:")
    printTable(sortedDataset)

    print("===========================================================")
end
