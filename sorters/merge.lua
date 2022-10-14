local utilities = require("utilities")

local comparator = utilities.comparator
local concatTables = utilities.concatTables
local splitTable = utilities.splitTable

--- Merges two tables into one.
-- @tparam table the first table.
-- @tparam table the second table.
-- @treturn table the result of merging both tables.
local function merge(tbl1, tbl2, asc)
    local result = {}

    while #tbl1 > 0 and #tbl2 > 0 do -- Loop until one of the tables is empty.
        if comparator(tbl2[1], tbl1[1], asc) then -- Compare the values and add the winning one to the result.
            result[#result + 1] = table.remove(tbl1, 1)
        else
            result[#result + 1] = table.remove(tbl2, 1)
        end
    end

    concatTables(result, tbl1) -- Append the remaining values from both tables if any.
    concatTables(result, tbl2)

    return result
end

--- Implementation of a merge sort.
-- @tparam table the original unsorted data.
-- @tparam bool whether the data should be sorted into ascending or descending order.
-- @treturn table the data sorted in the given order.
local function mergeSort(uData, asc)
    if #uData < 2 then -- Breaks the unsorted data down into smaller tables.
        return uData
    end

    local left, right = splitTable(uData) -- Splits the unsorted data into two parts.
    return merge(mergeSort(left, asc), mergeSort(right, asc), asc)
end

return mergeSort