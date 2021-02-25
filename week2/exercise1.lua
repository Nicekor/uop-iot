local pinLED1 = 1
local pinLED2 = 2
gpio.mode(pinLED1, gpio.OUTPUT)
gpio.mode(pinLED2, gpio.OUTPUT)

local myTimer = tmr.create()
myTimer:register(1000, tmr.ALARM_AUTO, function()
    local pinLED1Level = gpio.read(pinLED1)
    local pinLED2Level = gpio.read(pinLED2)

    if (pinLED1Level == gpio.LOW) then
        gpio.write(pinLED1, gpio.HIGH)
        gpio.write(pinLED2, gpio.LOW)
    end

    if (pinLED2Level == gpio.LOW) then
        gpio.write(pinLED1, gpio.LOW)
        gpio.write(pinLED2, gpio.HIGH)
    end
end)
myTimer:start()
