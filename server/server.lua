lib.locale()

function sendToDiscord(color, name, message, footer)
    local embed = {
          {
              ["color"] = Config.WebhookColor,
              ["title"] = "**NAME CHANGE)**",
              ["description"] = message,
              ["footer"] = {
                  ["text"] = "NAMECHANGER SCRIPT by DFNZ",
                  ["icon_url"] = "https://cdn.discordapp.com/attachments/1141806392496369794/1152893648321646592/DFINEZ_LOGO_NEW.png"
              },
          }
      }
  
    PerformHttpRequest(Config.WebhookURL, function(err, text, headers) end, 'POST', json.encode({username = 'DFNZ', embeds = embed}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('DFNZ_NAME_CHANGE:change_firstname')
AddEventHandler('DFNZ_NAME_CHANGE:change_firstname', function(firstname) 
    local xPlayer = ESX.GetPlayerFromId(source)
    local Price = Config.ChangeFirstNamePrice
    local PlayerMoney = xPlayer.getMoney()

    if PlayerMoney >= Price then

        sendToDiscord(color, title, '**OLD NAME: **'..xPlayer.name..'\n**ID:** '..xPlayer.source..'\n**IDENTIFIER:** '..xPlayer.getIdentifier()..'\n**NEW FIRSTNAME:** '..firstname, footer)

        MySQL.Async.execute('UPDATE users SET firstname = @firstname WHERE identifier = @identifier', {
            ['@firstname'] = firstname,
            ['@identifier'] = xPlayer.identifier
        })
        TriggerClientEvent('ox_lib:notify', source, {
            title = locale("notify_title"), 
            description = locale("new_firstname")..firstname, 
            type = 'success',
            position = Config.NotifyPosition,
            duration = Config.NotifyDuration
        })
        TriggerClientEvent('ox_lib:notify', source, {
            title = locale("notify_title"), 
            description = locale("reconnect_message"), 
            type = 'info',
            position = Config.NotifyPosition,
            duration = Config.NotifyDuration
        })
        xPlayer.removeMoney(Price)
    else
        TriggerClientEvent('ox_lib:notify', source, {
            title = locale("notify_title"), 
            description = locale("not_enough_money"), 
            type = 'error',
            position = Config.NotifyPosition,
            duration = Config.NotifyDuration
        })
    end
end)

RegisterServerEvent('DFNZ_NAME_CHANGE:change_lastname')
AddEventHandler('DFNZ_NAME_CHANGE:change_lastname', function(lastname) 
    local xPlayer = ESX.GetPlayerFromId(source)
    local Price = Config.ChangeLastNamePrice
    local PlayerMoney = xPlayer.getMoney()

    if PlayerMoney >= Price then

        sendToDiscord(color, title, '**OLD NAME: **'..xPlayer.name..'\n**ID:** '..xPlayer.source..'\n**IDENTIFIER:** '..xPlayer.getIdentifier()..'\n**NEW LASTNAME:** '..lastname, footer)

        MySQL.Async.execute('UPDATE users SET lastname = @lastname WHERE identifier = @identifier', {
            ['@lastname'] = lastname,
            ['@identifier'] = xPlayer.identifier
        })
        TriggerClientEvent('ox_lib:notify', source, {
            title = locale("notify_title"), 
            description = locale("new_lastname")..lastname, 
            type = 'success',
            position = Config.NotifyPosition,
            duration = Config.NotifyDuration
        })
        TriggerClientEvent('ox_lib:notify', source, {
            title = locale("notify_title"), 
            description = locale("reconnect_message"), 
            type = 'info',
            position = Config.NotifyPosition,
            duration = Config.NotifyDuration
        })
        xPlayer.removeMoney(Price)
    else
        TriggerClientEvent('ox_lib:notify', source, {
            title = locale("notify_title"), 
            description = locale("not_enough_money"), 
            type = 'error',
            position = Config.NotifyPosition,
            duration = Config.NotifyDuration
        })
    end
end)
