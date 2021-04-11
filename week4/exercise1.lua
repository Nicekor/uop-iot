local adcPin = 0

local myTimer = tmr.create()
myTimer:alarm(500, tmr.ALARM_AUTO, function()
    local digitV = adc.read(adcPin)
    -- the maximum for NodeMCU ADC is 1.1v
    -- it is a 10-bit ADC, can represent 0-1023 (2^10)
    -- 1023 represent 1.1v or larger
    print(digitV)
end)
