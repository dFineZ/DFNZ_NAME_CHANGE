local xPlayer = ESX.GetPlayerFromId()

function sendToDiscord(color, name, message, footer)
    local embed = {
          {
              ["color"] = Config.WebhookColor,
              ["title"] = "**"..Config.Text["webhook_title"].."**",
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
    local Price = Config.firstnamePrice
    local PlayerMoney = xPlayer.getMoney()

    if PlayerMoney >= Price then

        sendToDiscord(color, title, '**OLD NAME: **'..xPlayer.name..'\n**ID:** '..xPlayer.source..'\n**IDENTIFIER:** '..xPlayer.getIdentifier()..'\n**NEW FIRSTNAME:** '..firstname, footer)

        MySQL.Async.execute('UPDATE users SET firstname = @firstname WHERE identifier = @identifier', {
            ['@firstname'] = firstname,
            ['@identifier'] = xPlayer.identifier
        })
        TriggerClientEvent('esx:showNotification', source, Config.Text["new_firstname"]..firstname)
        TriggerClientEvent('esx:showNotification', source, Config.Text["reconnect_message"])
        xPlayer.removeMoney(Price)
    else
        TriggerClientEvent('esx:showNotification', source, Config.Text["not_enough_money"])
    end
end)

RegisterServerEvent('DFNZ_NAME_CHANGE:change_lastname')
AddEventHandler('DFNZ_NAME_CHANGE:change_lastname', function(lastname) 
    local xPlayer = ESX.GetPlayerFromId(source)
    local Price = Config.lastnamePrice
    local PlayerMoney = xPlayer.getMoney()

    if PlayerMoney >= Price then

        sendToDiscord(color, title, '**OLD NAME: **'..xPlayer.getName..'\n**ID:** '..xPlayer.source..'\n**IDENTIFIER:** '..xPlayer.getIdentifier()..'\n**NEW LASTNAME:** '..lastname, footer)

        MySQL.Async.execute('UPDATE users SET lastname = @lastname WHERE identifier = @identifier', {
            ['@lastname'] = lastname,
            ['@identifier'] = xPlayer.identifier
        })
        TriggerClientEvent('esx:showNotification', source, Config.Text["new_lastname"]..lastname)
        TriggerClientEvent('esx:showNotification', source, Config.Text["reconnect_message"])
        xPlayer.removeMoney(Price)
    else
        TriggerClientEvent('esx:showNotification', source, Config.Text["not_enough_money"])
    end
end)

AddEventHandler('onResourceStart', function()
    print('Thanks for using one of my Scripts. Greeting DFNZ :)')
end)
