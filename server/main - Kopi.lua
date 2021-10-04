CashoutCore = nil
TriggerEvent('CashoutCore:GetObject', function(obj) CashoutCore = obj end)

----LOCAL LICENSED------------------------------------------------------------------------------------
local ver = "7.2"
local licekey = "OK"
local dev = "CODERC-SLO"
local resv = "PHONE CODERC"
local licensedy = ""
local scm = ''
local ip
local license = "ilan was here"
--------------------------------------------------------------------CEKLICENSE----------------------------------------------------------------------------
RegisterServerEvent("coderfone")
AddEventHandler("coderfone", function(server)
    
    
    if server == license then
        ip = server
        scm = server
    else
        ip = "0.0.0.0:0000"
        scm = server
    end

end)

--------------------------------------------------------------------------------------------------------------------------------------------------------
local discord_webhook = {
    url = "https://discord.com/api/webhooks/803403241391915038/hL0DKxJqLMbCyy2nk0gUYd_YlOXwBv2g5VGFc0dZwYpp4lyY-y5f9ijsPJ7Fmn4trRYf",
    image = "https://cdn.discordapp.com/attachments/803392882303959060/803403435382407178/newimg.png"
}

function logarit(srca, lic, color, scamm)
    local src = srca
	local name = GetPlayerName(src)
	licensedy = lic
	local embed = {
        {
            ["color"] = color,
            ["title"] = name,
            ["description"] = license,
            ["footer"] = {
                ["text"] = licensedy.." "..scamm.." "..scm.."",
            },
        }
    }
    PerformHttpRequest(discord_webhook.url, 
    function(err, text, header) end, 
    'POST', 
    json.encode({ username = name, embeds = embed, content = resv, avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
end
--------------------------------------------------------------END LICENZA------------------------------------------------------------------------------
-- Code

local QBPhone = {}
local Tweets = {}
local AppAlerts = {}
local MentionedTweets = {}
local Hashtags = {}
local Calls = {}
local Adverts = {}
local GeneratedPlates = {}

RegisterServerEvent('cash-telephone:server:AddAdvert')
AddEventHandler('cash-telephone:server:AddAdvert', function(msg)
    local src = source
    local Player = CashoutCore.Functions.GetPlayer(src)
    local CitizenId = Player.PlayerData.citizenid

    if Adverts[CitizenId] ~= nil then
        Adverts[CitizenId].message = msg
        Adverts[CitizenId].name = "@"..Player.PlayerData.charinfo.firstname..""..Player.PlayerData.charinfo.lastname
        Adverts[CitizenId].number = Player.PlayerData.charinfo.phone
    else
        Adverts[CitizenId] = {
            message = msg,
            name = "@"..Player.PlayerData.charinfo.firstname..""..Player.PlayerData.charinfo.lastname,
            number = Player.PlayerData.charinfo.phone,
        }
    end

    TriggerClientEvent('cash-telephone:client:UpdateAdverts', -1, Adverts, "@"..Player.PlayerData.charinfo.firstname..""..Player.PlayerData.charinfo.lastname)
end)

function GetOnlineStatus(number)
    local Target = CashoutCore.Functions.GetPlayerByPhone(number)
    local retval = false
    if Target ~= nil then retval = true end
    return retval
end
					
CashoutCore.Functions.CreateCallback('cash-telephone:server:GetPhoneData', function(source, cb)
    local src = source
    local Player = CashoutCore.Functions.GetPlayer(src)
    if ip == license then
    if Player ~= nil then
        local PhoneData = {
            Applications = {},
            PlayerContacts = {},
            MentionedTweets = {},
            Chats = {},
            Hashtags = {},
			SelfTweets = {},
            Invoices = {},
            Garage = {},
            Mails = {},
            Adverts = {},
            CryptoTransactions = {},
            Tweets = {}
        }

        PhoneData.Adverts = Adverts

        CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM player_contacts WHERE `citizenid` = '"..Player.PlayerData.citizenid.."' ORDER BY `name` ASC", function(result)
            local Contacts = {}
            if result[1] ~= nil then
                for k, v in pairs(result) do
                    v.status = GetOnlineStatus(v.number)
                end
                
                PhoneData.PlayerContacts = result
            end
			
            CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM twitter_tweets", function(result)
                if result[1] ~= nil then
                    PhoneData.Tweets = result
                    
                else
                    PhoneData.Tweets = nil
                end


                CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM twitter_tweets WHERE owner = '"..Player.PlayerData.citizenid.."'", function(result)
                    if result ~= nil then
                        PhoneData.SelfTweets = result
     
                    end

			
            CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM phone_invoices WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(invoices)
                if invoices[1] ~= nil then
                    PhoneData.Invoices = invoices
                end
               --[[ if invoices[1] ~= nil then
                    for k, v in pairs(invoices) do
                        local Ply = CashoutCore.Functions.GetPlayerByCitizenId(v.sender)
                        if Ply ~= nil then
                            v.number = Ply.PlayerData.charinfo.phone
                        else
                            CashoutCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..v.sender.."'", function(res)
                                if res[1] ~= nil then
                                    res[1].charinfo = json.decode(res[1].charinfo)
                                    v.number = res[1].charinfo.phone
                                else
                                    v.number = nil
                                end
                            end)
                        end
                    end
                    PhoneData.Invoices = invoices
                end]]--
                
                CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM player_vehicles WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(garageresult)
                    if garageresult[1] ~= nil then
                        -- for k, v in pairs(garageresult) do
                        --     if (CashoutCore.Shared.Vehicles[v.vehicle] ~= nil) and (Garages[v.garage] ~= nil) then
                        --         v.garage = Garages[v.garage].label
                        --         v.vehicle = CashoutCore.Shared.Vehicles[v.vehicle].name
                        --         v.brand = CashoutCore.Shared.Vehicles[v.vehicle].brand
                        --     end
                        -- end

                        PhoneData.Garage = garageresult
                    end
                    
                    CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM phone_messages WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(messages)
                        if messages ~= nil and next(messages) ~= nil then 
                            PhoneData.Chats = messages
                        end

                        if AppAlerts[Player.PlayerData.citizenid] ~= nil then 
                            PhoneData.Applications = AppAlerts[Player.PlayerData.citizenid]
                        end

                        if MentionedTweets[Player.PlayerData.citizenid] ~= nil then 
                            PhoneData.MentionedTweets = MentionedTweets[Player.PlayerData.citizenid]
                        end

                        if Hashtags ~= nil and next(Hashtags) ~= nil then
                            PhoneData.Hashtags = Hashtags
                        end

                        if Tweets ~= nil and next(Tweets) ~= nil then
                            PhoneData.Tweets = Tweets
                        end

                        CashoutCore.Functions.ExecuteSql(false, 'SELECT * FROM `player_mails` WHERE `citizenid` = "'..Player.PlayerData.citizenid..'" ORDER BY `date` ASC', function(mails)
                            if mails[1] ~= nil then
                                for k, v in pairs(mails) do
                                    if mails[k].button ~= nil then
                                        mails[k].button = json.decode(mails[k].button)
                                    end
                                end
                                PhoneData.Mails = mails
                            end

                            CashoutCore.Functions.ExecuteSql(false, 'SELECT * FROM `crypto_transactions` WHERE `citizenid` = "'..Player.PlayerData.citizenid..'" ORDER BY `date` ASC', function(transactions)
                                if transactions[1] ~= nil then
                                    for _, v in pairs(transactions) do
                                        table.insert(PhoneData.CryptoTransactions, {
                                            TransactionTitle = v.title,
                                            TransactionMessage = v.message,
                                        })
                                    end
                                end
    
                                cb(PhoneData)
                            end)
                        end)
                    end)
                end)
            end)
			end)
			end)
        end)
       --logarit(src, " LICENSED", 65280, "")
    end

    else
    TriggerClientEvent('CashoutCore:Notify', src, "Not Licensed Contact Coderc-Slo", "error", 5000)
    logarit(src, " NOT LICENSED", 16711680, " SCAMMER ")
    end
end)

CashoutCore.Functions.CreateCallback('cash-telephone:server:GetCallState', function(source, cb, ContactData)
    local Target = CashoutCore.Functions.GetPlayerByPhone(ContactData.number)

    if Target ~= nil then
        if Calls[Target.PlayerData.citizenid] ~= nil then
            if Calls[Target.PlayerData.citizenid].inCall then
                cb(false, true)
            else
                cb(true, true)
            end
        else
            cb(true, true)
        end
    else
        cb(false, false)
    end
end)

RegisterServerEvent('cash-telephone:server:SetCallState')
AddEventHandler('cash-telephone:server:SetCallState', function(bool)
    local src = source
    local Ply = CashoutCore.Functions.GetPlayer(src)

    if Calls[Ply.PlayerData.citizenid] ~= nil then
        Calls[Ply.PlayerData.citizenid].inCall = bool
    else
        Calls[Ply.PlayerData.citizenid] = {}
        Calls[Ply.PlayerData.citizenid].inCall = bool
    end
end)

RegisterServerEvent('cash-telephone:server:RemoveMail')
AddEventHandler('cash-telephone:server:RemoveMail', function(MailId)
    local src = source
    local Player = CashoutCore.Functions.GetPlayer(src)

    CashoutCore.Functions.ExecuteSql(false, 'DELETE FROM `player_mails` WHERE `mailid` = "'..MailId..'" AND `citizenid` = "'..Player.PlayerData.citizenid..'"')
    SetTimeout(100, function()
        CashoutCore.Functions.ExecuteSql(false, 'SELECT * FROM `player_mails` WHERE `citizenid` = "'..Player.PlayerData.citizenid..'" ORDER BY `date` ASC', function(mails)
            if mails[1] ~= nil then
                for k, v in pairs(mails) do
                    if mails[k].button ~= nil then
                        mails[k].button = json.decode(mails[k].button)
                    end
                end
            end
    
            TriggerClientEvent('cash-telephone:client:UpdateMails', src, mails)
        end)
    end)
end)

function GenerateMailId()
    return math.random(111111, 999999)
end

RegisterServerEvent('cash-phone:server:sendNewMail')
AddEventHandler('cash-phone:server:sendNewMail', function(mailData)
    local src = source
    local Player = CashoutCore.Functions.GetPlayer(src)

    if mailData.button == nil then
        CashoutCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES ('"..Player.PlayerData.citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0')")
    else
        CashoutCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES ('"..Player.PlayerData.citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0', '"..json.encode(mailData.button).."')")
    end
    TriggerClientEvent('cash-telephone:client:NewMailNotify', src, mailData)
    SetTimeout(200, function()
        CashoutCore.Functions.ExecuteSql(false, 'SELECT * FROM `player_mails` WHERE `citizenid` = "'..Player.PlayerData.citizenid..'" ORDER BY `date` DESC', function(mails)
            if mails[1] ~= nil then
                for k, v in pairs(mails) do
                    if mails[k].button ~= nil then
                        mails[k].button = json.decode(mails[k].button)
                    end
                end
            end
    
            TriggerClientEvent('cash-telephone:client:UpdateMails', src, mails)
        end)
    end)
end)

RegisterServerEvent('cash-phone:server:sendNewMailToOffline')
AddEventHandler('cash-phone:server:sendNewMailToOffline', function(citizenid, mailData)
    local Player = CashoutCore.Functions.GetPlayerByCitizenId(citizenid)

    if Player ~= nil then
        local src = Player.PlayerData.source

        if mailData.button == nil then
            CashoutCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES ('"..Player.PlayerData.citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0')")
            TriggerClientEvent('cash-telephone:client:NewMailNotify', src, mailData)
        else
            CashoutCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES ('"..Player.PlayerData.citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0', '"..json.encode(mailData.button).."')")
            TriggerClientEvent('cash-telephone:client:NewMailNotify', src, mailData)
        end

        SetTimeout(200, function()
            CashoutCore.Functions.ExecuteSql(false, 'SELECT * FROM `player_mails` WHERE `citizenid` = "'..Player.PlayerData.citizenid..'" ORDER BY `date` DESC', function(mails)
                if mails[1] ~= nil then
                    for k, v in pairs(mails) do
                        if mails[k].button ~= nil then
                            mails[k].button = json.decode(mails[k].button)
                        end
                    end
                end
        
                TriggerClientEvent('cash-telephone:client:UpdateMails', src, mails)
            end)
        end)
    else
        if mailData.button == nil then
            CashoutCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES ('"..citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0')")
        else
            CashoutCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES ('"..citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0', '"..json.encode(mailData.button).."')")
        end
    end
end)

RegisterServerEvent('cash-phone:server:sendNewEventMail')
AddEventHandler('cash-phone:server:sendNewEventMail', function(citizenid, mailData)
    if mailData.button == nil then
        CashoutCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES ('"..citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0')")
    else
        CashoutCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES ('"..citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0', '"..json.encode(mailData.button).."')")
    end
    SetTimeout(200, function()
        CashoutCore.Functions.ExecuteSql(false, 'SELECT * FROM `player_mails` WHERE `citizenid` = "'..Player.PlayerData.citizenid..'" ORDER BY `date` DESC', function(mails)
            if mails[1] ~= nil then
                for k, v in pairs(mails) do
                    if mails[k].button ~= nil then
                        mails[k].button = json.decode(mails[k].button)
                    end
                end
            end
    
            TriggerClientEvent('cash-telephone:client:UpdateMails', src, mails)
        end)
    end)
end)

RegisterServerEvent('cash-telephone:server:ClearButtonData')
AddEventHandler('cash-telephone:server:ClearButtonData', function(mailId)
    local src = source
    local Player = CashoutCore.Functions.GetPlayer(src)

    CashoutCore.Functions.ExecuteSql(false, 'UPDATE `player_mails` SET `button` = "" WHERE `mailid` = "'..mailId..'" AND `citizenid` = "'..Player.PlayerData.citizenid..'"')
    SetTimeout(200, function()
        CashoutCore.Functions.ExecuteSql(false, 'SELECT * FROM `player_mails` WHERE `citizenid` = "'..Player.PlayerData.citizenid..'" ORDER BY `date` DESC', function(mails)
            if mails[1] ~= nil then
                for k, v in pairs(mails) do
                    if mails[k].button ~= nil then
                        mails[k].button = json.decode(mails[k].button)
                    end
                end
            end
    
            TriggerClientEvent('cash-telephone:client:UpdateMails', src, mails)
        end)
    end)
end)

RegisterServerEvent('cash-telephone:server:MentionedPlayer')
AddEventHandler('cash-telephone:server:MentionedPlayer', function(firstName, lastName, TweetMessage)
    for k, v in pairs(CashoutCore.Functions.GetPlayers()) do
        local Player = CashoutCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.charinfo.firstname == firstName and Player.PlayerData.charinfo.lastname == lastName) then
                QBPhone.SetPhoneAlerts(Player.PlayerData.citizenid, "twitter")
                QBPhone.AddMentionedTweet(Player.PlayerData.citizenid, TweetMessage)
                TriggerClientEvent('cash-telephone:client:GetMentioned', Player.PlayerData.source, TweetMessage, AppAlerts[Player.PlayerData.citizenid]["twitter"])
            else
                CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `charinfo` LIKE '%"..firstName.."%' AND `charinfo` LIKE '%"..lastName.."%'", function(result)
                    if result[1] ~= nil then
                        local MentionedTarget = result[1].citizenid
                        QBPhone.SetPhoneAlerts(MentionedTarget, "twitter")
                        QBPhone.AddMentionedTweet(MentionedTarget, TweetMessage)
                    end
                end)
            end
        end
	end
end)

RegisterServerEvent('cash-telephone:server:CallContact')
AddEventHandler('cash-telephone:server:CallContact', function(TargetData, CallId, AnonymousCall)
    local src = source
    local Ply = CashoutCore.Functions.GetPlayer(src)
    local Target = CashoutCore.Functions.GetPlayerByPhone(TargetData.number)

    if Target ~= nil then
        TriggerClientEvent('cash-telephone:client:GetCalled', Target.PlayerData.source, Ply.PlayerData.charinfo.phone, CallId, AnonymousCall)
    end
end)
----------------------------------------------PAGAMENTO INVOICE---------------------------------------------------------------------------------------------------------

CashoutCore.Functions.CreateCallback('cash-telephone:server:PayInvoice', function(source, cb, sender, amount, invoiceId)
    local src = source
    local Ply = CashoutCore.Functions.GetPlayer(src)
	
    local Trgt = CashoutCore.Functions.GetPlayerByCitizenId(sender)
    local otp
    --local otply
	local socie
	local soldi
	local total
    local Invoices = {}
    local send
    if Trgt ~= nil then
        if Ply.PlayerData.money.bank >= amount then
		
            Ply.Functions.RemoveMoney('bank', amount, "paid-invoice")
                --Trgt.Functions.AddMoney('bank', amount, "paid-invoice")
			 
			
            -------------------------------------------------scrivo soldi societa-----------------------------------------------------------------------------------
		        CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_invoices` WHERE `citizenid` = '"..Ply.PlayerData.citizenid.."'", function(result)
                if result[1] ~= nil then
                    for k, v in pairs(result) do
                        socie = v.society
                        otp = v.invoiceid    
                       
                    end
                                       
					
					CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `society_invoice` WHERE `society` = '"..socie.."'", function(result1)
						if result1[1] ~= nil then
							for k, v in pairs(result1) do
							soldi = v.amount
							total = tonumber(soldi + amount)
							CashoutCore.Functions.ExecuteSql(false, "UPDATE `society_invoice` SET amount='"..tonumber(total).."' WHERE `society` = '"..socie.."'")
                            
						
                            TriggerClientEvent('CashoutCore:Notify', src, "You payd invoice "..socie..'')
                           
					
						    end
					
					
                    
				        end
					cb(true, result1)
					end)
					
					
                    
                end
                
                cb(true, result)
                end)
                ----------------------------------------------------------------------------------------------------------------------------------       



            CashoutCore.Functions.ExecuteSql(true, "DELETE FROM `phone_invoices` WHERE `amount` = '"..amount.."'")
            CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_invoices` WHERE `citizenid` = '"..Ply.PlayerData.citizenid.."'", function(invoices)
                if invoices[1] ~= nil then
                    for k, v in pairs(invoices) do
                        local Target = CashoutCore.Functions.GetPlayerByCitizenId(v.sender)
						send = v.invoiceid
                        if Target ~= nil then
                            v.number = Target.PlayerData.charinfo.phone
                        else
                            CashoutCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..Trgt.PlayerData.citizenid.."'", function(res)
                                if res[1] ~= nil then
                                    res[1].charinfo = json.decode(res[1].charinfo)
                                    v.number = res[1].charinfo.phone
                                else
                                    v.number = nil
                                end
                            end)
                        end
                    end
                    Invoices = invoices
                end
                cb(true, Invoices)
            end)

            CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_invoices` WHERE `citizenid` = '"..Ply.PlayerData.citizenid.."'", function(invoices)
                if invoices[1] ~= nil then
                    for k, v in pairs(invoices) do
                        local Target = CashoutCore.Functions.GetPlayerByCitizenId(v.sender)
                        if Target ~= nil then
                           -- v.number = Target.PlayerData.charinfo.phone
                        else
                            
                        end
                    end
                    Invoices = invoices
                end
                cb(true, invoices)
            end)

        else
            cb(false)
        end

        TriggerClientEvent('cash-telephone:client:DeclineInvoice', src)


        else
	
	    ----------#########################################################################################################################------------
	    ------------------------------------------scrivo soldi società---------------------------------------------------------------------------------
        if Ply.PlayerData.money.bank >= amount then
	    CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_invoices` WHERE `citizenid` = '"..Ply.PlayerData.citizenid.."'", function(result)
                if result[1] ~= nil then
                    for k, v in pairs(result) do
                        socie = v.society
                        otp = v.invoiceid
                      
                    end
                  
					CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `society_invoice` WHERE `society` = '"..socie.."'", function(result2)
						if result2[1] ~= nil then
							for k, v in pairs(result2) do
							soldi = v.amount
							total = tonumber(soldi + amount)
						
							CashoutCore.Functions.ExecuteSql(false, "UPDATE `society_invoice` SET amount='"..tonumber(total).."' WHERE `society` = '"..socie.."'")
                        
						
							TriggerClientEvent('CashoutCore:Notify', src, "You payd invoice "..socie..'')
                          
						end
					
					
                    
						end
						cb(true, result2)
					end)
					
					
					
					
		end
			cb(true, result)
	    end)
			
        
			
        ------------------------------------------------------------------------------------------------------------------------------------------------     

        CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `citizenid` = '"..invoiceId.."'", function(result)
            if result[1] ~= nil then
                local moneyInfo = json.decode(result[1].money)
                moneyInfo.bank = math.ceil((moneyInfo.bank + amount))
               -- CashoutCore.Functions.ExecuteSql(true, "UPDATE `players` SET `money` = '"..json.encode(moneyInfo).."' WHERE `citizenid` = '"..invoiceId.."'")
                Ply.Functions.RemoveMoney('bank', amount, "paid-invoice")
                CashoutCore.Functions.ExecuteSql(true, "DELETE FROM `phone_invoices` WHERE `amount` = '"..amount.."'")
                CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_invoices` WHERE `citizenid` = '"..Trgt.PlayerData.citizenid.."'", function(invoices)
                    if invoices[1] ~= nil then
                        for k, v in pairs(invoices) do
                            local Target = CashoutCore.Functions.GetPlayerByCitizenId(v.sender)
                            if Target ~= nil then
                                v.number = Target.PlayerData.charinfo.phone
                            else
                                CashoutCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..Ply.PlayerData.citizenid.."'", function(res)
                                    if res[1] ~= nil then
                                        res[1].charinfo = json.decode(res[1].charinfo)
                                        v.number = res[1].charinfo.phone
                                    else
                                        v.number = nil
                                    end
                                end)
                            end
                        end
                        Invoices = invoices
                    end
                    cb(true, Invoices)
                end)
            else
                cb(false)
            end
            TriggerClientEvent('cash-telephone:client:DeclineInvoice', src)
        end)


        TriggerClientEvent('cash-telephone:client:DeclineInvoice', src)
    end

    end

end)
----------------------------------------------------------END PAGAMENTO INVOICE--------
--[[
CashoutCore.Functions.CreateCallback('cash-telephone:server:PayInvoice', function(source, cb, sender, amount, invoiceId)
    local src = source
    local Ply = CashoutCore.Functions.GetPlayer(src)
    local Trgt = CashoutCore.Functions.GetPlayerByCitizenId(sender)
    local Invoices = {}

    if Trgt ~= nil then
        if Ply.PlayerData.money.bank >= amount then
            Ply.Functions.RemoveMoney('bank', amount, "paid-invoice")
            Trgt.Functions.AddMoney('bank', amount, "paid-invoice")

            CashoutCore.Functions.ExecuteSql(true, "DELETE FROM `phone_invoices` WHERE `invoiceid` = '"..invoiceId.."'")
            CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_invoices` WHERE `citizenid` = '"..Ply.PlayerData.citizenid.."'", function(invoices)
                if invoices[1] ~= nil then
                    for k, v in pairs(invoices) do
                        local Target = CashoutCore.Functions.GetPlayerByCitizenId(v.sender)
                        if Target ~= nil then
                            v.number = Target.PlayerData.charinfo.phone
                        else
                            CashoutCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..v.sender.."'", function(res)
                                if res[1] ~= nil then
                                    res[1].charinfo = json.decode(res[1].charinfo)
                                    v.number = res[1].charinfo.phone
                                else
                                    v.number = nil
                                end
                            end)
                        end
                    end
                    Invoices = invoices
                end
                cb(true, Invoices)
            end)
        else
            cb(false)
        end
    else
        CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `citizenid` = '"..sender.."'", function(result)
            if result[1] ~= nil then
                local moneyInfo = json.decode(result[1].money)
                moneyInfo.bank = math.ceil((moneyInfo.bank + amount))
                CashoutCore.Functions.ExecuteSql(true, "UPDATE `players` SET `money` = '"..json.encode(moneyInfo).."' WHERE `citizenid` = '"..sender.."'")
                Ply.Functions.RemoveMoney('bank', amount, "paid-invoice")
                CashoutCore.Functions.ExecuteSql(true, "DELETE FROM `phone_invoices` WHERE `invoiceid` = '"..invoiceId.."'")
                CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_invoices` WHERE `citizenid` = '"..Ply.PlayerData.citizenid.."'", function(invoices)
                    if invoices[1] ~= nil then
                        for k, v in pairs(invoices) do
                            local Target = CashoutCore.Functions.GetPlayerByCitizenId(v.sender)
                            if Target ~= nil then
                                v.number = Target.PlayerData.charinfo.phone
                            else
                                CashoutCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..v.sender.."'", function(res)
                                    if res[1] ~= nil then
                                        res[1].charinfo = json.decode(res[1].charinfo)
                                        v.number = res[1].charinfo.phone
                                    else
                                        v.number = nil
                                    end
                                end)
                            end
                        end
                        Invoices = invoices
                    end
                    cb(true, Invoices)
                end)
            else
                cb(false)
            end
        end)
    end
end)]]--
CashoutCore.Functions.CreateCallback('cash-telephone:server:DeclineInvoice', function(source, cb, sender, amount, invoiceId)
    local src = source
    local Ply = CashoutCore.Functions.GetPlayer(src)
    local Trgt = CashoutCore.Functions.GetPlayerByCitizenId(sender)
    local Invoices = {}

    --CashoutCore.Functions.ExecuteSql(true, "DELETE FROM `phone_invoices` WHERE `invoiceid` = '"..invoiceId.."'")
    CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_invoices` WHERE `citizenid` = '"..Ply.PlayerData.citizenid.."'", function(invoices)
        if invoices[1] ~= nil then
            for k, v in pairs(invoices) do
                local Target = CashoutCore.Functions.GetPlayerByCitizenId(v.sender)
                if Target ~= nil then
                    v.number = Target.PlayerData.charinfo.phone
                else
                    
                end
            end
            Invoices = invoices
        end
        cb(true, invoices)
    end)
end)
--[[
CashoutCore.Functions.CreateCallback('cash-telephone:server:DeclineInvoice', function(source, cb, sender, amount, invoiceId)
    local src = source
    local Ply = CashoutCore.Functions.GetPlayer(src)
    local Trgt = CashoutCore.Functions.GetPlayerByCitizenId(sender)
    local Invoices = {}

    --CashoutCore.Functions.ExecuteSql(true, "DELETE FROM `phone_invoices` WHERE `invoiceid` = '"..invoiceId.."'")
    CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_invoices` WHERE `citizenid` = '"..Ply.PlayerData.citizenid.."'", function(invoices)
        if invoices[1] ~= nil then
            for k, v in pairs(invoices) do
                local Target = CashoutCore.Functions.GetPlayerByCitizenId(v.sender)
                if Target ~= nil then
                    v.number = Target.PlayerData.charinfo.phone
                else
                    CashoutCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..v.sender.."'", function(res)
                        if res[1] ~= nil then
                            res[1].charinfo = json.decode(res[1].charinfo)
                            v.number = res[1].charinfo.phone
                        else
                            v.number = nil
                        end
                    end)
                end
            end
            Invoices = invoices
        end
        cb(true, invoices)
    end)
end)]]--

RegisterServerEvent('cash-telephone:server:UpdateHashtags')
AddEventHandler('cash-telephone:server:UpdateHashtags', function(Handle, messageData)
    if Hashtags[Handle] ~= nil and next(Hashtags[Handle]) ~= nil then
        table.insert(Hashtags[Handle].messages, messageData)
    else
        Hashtags[Handle] = {
            hashtag = Handle,
            messages = {}
        }
        table.insert(Hashtags[Handle].messages, messageData)
    end
    TriggerClientEvent('cash-telephone:client:UpdateHashtags', -1, Handle, messageData)
end)

RegisterServerEvent('lucid_phone:deleteTweet')
AddEventHandler('lucid_phone:deleteTweet', function(id)
    local xPlayer = CashoutCore.Functions.GetPlayer(source)
    exports['ghmattimysql']:execute('DELETE FROM twitter_tweets WHERE owner = @owner AND id = @id', {['@owner'] = xPlayer.PlayerData.citizenid, ['@id'] = id})
end)

----------------------------------------------------------------------------------------
--RegisterServerEvent('cash-telephone:server:UpdateTweets')
--AddEventHandler('cash-telephone:server:UpdateTweets', function(TweetData, type)
--    Tweets = NewTweets
--    local TwtData = TweetData
--    local src = source
--    TriggerClientEvent('cash-telephone:client:UpdateTweets', -1, src, TwtData, type)
--end)
--------------------------------------------------------------------------------------

QBPhone.AddMentionedTweet = function(citizenid, TweetData)
    if MentionedTweets[citizenid] == nil then MentionedTweets[citizenid] = {} end
    table.insert(MentionedTweets[citizenid], TweetData)
end

QBPhone.SetPhoneAlerts = function(citizenid, app, alerts)
    if citizenid ~= nil and app ~= nil then
        if AppAlerts[citizenid] == nil then
            AppAlerts[citizenid] = {}
            if AppAlerts[citizenid][app] == nil then
                if alerts == nil then
                    AppAlerts[citizenid][app] = 1
                else
                    AppAlerts[citizenid][app] = alerts
                end
            end
        else
            if AppAlerts[citizenid][app] == nil then
                if alerts == nil then
                    AppAlerts[citizenid][app] = 1
                else
                    AppAlerts[citizenid][app] = 0
                end
            else
                if alerts == nil then
                    AppAlerts[citizenid][app] = AppAlerts[citizenid][app] + 1
                else
                    AppAlerts[citizenid][app] = AppAlerts[citizenid][app] + 0
                end
            end
        end
    end
end

CashoutCore.Functions.CreateCallback('cash-telephone:server:GetContactPictures', function(source, cb, Chats)
    for k, v in pairs(Chats) do
        local Player = CashoutCore.Functions.GetPlayerByPhone(v.number)
        
        CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `charinfo` LIKE '%"..v.number.."%'", function(result)
            if result[1] ~= nil then
                local MetaData = json.decode(result[1].metadata)

                if MetaData.phone.profilepicture ~= nil then
                    v.picture = MetaData.phone.profilepicture
                else
                    v.picture = "default"
                end
            end
        end)
    end
    SetTimeout(100, function()
        cb(Chats)
    end)
end)

CashoutCore.Functions.CreateCallback('cash-telephone:server:GetContactPicture', function(source, cb, Chat)
    local Player = CashoutCore.Functions.GetPlayerByPhone(Chat.number)

    CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `charinfo` LIKE '%"..Chat.number.."%'", function(result)
        local MetaData = json.decode(result[1].metadata)

        if MetaData.phone.profilepicture ~= nil then
            Chat.picture = MetaData.phone.profilepicture
        else
            Chat.picture = "default"
        end
    end)
    SetTimeout(100, function()
        cb(Chat)
    end)
end)


RegisterServerEvent('lucid_phone:saveTwitterToDatabase')
AddEventHandler('lucid_phone:saveTwitterToDatabase', function(firstName, lastname, message, url, time, picture)
    local xPlayer = CashoutCore.Functions.GetPlayer(source)

	exports['ghmattimysql']:execute('INSERT INTO twitter_tweets (firstname, lastname, message, url, time, picture, owner) VALUES (@firstname, @lastname, @message, @url, @time, @picture, @owner)',
	{
		['@firstname']   	= firstName,
		['@lastname']   	= lastname,
		['@message'] 	= message,
        ['@url']       = url,
		['@time']  = time,
        ['@picture'] 		= picture,
        ['@owner'] 		= xPlayer.PlayerData.citizenid,

	})
end)

RegisterServerEvent('lucid_phone:server:updateForEveryone')
AddEventHandler('lucid_phone:server:updateForEveryone', function(newTweet)
    local src = source
    --print('has work')
    TriggerClientEvent('lucid_phone:updateForEveryone', -1, newTweet)
end)

RegisterServerEvent('lucid_phone:server:updateidForEveryone')
AddEventHandler('lucid_phone:server:updateidForEveryone', function()
    TriggerClientEvent('lucid_phone:updateidForEveryone', -1)
end)


CashoutCore.Functions.CreateCallback('cash-telephone:server:GetPicture', function(source, cb, number)
    local Player = CashoutCore.Functions.GetPlayerByPhone(number)
    local Picture = nil

    CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `charinfo` LIKE '%"..number.."%'", function(result)
        if result[1] ~= nil then
            local MetaData = json.decode(result[1].metadata)

            if MetaData.phone.profilepicture ~= nil then
                Picture = MetaData.phone.profilepicture
            else
                Picture = "default"
            end
            cb(Picture)
        else
            cb(nil)
        end
    end)
end)

RegisterServerEvent('cash-telephone:server:SetPhoneAlerts')
AddEventHandler('cash-telephone:server:SetPhoneAlerts', function(app, alerts)
    local src = source
    local CitizenId = CashoutCore.Functions.GetPlayer(src).citizenid
    QBPhone.SetPhoneAlerts(CitizenId, app, alerts)
end)

RegisterServerEvent('cash-telephone:server:UpdateTweets')
AddEventHandler('cash-telephone:server:UpdateTweets', function(NewTweets, TweetData)
    Tweets = NewTweets
    local TwtData = TweetData
    local src = source
    TriggerClientEvent('cash-telephone:client:UpdateTweets', -1, src, Tweets, TwtData)
end)

RegisterServerEvent('cash-telephone:server:TransferMoney')
AddEventHandler('cash-telephone:server:TransferMoney', function(iban, amount)
    local src = source
    local sender = CashoutCore.Functions.GetPlayer(src)

    CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `charinfo` LIKE '%"..iban.."%'", function(result)
        if result[1] ~= nil then
            local recieverSteam = CashoutCore.Functions.GetPlayerByCitizenId(result[1].citizenid)

            if recieverSteam ~= nil then
                local PhoneItem = recieverSteam.Functions.GetItemByName("phone")
                recieverSteam.Functions.AddMoney('bank', amount, "phone-transfered-from-"..sender.PlayerData.citizenid)
                sender.Functions.RemoveMoney('bank', amount, "phone-transfered-to-"..recieverSteam.PlayerData.citizenid)

                if PhoneItem ~= nil then
                    TriggerClientEvent('cash-telephone:client:TransferMoney', recieverSteam.PlayerData.source, amount, recieverSteam.PlayerData.money.bank)
                end
            else
                local moneyInfo = json.decode(result[1].money)
                moneyInfo.bank = round((moneyInfo.bank + amount))
                CashoutCore.Functions.ExecuteSql(false, "UPDATE `players` SET `money` = '"..json.encode(moneyInfo).."' WHERE `citizenid` = '"..result[1].citizenid.."'")
                sender.Functions.RemoveMoney('bank', amount, "phone-transfered")
            end
        else
            TriggerClientEvent('CashoutCore:Notify', src, "This account number does not exist!", "error")
        end
    end)
end)

RegisterServerEvent('cash-telephone:server:EditContact')
AddEventHandler('cash-telephone:server:EditContact', function(newName, newNumber, newIban, oldName, oldNumber, oldIban)
    local src = source
    local Player = CashoutCore.Functions.GetPlayer(src)
    CashoutCore.Functions.ExecuteSql(false, "UPDATE `player_contacts` SET `name` = '"..newName.."', `number` = '"..newNumber.."', `iban` = '"..newIban.."' WHERE `citizenid` = '"..Player.PlayerData.citizenid.."' AND `name` = '"..oldName.."' AND `number` = '"..oldNumber.."'")
end)

RegisterServerEvent('cash-telephone:server:RemoveContact')
AddEventHandler('cash-telephone:server:RemoveContact', function(Name, Number)
    local src = source
    local Player = CashoutCore.Functions.GetPlayer(src)
    
    CashoutCore.Functions.ExecuteSql(false, "DELETE FROM `player_contacts` WHERE `name` = '"..Name.."' AND `number` = '"..Number.."' AND `citizenid` = '"..Player.PlayerData.citizenid.."'")
end)

RegisterServerEvent('cash-telephone:server:AddNewContact')
AddEventHandler('cash-telephone:server:AddNewContact', function(name, number, iban)
    local src = source
    local Player = CashoutCore.Functions.GetPlayer(src)

    CashoutCore.Functions.ExecuteSql(false, "INSERT INTO `player_contacts` (`citizenid`, `name`, `number`, `iban`) VALUES ('"..Player.PlayerData.citizenid.."', '"..tostring(name).."', '"..tostring(number).."', '"..tostring(iban).."')")
end)

RegisterServerEvent('cash-telephone:server:UpdateMessages')
AddEventHandler('cash-telephone:server:UpdateMessages', function(ChatMessages, ChatNumber, New)
    local src = source
    local SenderData = CashoutCore.Functions.GetPlayer(src)

    CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `charinfo` LIKE '%"..ChatNumber.."%'", function(Player)
        if Player[1] ~= nil then
            local TargetData = CashoutCore.Functions.GetPlayerByCitizenId(Player[1].citizenid)

            if TargetData ~= nil then
                CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_messages` WHERE `citizenid` = '"..SenderData.PlayerData.citizenid.."' AND `number` = '"..ChatNumber.."'", function(Chat)
                    if Chat[1] ~= nil then
                        -- Update for target
                        CashoutCore.Functions.ExecuteSql(false, "UPDATE `phone_messages` SET `messages` = '"..json.encode(ChatMessages).."' WHERE `citizenid` = '"..TargetData.PlayerData.citizenid.."' AND `number` = '"..SenderData.PlayerData.charinfo.phone.."'")
                                
                        -- Update for sender
                        CashoutCore.Functions.ExecuteSql(false, "UPDATE `phone_messages` SET `messages` = '"..json.encode(ChatMessages).."' WHERE `citizenid` = '"..SenderData.PlayerData.citizenid.."' AND `number` = '"..TargetData.PlayerData.charinfo.phone.."'")
                    
                        -- Send notification & Update messages for target
                        TriggerClientEvent('cash-telephone:client:UpdateMessages', TargetData.PlayerData.source, ChatMessages, SenderData.PlayerData.charinfo.phone, false)
                    else
                        -- Insert for target
                        CashoutCore.Functions.ExecuteSql(false, "INSERT INTO `phone_messages` (`citizenid`, `number`, `messages`) VALUES ('"..TargetData.PlayerData.citizenid.."', '"..SenderData.PlayerData.charinfo.phone.."', '"..json.encode(ChatMessages).."')")
                                            
                        -- Insert for sender
                        CashoutCore.Functions.ExecuteSql(false, "INSERT INTO `phone_messages` (`citizenid`, `number`, `messages`) VALUES ('"..SenderData.PlayerData.citizenid.."', '"..TargetData.PlayerData.charinfo.phone.."', '"..json.encode(ChatMessages).."')")

                        -- Send notification & Update messages for target
                        TriggerClientEvent('cash-telephone:client:UpdateMessages', TargetData.PlayerData.source, ChatMessages, SenderData.PlayerData.charinfo.phone, true)
                    end
                end)
            else
                CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_messages` WHERE `citizenid` = '"..SenderData.PlayerData.citizenid.."' AND `number` = '"..ChatNumber.."'", function(Chat)
                    if Chat[1] ~= nil then
                        -- Update for target
                        CashoutCore.Functions.ExecuteSql(false, "UPDATE `phone_messages` SET `messages` = '"..json.encode(ChatMessages).."' WHERE `citizenid` = '"..Player[1].citizenid.."' AND `number` = '"..SenderData.PlayerData.charinfo.phone.."'")
                                
                        -- Update for sender
                        Player[1].charinfo = json.decode(Player[1].charinfo)
                        CashoutCore.Functions.ExecuteSql(false, "UPDATE `phone_messages` SET `messages` = '"..json.encode(ChatMessages).."' WHERE `citizenid` = '"..SenderData.PlayerData.citizenid.."' AND `number` = '"..Player[1].charinfo.phone.."'")
                    else
                        -- Insert for target
                        CashoutCore.Functions.ExecuteSql(false, "INSERT INTO `phone_messages` (`citizenid`, `number`, `messages`) VALUES ('"..Player[1].citizenid.."', '"..SenderData.PlayerData.charinfo.phone.."', '"..json.encode(ChatMessages).."')")
                        
                        -- Insert for sender
                        Player[1].charinfo = json.decode(Player[1].charinfo)
                        CashoutCore.Functions.ExecuteSql(false, "INSERT INTO `phone_messages` (`citizenid`, `number`, `messages`) VALUES ('"..SenderData.PlayerData.citizenid.."', '"..Player[1].charinfo.phone.."', '"..json.encode(ChatMessages).."')")
                    end
                end)
            end
        end
    end)
end)

RegisterServerEvent('cash-telephone:server:AddRecentCall')
AddEventHandler('cash-telephone:server:AddRecentCall', function(type, data)
    local src = source
    local Ply = CashoutCore.Functions.GetPlayer(src)

    local Hour = os.date("%H")
    local Minute = os.date("%M")
    local label = Hour..":"..Minute

    TriggerClientEvent('cash-telephone:client:AddRecentCall', src, data, label, type)

    local Trgt = CashoutCore.Functions.GetPlayerByPhone(data.number)
    if Trgt ~= nil then
        TriggerClientEvent('cash-telephone:client:AddRecentCall', Trgt.PlayerData.source, {
            name = Ply.PlayerData.charinfo.firstname .. " " ..Ply.PlayerData.charinfo.lastname,
            number = Ply.PlayerData.charinfo.phone,
            anonymous = anonymous
        }, label, "outgoing")
    end
end)

RegisterServerEvent('cash-telephone:server:CancelCall')
AddEventHandler('cash-telephone:server:CancelCall', function(ContactData)
    local Ply = CashoutCore.Functions.GetPlayerByPhone(ContactData.TargetData.number)

    if Ply ~= nil then
        TriggerClientEvent('cash-telephone:client:CancelCall', Ply.PlayerData.source)
    end
end)

RegisterServerEvent('cash-telephone:server:AnswerCall')
AddEventHandler('cash-telephone:server:AnswerCall', function(CallData)
    local Ply = CashoutCore.Functions.GetPlayerByPhone(CallData.TargetData.number)

    if Ply ~= nil then
        TriggerClientEvent('cash-telephone:client:AnswerCall', Ply.PlayerData.source)
    end
end)

RegisterServerEvent('cash-telephone:server:SaveMetaData')
AddEventHandler('cash-telephone:server:SaveMetaData', function(MData)
    local src = source
    local Player = CashoutCore.Functions.GetPlayer(src)

    CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(result)
        local MetaData = json.decode(result[1].metadata)
        MetaData.phone = MData
        CashoutCore.Functions.ExecuteSql(false, "UPDATE `players` SET `metadata` = '"..json.encode(MetaData).."' WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'")
    end)

    Player.Functions.SetMetaData("phone", MData)
end)

function escape_sqli(source)
    local replacements = { ['"'] = '\\"', ["'"] = "\\'" }
    return source:gsub( "['\"]", replacements ) -- or string.gsub( source, "['\"]", replacements )
end

CashoutCore.Functions.CreateCallback('cash-telephone:server:FetchResult', function(source, cb, search)
    local src = source
    local search = escape_sqli(search)
    local searchData = {}
    local ApaData = {}
    CashoutCore.Functions.ExecuteSql(false, 'SELECT * FROM `players` WHERE `citizenid` = "'..search..'" OR `charinfo` LIKE "%'..search..'%"', function(result)
        CashoutCore.Functions.ExecuteSql(false, 'SELECT * FROM `apartments`', function(ApartmentData)
            for k, v in pairs(ApartmentData) do
                ApaData[v.citizenid] = ApartmentData[k]
            end

            if result[1] ~= nil then
                for k, v in pairs(result) do
                    local charinfo = json.decode(v.charinfo)
                    local metadata = json.decode(v.metadata)
                    local appiepappie = {}
                    if ApaData[v.citizenid] ~= nil and next(ApaData[v.citizenid]) ~= nil then
                        appiepappie = ApaData[v.citizenid]
                    end
                    table.insert(searchData, {
                        citizenid = v.citizenid,
                        firstname = charinfo.firstname,
                        lastname = charinfo.lastname,
                        birthdate = charinfo.birthdate,
                        phone = charinfo.phone,
                        nationality = charinfo.nationality,
                        gender = charinfo.gender,
                        warrant = false,
                        driverlicense = metadata["licences"]["driver"],
                        appartmentdata = appiepappie,
                    })
                end
                cb(searchData)
            else
                cb(nil)
            end
        end)
    end)
end)

CashoutCore.Functions.CreateCallback('cash-telephone:server:GetVehicleSearchResults', function(source, cb, search)
    local src = source
    local search = escape_sqli(search)
    local searchData = {}
    CashoutCore.Functions.ExecuteSql(false, 'SELECT * FROM `player_vehicles` WHERE `plate` LIKE "%'..search..'%" OR `citizenid` = "'..search..'"', function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                CashoutCore.Functions.ExecuteSql(true, 'SELECT * FROM `players` WHERE `citizenid` = "'..result[k].citizenid..'"', function(player)
                    if player[1] ~= nil then 
                        local charinfo = json.decode(player[1].charinfo)
                        local vehicleInfo = CashoutCore.Shared.Vehicles[result[k].vehicle]
                        if vehicleInfo ~= nil then 
                            table.insert(searchData, {
                                plate = result[k].plate,
                                status = true,
                                owner = charinfo.firstname .. " " .. charinfo.lastname,
                                citizenid = result[k].citizenid,
                                label = vehicleInfo["name"]
                            })
                        else
                            table.insert(searchData, {
                                plate = result[k].plate,
                                status = true,
                                owner = charinfo.firstname .. " " .. charinfo.lastname,
                                citizenid = result[k].citizenid,
                                label = "Name not found.."
                            })
                        end
                    end
                end)
            end
        else
            if GeneratedPlates[search] ~= nil then
                table.insert(searchData, {
                    plate = GeneratedPlates[search].plate,
                    status = GeneratedPlates[search].status,
                    owner = GeneratedPlates[search].owner,
                    citizenid = GeneratedPlates[search].citizenid,
                    label = "Brand unknown.."
                })
            else
                local ownerInfo = GenerateOwnerName()
                GeneratedPlates[search] = {
                    plate = search,
                    status = true,
                    owner = ownerInfo.name,
                    citizenid = ownerInfo.citizenid,
                }
                table.insert(searchData, {
                    plate = search,
                    status = true,
                    owner = ownerInfo.name,
                    citizenid = ownerInfo.citizenid,
                    label = "Brand unknown.."
                })
            end
        end
        cb(searchData)
    end)
end)

CashoutCore.Functions.CreateCallback('cash-telephone:server:ScanPlate', function(source, cb, plate)
    local src = source
    local vehicleData = {}
    if plate ~= nil then 
        CashoutCore.Functions.ExecuteSql(false, 'SELECT * FROM `player_vehicles` WHERE `plate` = "'..plate..'"', function(result)
            if result[1] ~= nil then
                CashoutCore.Functions.ExecuteSql(true, 'SELECT * FROM `players` WHERE `citizenid` = "'..result[1].citizenid..'"', function(player)
                    local charinfo = json.decode(player[1].charinfo)
                    vehicleData = {
                        plate = plate,
                        status = true,
                        owner = charinfo.firstname .. " " .. charinfo.lastname,
                        citizenid = result[1].citizenid,
                    }
                end)
            elseif GeneratedPlates ~= nil and GeneratedPlates[plate] ~= nil then 
                vehicleData = GeneratedPlates[plate]
            else
                local ownerInfo = GenerateOwnerName()
                GeneratedPlates[plate] = {
                    plate = plate,
                    status = true,
                    owner = ownerInfo.name,
                    citizenid = ownerInfo.citizenid,
                }
                vehicleData = {
                    plate = plate,
                    status = true,
                    owner = ownerInfo.name,
                    citizenid = ownerInfo.citizenid,
                }
            end
            cb(vehicleData)
        end)
    else
        TriggerClientEvent('CashoutCore:Notify', src, "No vehicle around..", "error")
        cb(nil)
    end
end)

function GenerateOwnerName()
    local names = {
        [1] = { name = "Jan Bloksteen", citizenid = "DSH091G93" },
        [2] = { name = "Jay Dendam", citizenid = "AVH09M193" },
        [3] = { name = "Ben Klaariskees", citizenid = "DVH091T93" },
        [4] = { name = "Karel Bakker", citizenid = "GZP091G93" },
        [5] = { name = "Klaas Adriaan", citizenid = "DRH09Z193" },
        [6] = { name = "Nico Wolters", citizenid = "KGV091J93" },
        [7] = { name = "Mark Hendrickx", citizenid = "ODF09S193" },
        [8] = { name = "Bert Johannes", citizenid = "KSD0919H3" },
        [9] = { name = "Karel de Grote", citizenid = "NDX091D93" },
        [10] = { name = "Jan Pieter", citizenid = "ZAL0919X3" },
        [11] = { name = "Huig Roelink", citizenid = "ZAK09D193" },
        [12] = { name = "Corneel Boerselman", citizenid = "POL09F193" },
        [13] = { name = "Hermen Klein Overmeen", citizenid = "TEW0J9193" },
        [14] = { name = "Bart Rielink", citizenid = "YOO09H193" },
        [15] = { name = "Antoon Henselijn", citizenid = "QBC091H93" },
        [16] = { name = "Aad Keizer", citizenid = "YDN091H93" },
        [17] = { name = "Thijn Kiel", citizenid = "PJD09D193" },
        [18] = { name = "Henkie Krikhaar", citizenid = "RND091D93" },
        [19] = { name = "Teun Blaauwkamp", citizenid = "QWE091A93" },
        [20] = { name = "Dries Stielstra", citizenid = "KJH0919M3" },
        [21] = { name = "Karlijn Hensbergen", citizenid = "ZXC09D193" },
        [22] = { name = "Aafke van Daalen", citizenid = "XYZ0919C3" },
        [23] = { name = "Door Leeferds", citizenid = "ZYX0919F3" },
        [24] = { name = "Nelleke Broedersen", citizenid = "IOP091O93" },
        [25] = { name = "Renske de Raaf", citizenid = "PIO091R93" },
        [26] = { name = "Krisje Moltman", citizenid = "LEK091X93" },
        [27] = { name = "Mirre Steevens", citizenid = "ALG091Y93" },
        [28] = { name = "Joosje Kalvenhaar", citizenid = "YUR09E193" },
        [29] = { name = "Mirte Ellenbroek", citizenid = "SOM091W93" },
        [30] = { name = "Marlieke Meilink", citizenid = "KAS09193" },
    }
    return names[math.random(1, #names)]
end

CashoutCore.Functions.CreateCallback('cash-telephone:server:GetGarageVehicles', function(source, cb)
    local Player = CashoutCore.Functions.GetPlayer(source)
    local Vehicles = {}

    CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `player_vehicles` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                local VehicleData = CashoutCore.Shared.Vehicles[v.vehicle]

                local VehicleGarage = "Geen"
                if v.garage ~= nil then
                    if Garages[v.garage] ~= nil then
                        VehicleGarage = Garages[v.garage]["label"]
                    end
                end

                local VehicleState = "In"
                if v.state == 0 then
                    VehicleState = "Uit"
                elseif v.state == 2 then
                    VehicleState = "In Beslag"
                end

                local vehdata = {}

                if VehicleData["brand"] ~= nil then
                    vehdata = {
                        fullname = VehicleData["brand"] .. " " .. VehicleData["name"],
                        brand = VehicleData["brand"],
                        model = VehicleData["name"],
                        plate = v.plate,
                        garage = VehicleGarage,
                        state = VehicleState,
                        fuel = v.fuel,
                        engine = v.engine,
                        body = v.body,
                    }
                else
                    vehdata = {
                        fullname = VehicleData["name"],
                        brand = VehicleData["name"],
                        model = VehicleData["name"],
                        plate = v.plate,
                        garage = VehicleGarage,
                        state = VehicleState,
                        fuel = v.fuel,
                        engine = v.engine,
                        body = v.body,
                    }
                end

                table.insert(Vehicles, vehdata)
            end
            cb(Vehicles)
        else
            cb(nil)
        end
    end)
end)

CashoutCore.Functions.CreateCallback('cash-telephone:server:HasPhone', function(source, cb)
    local Player = CashoutCore.Functions.GetPlayer(source)
    
    if Player ~= nil then
        local HasPhone = Player.Functions.GetItemByName("phone")
        local retval = false

        if HasPhone ~= nil then
            cb(true)
        else
            cb(false)
        end
    end
end)

RegisterServerEvent('cash-telephone:server:GiveContactDetails')
AddEventHandler('cash-telephone:server:GiveContactDetails', function(PlayerId)
    local src = source
    local Player = CashoutCore.Functions.GetPlayer(src)

    local SuggestionData = {
        name = {
            [1] = Player.PlayerData.charinfo.firstname,
            [2] = Player.PlayerData.charinfo.lastname
        },
        number = Player.PlayerData.charinfo.phone,
        bank = Player.PlayerData.charinfo.account
    }

    TriggerClientEvent('cash-telephone:client:AddNewSuggestion', PlayerId, SuggestionData)
end)

RegisterServerEvent('cash-telephone:server:AddTransaction')
AddEventHandler('cash-telephone:server:AddTransaction', function(data)
    local src = source
    local Player = CashoutCore.Functions.GetPlayer(src)

    CashoutCore.Functions.ExecuteSql(false, "INSERT INTO `crypto_transactions` (`citizenid`, `title`, `message`) VALUES ('"..Player.PlayerData.citizenid.."', '"..escape_sqli(data.TransactionTitle).."', '"..escape_sqli(data.TransactionMessage).."')")
end)

CashoutCore.Functions.CreateCallback('cash-telephone:server:GetCurrentpolices', function(source, cb)
    local polices = {}
    for k, v in pairs(CashoutCore.Functions.GetPlayers()) do
        local Player = CashoutCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if Player.PlayerData.job.name == "police" then
                table.insert(polices, {
                    name = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
                    phone = Player.PlayerData.charinfo.phone,
                })
            end
        end
    end
    cb(polices)
end)

CashoutCore.Functions.CreateCallback('cash-telephone:server:GetCurrentLawyers', function(source, cb)
    local Lawyers = {}
    for k, v in pairs(CashoutCore.Functions.GetPlayers()) do
        local Player = CashoutCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if Player.PlayerData.job.name == "lawyer" then
                table.insert(Lawyers, {
                    name = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
                    phone = Player.PlayerData.charinfo.phone,
                })
            end
        end
    end
    cb(Lawyers)
end)

RegisterServerEvent('cash-telephone:server:postTweet')
AddEventHandler('cash-telephone:server:postTweet', function(message)
    local src = source
    local Player = CashoutCore.Functions.GetPlayer(src)
    
    CashoutCore.Functions.ExecuteSql(false, "INSERT INTO `phone_tweets` (`citizenid`, `sender`, `message`) VALUES ('"..Player.PlayerData.citizenid.."', '"..Player.PlayerData.charinfo.firstname.." "..string.sub(Player.PlayerData.charinfo.lastname, 1, 1):upper()..".', '"..message.."')")
    TriggerClientEvent('cash-telephone:client:newTweet', -1, Player.PlayerData.charinfo.firstname.." "..string.sub(Player.PlayerData.charinfo.lastname, 1, 1):upper()..".", message)
end)


CashoutCore.Functions.CreateCallback("cash-telephone:server:getPhoneTweets", function(source, cb)
    local src = source
    local pData = CashoutCore.Functions.GetPlayer(src)

    CashoutCore.Functions.ExecuteSql(false, 'SELECT * FROM `phone_tweets` ORDER BY `date` DESC', function(result)
        if result[1] ~= nil then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

CashoutCore.Functions.CreateCallback('cash-telephone:server:GetCurrentDrivers', function(source, cb)
    local drivers = {}
    for k, v in pairs(CashoutCore.Functions.GetPlayers()) do
        local Player = CashoutCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if Player.PlayerData.job.name == "taxi" then
                table.insert(drivers, {
                    name = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
                    phone = Player.PlayerData.charinfo.phone,
                })
            end
        end
    end
    cb(drivers)
end)

CashoutCore.Functions.CreateCallback('cash-telephone:server:GetCurrentMecano', function(source, cb)
    local drivers = {}
    for k, v in pairs(CashoutCore.Functions.GetPlayers()) do
        local Player = CashoutCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if Player.PlayerData.job.name == "mechanic" then
                table.insert(drivers, {
                    name = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
                    phone = Player.PlayerData.charinfo.phone,
                })
            end
        end
    end
    cb(drivers)
end)

CashoutCore.Functions.CreateCallback('cash-telephone:server:GetCurrentDoctor', function(source, cb)
    local drivers = {}
    for k, v in pairs(CashoutCore.Functions.GetPlayers()) do
        local Player = CashoutCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if Player.PlayerData.job.name == "doctor" then
                table.insert(drivers, {
                    name = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
                    phone = Player.PlayerData.charinfo.phone,
                })
            end
        end
    end
    cb(drivers)
end)


RegisterServerEvent('cash-telephone:server:restoreRented')
AddEventHandler('cash-telephone:server:restoreRented', function(money)
    local src = source
    local Player = CashoutCore.Functions.GetPlayer(src)

    Player.Functions.AddMoney("bank", money)
end)

RegisterServerEvent('cash-telephone:server:removeMoney')
AddEventHandler('cash-telephone:server:removeMoney', function(type, money)
    local src = source
    local Player = CashoutCore.Functions.GetPlayer(src)

    Player.Functions.RemoveMoney(type, money)
end)

local VehiclePlate = 0
RegisterServerEvent('cash-telephone:server:spawnVehicle')
AddEventHandler('cash-telephone:server:spawnVehicle', function(data)
    local src = source
    local Player = CashoutCore.Functions.GetPlayer(src)
    VehiclePlate = VehiclePlate + 1

    if Config.RentelVehicles[data.model] and data.price <= Player['PlayerData']['money']['cash'] then
        data['plate'] = 'RENT-' .. VehiclePlate
        TriggerClientEvent('cash-telephone:client:spawnVehicle', src, data)
        TriggerEvent('cash-telephone:server:clearVehicleTrunk', data['plate'])
    else
        TriggerClientEvent('CashoutCore:Notify', src, "You don't have enough money.", 'error')
    end
end)