local adcPin = 0
local ledPin = 4
pwm.setup(ledPin, 1000, 1023)
pwm.start(ledPin)

local myTimer = tmr.create()
myTimer:alarm(500, tmr.ALARM_AUTO, function()
    local digitV = adc.read(adcPin)
    print("digitV: " .. digitV)
    local dc = math.abs(digitV - 1)
    print("dc: " .. dc)
    pwm.setduty(ledPin, dc)
end)
