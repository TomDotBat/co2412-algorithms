local comparator = require("utilities").comparator

--- Implementation of an insertion sort.
-- @tparam table the original unsorted data.
-- @tparam bool whether the data should be sorted into ascending or descending order.
-- @treturn table the data sorted in the given order.
return function(uData, asc)
    for i, value in ipairs(uData) do
        local j = i - 1

        -- If an element is greater than the current value, shift them along by one index.
        while j > 0 and comparator(uData[j], value, asc) do
            uData[j + 1] = uData[j]
            j = j - 1
        end

        uData[j + 1] = value
    end

    return uData
end