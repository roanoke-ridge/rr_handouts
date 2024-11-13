local Core = exports.vorp_core:GetCore()
lib.locale()

local timers = {}

function StartPayTimer(player)
  local payTimer = lib.timer(Config.PaymentInterval * 60 * 1000, function() Pay(player) end, true)
  timers[tostring(player)] = payTimer -- tostring(player) because player id 1 will make the lua interpreter think that it's an array index
end

function Pay(player)
  local user = Core.getUser(player)
  if not user then return false end

  local money = '';
  if Config.PaymentCurrency == 0 then
    money = string.format("$%.2f", Config.PaymentAmount)
  elseif Config.PaymentCurrency == 1 then
    money = string.format("%.2f gold", Config.PaymentAmount)
  elseif Config.PaymentCurrency == 2 then
    money = string.format("%.2f rol", Config.PaymentAmount)
  else
    -- Invalid currency
    return false
  end

  local character = user.getUsedCharacter
  character.addCurrency(Config.PaymentCurrency, Config.PaymentAmount)

  -- Core.NotifyRightTip(player, locale("received_payment", money), 4000) -- COYOTE NOTE: removes notification for player
  -- local fullName = string.format("%s %s", character.firstname, character.lastname) -- COYOTE NOTE: moved to below
  -- Config.Log(locale("log_payment", fullName, money))  -- COYOTE NOTE: removed to avoid double printing on server console

  local fullName = string.format("%s %s", character.firstname, character.lastname) -- COYOTE NOTE: this prints to server console
  print(fullName .. " has received " .. money) -- COYOTE NOTE: this prints to server console

  timers[tostring(player)]:restart()
end

function StopPayTimer(player)
  if timers[tostring(player)] then
    timers[tostring(player)]:forceEnd(false)
  end
end

function JobChangeHandler(source, newjob, oldjob)
  if not Config.OnlyUnemployed then return end

  if newjob == "unemployed" then
    StartPayTimer(source)
  elseif timers[tostring(source)] then
    StopPayTimer(source)
  end
end

function DeathHandler()
  local src = source
  if Config.PauseDuringDeath then
    timers[tostring(src)]:pause()
  end
end

function RespawnHandler(player)
  if Config.PauseDuringDeath then
    timers[tostring(player)]:play()
  end
end

function SelectedCharacterHandler(src, character)
  if Config.OnlyUnemployed and character.job ~= "unemployed" then return end
  StartPayTimer(src)
end

function PlayerDroppedHandler()
  local src = source
  StopPayTimer(src)
end

function ResourceStartHandler(resourceName)
  if resourceName == GetCurrentResourceName() then
    for _, player in pairs(GetPlayers()) do
      if Player(player).state.IsInSession then
        StartPayTimer(player)
        local user = Core.getUser(player)
        local character = user.getUsedCharacter
        if character.isdead then timers[tostring(player)]:pause() end
      end
    end
  end
end
