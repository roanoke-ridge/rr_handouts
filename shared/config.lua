Config = {
  PaymentInterval = 10, -- in minutes
  PaymentCurrency = 0, -- 0 = money, 1 = gold, 2 = rol
  PaymentAmount = 100,

  -- Set this to true if you want to pay only unemployed players instead of everyone
  OnlyUnemployed = false,

  -- true = player receives notification and prints to server console 
  -- false = prints only to server console.
  NotifyPlayer = true, 

  -- Set this to true if you want to pay players only when they are alive
  PauseDuringDeath = false,
  
  Log = function(message)
    print(message)
  end
}
