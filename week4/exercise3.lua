local adcPin = 0
local ledPin = 4
pwm.setup(ledPin, 1000, 1023)
pwm.start(ledPin)

local myTimer = tmr.create()
myTimer:alarm(300, tmr.ALARM_AUTO, function()
    local digitV = adc.read(adcPin)
    print("digitV: " .. digitV)
    local dc = math.floor(digitV ^ 2)
    print("dc: " .. dc)
    if (dc > 1023) then dc = 1023 end
    pwm.setduty(ledPin, dc)
end)
