local buttonPin = 1
gpio.mode(buttonPin, gpio.INPUT)
gpio.write(buttonPin, gpio.LOW)

local ledPin = 4
gpio.mode(ledPin, gpio.OUTPUT)
gpio.write(ledPin, gpio.HIGH)

local pushed = false

local myTimerPush = tmr.create()
local myTimerRelease = tmr.create()

myTimerPush:alarm(100, tmr.ALARM_AUTO, function()
    if (gpio.read(buttonPin) == gpio.HIGH and pushed == false) then
        pushed = true
    end
end)

myTimerRelease:alarm(100, tmr.ALARM_AUTO, function()
    if (gpio.read(buttonPin) == gpio.LOW and pushed == true) then
        pushed = false
        print("Button Push detected")
        if (gpio.read(ledPin) == gpio.LOW) then
            gpio.write(ledPin, gpio.HIGH)
        else
            gpio.write(ledPin, gpio.LOW)
        end
    end
end)
