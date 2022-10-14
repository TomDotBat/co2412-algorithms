local utilities = require("utilities")

local reverseTable = utilities.reverseTable
local copyTable = utilities.copyTable

--- A table containing the available sorting algorithms.
local sorters = {
    ["bubble"] = require("sorters.bubble"),
    ["insertion"] = require("sorters.insertion"),
    ["binary_insertion"] = require("sorters.binary_insertion"),
    ["merge"] = require("sorters.merge"),
    ["quick"] = require("sorters.quick")
}

--- A table containing a list of methods to generate test tables for a given type.
-- @function number Generates a table of random numbers.
-- @function string Generates a table of random strings.
local tableGenerators = {
    ["number"] = function()
        local tbl = {}

        for i = 1, math.random(10, 20) do
            tbl[i] = math.random(-999999999, 999999999)
        end

        return tbl
    end,
    ["string"] = function()
        local tbl = {}

        for i = 1, math.random(10, 20) do
            local str = ""

            for j = 1, math.random(1, 20) do -- Generate a random string.
                str = str .. string.char(math.random(97, 122))
            end

            tbl[i] = str
        end

        return tbl
    end
}

--- Tests the output of a sorting algorithm implementation for both ascending and descending order.
-- @tparam string the name of the sorting algorithm.
-- @tparam function the implementation of the sorting algorithm.
local function testSorter(sorterName, sorterMethod, tableGeneratorMethod)
    for i = 1, 2 do --Run the sorter twice for both ascending and descending order.
        local ascending = i == 2

        -- Generate a table to test the search algorithm implementation with.
        local input = tableGeneratorMethod()

        -- Make a copy of our input and sort it with the built-in sort method.
        local expectedOutput = copyTable(input)
        table.sort(expectedOutput)

        if not ascending then
            expectedOutput = reverseTable(expectedOutput)
        end

        local actualOutput = sorterMethod(input, ascending)
        assert(type(actualOutput) == "table",
            "The output of the " .. sorterName .. " sort implementation is not a table.")

        for j = 1, #expectedOutput do -- Check the output against the expected values.
            local expected, actual = expectedOutput[j], actualOutput[j]

            assert(expected == actual,
                "The output of the " .. sorterName .. " sort implementation at index "
                    .. j .. " should be " .. expected .. ", but is actually " .. actual .. ".")
        end
    end
end

--- Tests the outputs of the available sorting algorithms.
local function testSorters()
    for sorterName, sorterMethod in pairs(sorters) do
        print("Testing the " .. sorterName .. " sort implementation...")

        for _, tableGeneratorMethod in pairs(tableGenerators) do
            testSorter(sorterName, sorterMethod, tableGeneratorMethod)
        end
    end
end

-- Test the available sorting algorithms.
testSorters()
print("All tests completed successfully.")