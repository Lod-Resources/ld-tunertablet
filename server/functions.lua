

function _L(key, ...)
    local lang = Config.Language or "en"
    local result = Locales.Languages[lang][key] or Locales.Languages["en"][key] or key
    

    local args = {...}
    if #args > 0 then
        for i, v in ipairs(args) do
            result = result:gsub("{" .. (i-1) .. "}", tostring(v))
        end
    end
    
    return result
end


function ExecuteSQL(query, params)
    local IsBusy = true
    local result = nil
    exports.oxmysql:execute(query, params, function(data)
        result = data
        IsBusy = false
    end)
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end


