local utilities = require("utilities")

local comparator = utilities.comparator
local swapValuesAtIndexes = utilities.swapValuesAtIndexes

--- Implementation of a bubble sort.
-- @tparam table the original unsorted data.
-- @tparam bool whether the data should be sorted into ascending or descending order.
-- @treturn table the data sorted in the given order.
return function(uData, asc)
    for i = 1, #uData do
        for j = 1, #uData - i do -- Loop over each item in the array, ending at the current item.
            if comparator(uData[j], uData[j + 1], asc) then -- Check if we should swap this and the next value.
                swapValuesAtIndexes(uData, j, j + 1)
            end
        end
    end

    return uData
end