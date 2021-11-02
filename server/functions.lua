function GetLicense(userInformations)
    for i = 1, #userInformations, 1 do
        if string.sub(userInformations[i], 1, string.len("license:")) == "license:" then
            return userInformations[i]
        end
    end
end

function IsValueInTable(value, table)
    for k, v in pairs(table) do
        if type(v) == "table" then
            if IsValueInTable(value, v) then 
                return true
            end
        end

        if v == value then
            return true
        end
    end
    return false
end

function GetPositionInTable(value, table)
    for k, v in pairs(table) do
        if type(v) == "table" then
            if IsValueInTable(value, v) then
                return k
            end
        end

        if v == value then
            return k
        end
    end
    return -1 -- If value not finded in the table
end