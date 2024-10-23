Config = {
  PaymentInterval = 1, -- in minutes
  PaymentAmount = 100,

  -- Set this to true if you want to pay only unemployed players instead of everyone
  OnlyUnemployed = false,
  
  Log = function(message)
    print(message)
  end
}