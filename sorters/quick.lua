local utilities = require("utilities")

local comparator = utilities.comparator
local swapValuesAtIndexes = utilities.swapValuesAtIndexes

--- Determines the position of the quick sort partition.
-- @tparam table the original unsorted data.
-- @tparam number the lower boundary of the sort.
-- @tparam number the upper boundary of the sort.
-- @tparam bool whether the data should be sorted into ascending or descending order.
-- @treturn number the partition index.
local function partition(uData, low, high, asc)
    local pivot = uData[high]

    local i = low - 1
    local j = low

    while j <= high do -- Loop until our index is less than our pivot index.
        if comparator(pivot, uData[j], asc) then -- Determine if the values should be swapped.
            i = i + 1
            swapValuesAtIndexes(uData, i, j)
        end

        j = j + 1
    end

    -- Swap the pivot with the last index position.
    swapValuesAtIndexes(uData, i + 1, high)
    return i + 1 --Return the new partition index
end

--- Implementation of a quick sort.
-- @tparam table the original unsorted data.
-- @tparam bool whether the data should be sorted into ascending or descending order.
-- @tparam number the lower boundary of the sort, defaults to 1.
-- @tparam number the upper boundary of the sort, defaults to the length of uData.
-- @treturn table the data sorted in the given order.
local function quickSort(uData, asc, low, high)
    low = low or 1 -- Set the default values of low and high
    high = high or #uData

    if low < high then
        -- Determine the current position of the partition index.
        local index = partition(uData, low, high, asc)

        -- Sort the elements before and after the partition seperately.
        quickSort(uData, asc, low, index - 1)
        quickSort(uData, asc, index + 1, high)
    end

    return uData
end

return quickSort