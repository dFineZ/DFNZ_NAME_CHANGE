lib.locale()

Citizen.CreateThread(function()

    if Config.EnableBlip then
        blip = AddBlipForCoord(Config.Location.x, Config.Location.y, Config.Location.z)
        SetBlipDisplay(blip, 4)
        SetBlipSprite(blip, Config.Blip.sprite)
        SetBlipColour(blip, Config.Blip.colour)
        SetBlipScale(blip, Config.Blip.size)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Blip.name)
        EndTextCommandSetBlipName(blip)
    end  

    if Config.EnablePed then
        RequestModel(Config.Location.model)
        while not HasModelLoaded(Config.Location.model) do
            Wait(10)
        end

        npc = CreatePed(4, Config.Location.model, Config.Location.x, Config.Location.y, Config.Location.z - 1.0, Config.Location.rot, false, false)
        FreezeEntityPosition(npc, true)
        SetEntityHeading(npc, Config.Location.rot)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
    end

    exports.ox_target:addSphereZone({
        coords = vec3(Config.Location.x, Config.Location.y, Config.Location.z),
        radius = 1.0,
        debug = false,
        drawSprite = Config.Location.drawSprite,
        options = {
            {
                label = locale("change_firstname")..': '..locale("price")..' '..Config.ChangeFirstNamePrice..locale("currency"),
                icon = 'fa-regular fa-hand',
                iconColor = Config.IconColor,
                onSelect = function()
                    local input = lib.inputDialog(locale("change_firstname"), {
                        {type = 'input', description = locale("enter_name"), placeholder = 'Lebron'}
                    })
                    if input == nil then
                        lib.notify({
                            title = locale("notify_title"),
                            description = locale("no_input"),
                            duration = Config.NotifyDuration,
                            position = Config.NotifyPosition,
                            type = 'error',
                        })
                    else
                        local firstname = input[1]
                        TriggerServerEvent('DFNZ_NAME_CHANGE:change_firstname', firstname)
                    end
                end
            },
            {
                label = locale("change_lastname")..': '..locale("price")..' '..Config.ChangeLastNamePrice..locale("currency"),
                icon = 'fa-regular fa-hand',
                iconColor = Config.IconColor,
                onSelect = function()
                    local input = lib.inputDialog(locale("change_lastname"), {
                        {type = 'input', description = locale("enter_name"), placeholder = 'James'}
                    })
                    if input == nil then
                        lib.notify({
                            title = locale("notify_title"),
                            description = locale("no_input"),
                            duration = Config.NotifyDuration,
                            position = Config.NotifyPosition,
                            type = 'error',
                        })
                    else
                        local lastname = input[1]
                        TriggerServerEvent('DFNZ_NAME_CHANGE:change_lastname', lastname)
                    end
                end
            },
        }
    })
end)
