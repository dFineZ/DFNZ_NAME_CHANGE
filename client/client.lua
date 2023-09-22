local pos = {x = 1135.8882, y = -784.9349, z = 57.5987, rot = 319.8426}
local isNearPed = false
local isAtPed = false
local isPedLoaded = false
local pedModel = GetHashKey("cs_barry")
local npc

Citizen.CreateThread(function()

    while true do
    
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        local distance = Vdist(playerCoords, pos.x, pos.y, pos.z)
        isNearPed = false
        isAtPed = false

        if distance < 25 then
            isNearPed = true
            if not isPedLoaded then
                RequestModel(pedModel)
                while not HasModelLoaded(pedModel) do
                    Wait(10)
                end

                npc = CreatePed(4, pedModel, pos.x, pos.y, pos.z - 1.0, pos.rot, false, false)
                FreezeEntityPosition(npc, true)
                SetEntityHeading(npc, pos.rot)
                SetEntityInvincible(npc, true)
                SetBlockingOfNonTemporaryEvents(npc, true)

                isPedLoaded = true
            end
        end

        if isPedLoaded and not isNearPed then
            DeleteEntity(npc)
            SetModelAsNoLongerNeeded(pedModel)
            isPedLoaded = false        
        end

        if distance < 2.0 then
            isAtPed = true
        end
        Citizen.Wait(500)
    end

end)

Citizen.CreateThread(function()

    while true do
        if isAtPed then
            ESX.ShowFloatingHelpNotification(Config.Text["floatingtext"], vector3(pos.x, pos.y, pos.z + 0.85))

            lib.showTextUI(Config.Text["textui"], {
                position = 'right-center',
                icon = 'user',
                iconColor = '#FF6000'
            })

            if IsControlJustReleased(0, 38) then
                TriggerEvent('DFNZ_NAME_CHANGE:main_menu')
                lib.hideTextUI()
            end
        end

        if not isAtPed then
            lib.hideTextUI()
        end
        Citizen.Wait(1)
    end
end)

RegisterNetEvent('DFNZ_NAME_CHANGE:main_menu', function()

    lib.registerContext({
        id = 'name_change_menu',
        title = Config.Text["namechange"],
        options = {
            {
                title = Config.Text["firstname_change"],
                description = Config.Text["fistname_change_desc"]..' '..Config.firstnamePrice..'$',
                icon = 'user',
                iconColor = '#FF6000',
                event = 'DFNZ_NAME_CHANGE:firstname_input',
            },
            {
                title = Config.Text["lastname_change"],
                description = Config.Text["lastname_change_desc"]..' '..Config.lastnamePrice..'$',
                icon = 'user',
                iconColor = '#FF6000',
                event = 'DFNZ_NAME_CHANGE:lastname_input',
            },
        }
    })

    lib.showContext('name_change_menu')

end)

RegisterNetEvent('DFNZ_NAME_CHANGE:firstname_input', function()
    local input = lib.inputDialog(Config.Text["firstname_change"], {
        {type = 'input', label = Config.Text["enter_firstname"], placeholder = Config.Text["firstname_placeholder"], icon = 'user', required = true}
    })
    
    local firstname = input[1]

    if input == nil then
        return nil
    else
        return TriggerServerEvent('DFNZ_NAME_CHANGE:change_firstname', firstname)
    end
end)

RegisterNetEvent('DFNZ_NAME_CHANGE:lastname_input', function()
    local input = lib.inputDialog(Config.Text["lastname_change"], {
        {type = 'input', label = Config.Text["enter_lastname"], placeholder = Config.Text["lastname_placeholder"], icon = 'user', required = true}
    })
    
    local lastname = input[1]

    if input == nil then
        return nil
    else
        return TriggerServerEvent('DFNZ_NAME_CHANGE:change_lastname', lastname)
    end
end)

CreateThread(function()
    if Config.showBlip == true then

        blip = AddBlipForCoord(pos.x, pos.y, pos.z)
        SetBlipDisplay(blip, 4)
        SetBlipSprite(blip, 409)
        SetBlipColour(blip, 44)
        SetBlipScale(blip, 1.0)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Text["blipname"])
        EndTextCommandSetBlipName(blip)
        
    end   
end)