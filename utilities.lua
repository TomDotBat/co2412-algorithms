--- Evaluates whether or not two values should be swapped.
-- @param the first value.
-- @param the second value.
-- @tparam bool whether the data should be sorted into ascending or descending order.
-- @treturn bool true if the positions should be preserved, false if not.
local function comparator(value1, value2, asc)
    return (not asc and value1 < value2) 
        or (asc and value1 > value2)
end

--- Determines whether or not a given value is a table.
-- @param the value to check the type of.
-- @treturn bool true if the given value is a table, false if not.
local function isTable(tbl)
    return type(tbl) == "table"
end

--- Creates a shallow copy of a given table.
-- @tparam table the table to copy.
-- @treturn a shallow copy of the given table.
local function copyTable(tbl)
    local copy = {}

    for key, value in pairs(tbl) do
        copy[key] = value
    end

    return copy
end

--- Reverses the order of the values in a sequential table.
-- @tparam table the table to reverse the order of the values of.
-- @treturn table the reversed table.
local function reverseTable(tbl)
    local reversedTable = {}
    local tableSize = #tbl

    for key, value in ipairs(tbl) do
        reversedTable[tableSize + 1 - key] = value
    end

    return reversedTable
end

--- Prints the contents of a table.
-- @tparam table the table to print the contents of.
local function printTable(tbl)
    if isTable(tbl) then
        print(table.concat(tbl, ", "))
    end
end

--- Swaps the values at the indexes of a given table.
-- @tparam table the table containing the values to swap.
-- @tparam number the index of the first value to swap.
-- @tparam number the index of the second value to swap.
local function swapValuesAtIndexes(tbl, index1, index2)
    local tmp = tbl[index1]
    tbl[index1] = tbl[index2]
    tbl[index2] = tmp
end

--- Appends the values of other to the destination table.
-- @tparam table the table to append to.
-- @tparam table the table to append the values of.
local function concatTables(destination, other)
    for _, value in ipairs(other) do
        table.insert(destination, value)
    end
end

--- Splits the given table into two parts.
-- @tparam table the table to split.
-- @treturn table the left half of the table.
-- @treturn table the right half of the table.
local function splitTable(tbl)
    local midPos = math.floor(#tbl / 2)
    local left, right = {}, {}

    for i, value in ipairs(tbl) do
        -- If the current index is before the midpoint add the value to the left.
        table.insert(i <= midPos and left or right, value)
    end

    return left, right
end

--- Determines whether a table contains the given value.
-- @tparam table the table to search.
-- @param the value to check the presence of.
-- @treturn bool true if the table contains the given value.
local function tableHasValue(tbl, value)
    for _, tblValue in ipairs(tbl) do
        if tblValue == value then
            return true
        end
    end
end

--- A table of utility methods.
-- @function comparator Evaluates whether or not two values should be swapped.
-- @function isTable Determines whether or not a given value is a table.
-- @function copyTable Creates a shallow copy of a given table.
-- @function reverseTable Reverses the order of the values in a sequential table.
-- @function printTable Prints the contents of a table.
-- @function swapValuesAtIndexes Swaps the values at the indexes of a given table.
-- @function concatTables Appends the values of other to the destination table.
-- @function tableHasValue Determines whether a table contains the given value.
local utilities = {
    ["comparator"] = comparator,
    ["isTable"] = isTable,
    ["copyTable"] = copyTable,
    ["reverseTable"] = reverseTable,
    ["printTable"] = printTable,
    ["swapValuesAtIndexes"] = swapValuesAtIndexes,
    ["concatTables"] = concatTables,
    ["splitTable"] = splitTable,
    ["tableHasValue"] = tableHasValue
}

return utilities