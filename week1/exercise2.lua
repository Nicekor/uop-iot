-- LOW => LED is lighted
-- HIGH => LED is not lighted
-- when setting mode to gpio.OUTPUT the LEDS are by default on LOW
pinLED1 = 4
gpio.mode(pinLED1, gpio.OUTPUT)
gpio.write(pinLED1, gpio.HIGH)

pinLED2 = 0
gpio.mode(pinLED2, gpio.OUTPUT)

myTimer = tmr.create()
myTimer:register(2000, tmr.ALARM_AUTO, function()
    pinLED1Level = gpio.read(pinLED1)
    pinLED2Level = gpio.read(pinLED2)

    if (pinLED1Level == gpio.HIGH) then
        gpio.write(pinLED1, gpio.LOW)
        gpio.write(pinLED2, gpio.HIGH)
    end

    if (pinLED2Level == gpio.HIGH) then
        gpio.write(pinLED1, gpio.HIGH)
        gpio.write(pinLED2, gpio.LOW)
    end
end)
myTimer:start()
