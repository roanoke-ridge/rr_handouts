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

  local character = user.getUsedCharacter
  character.addCurrency(0, Config.PaymentAmount)

  Core.NotifyRightTip(player, locale("received_payment", Config.PaymentAmount), 4000)
  local fullName = string.format("%s %s", character.firstname, character.lastname)
  Config.Log(locale("log_payment", fullName, Config.PaymentAmount))

  timers[tostring(player)]:restart()
end

function StopPayTimer(player)
  if timers[tostring(player)] then
    timers[tostring(player)]:forceEnd(false)
  end
end

function PlayerJoiningHandler()
  local src = source
  repeat Wait(1000) until Player(src).state.IsInSession
  StartPayTimer(src)
end

function PlayerDroppedHandler()
  local src = source
  StopPayTimer(src)
end

function ResourceStartHandler(resourceName)
  if resourceName == GetCurrentResourceName() then
    for _, player in pairs(GetPlayers()) do
      -- Create thread here in case someone's still on character select when restarting the resource live
      CreateThread(function()
        while not Player(player).stateIsInSession do Wait(1000) end
        StartPayTimer(player)
      end)
    end
  end
end
