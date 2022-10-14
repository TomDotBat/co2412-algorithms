local comparator = require("utilities").comparator

--- Implementation of a binary search.
-- @tparam table the data to search through.
-- @tparam number the index to start from.
-- @param the search term.
-- @tparam bool whether or not the search is ascending or descending order.
local function binarySearch(uData, index, searchTerm, asc)
    local left, right = 1, index

    while left < right do -- Loop until the boundaries collide.
        local mid = math.floor((left + right) / 2)

        -- Compare the midpoint against the search term and update the boundaries accordingly.
        if not comparator(uData[mid], searchTerm, asc) then
            left = mid + 1
        else
            right = mid
        end
    end

    return left
end

--- Replaces the value at the destination index with the target index value.
-- @tparam table the table to replace the indexes on.
-- @tparam number the index of the value.
-- @tparam number the destination index.
local function replace(tbl, targetIndex, destIndex)
    local value = tbl[targetIndex]

    for i = targetIndex, destIndex, -1 do
        tbl[i] = tbl[i - 1]
    end

    tbl[destIndex] = value
end

--- Implementation of a binary insertion sort.
-- @tparam table the original unsorted data.
-- @tparam bool whether the data should be sorted into ascending or descending order.
-- @treturn table the data sorted in the given order.
return function(uData, asc)
    for index, value in ipairs(uData) do
        -- Determine where the current value should be inserted into.
        local pos = binarySearch(uData, index, value, asc)

        -- Swap out the position of the value and shift the table values if necessary.
        replace(uData, index, pos)
    end

    return uData
end