local QBCore = exports['qb-core']:GetCoreObject()

local function FillChar(text, char, size)
    local count = 0
    local result = text
    while count < size do
        result = string.format("%s%s", result, char)
    end
    return result
end

Citizen.CreateThread(function()
    local resource = GetCurrentResourceName()
    local currentVersion = GetResourceMetadata(resource, 'version', 0)
    PerformHttpRequest('https://raw.githubusercontent.com/thisthecity/ttc-test/master/fxmanifest.lua',
        function(error, result, headers)
            print(error, result)
            if not result then
                print(string.format('%s: ^1Couldn\'t check version.^0', resource))
            end

            local update = (string.sub(result, string.find(result, 'update [^\n]+')))
            update = (string.sub(update, string.find(update, '[^update ].+'))):gsub('"', "")

            local version = string.sub(result, string.find(result, "%d.%d.%d"))
            local version_N = tonumber((version:gsub("%D+", "")))
            local currentVersion_N = tonumber((currentVersion:gsub("%D+", "")))

            if version_N > currentVersion_N then
                local title = string.format("^4| %s                                                                                                          |", resource)
                local message =
                    '^4|^0 New version available on GitHub: ^1' .. currentVersion .. '^0 -> ^2' .. version .. '^0'
                local messageLength = #(message) - 12
                local updateMessage = '^4| ^3Update: ^2' .. update
                local updateMessageLength = #(updateMessage) - 6

                local length = 120

                for i = 1, length - updateMessageLength do
                    updateMessage = updateMessage .. " "
                end
                updateMessage = updateMessage .. "^4|^0"

                for i = 1, length - messageLength do
                    message = message .. " "
                end
                message = message .. "^4|^0"

                local border = "^4="
                for i = 1, length do
                    border = border .. "="
                end

                print(border)
                print(title)
                print(message)
                print(updateMessage)
                print(border .. "^0")
            end
        end, 'GET')
end)
