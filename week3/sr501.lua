local ledPin = 1
gpio.mode(ledPin, gpio.OUTPUT)

local sensorPin = 7
gpio.mode(sensorPin, gpio.INPUT)

local sensorTimer = tmr.create()
sensorTimer:alarm(300, tmr.ALARM_AUTO, function()
    if gpio.read(sensorPin) == gpio.HIGH then
        print("Motion detected")
        gpio.write(ledPin, gpio.HIGH)
    else
        print("Motion not detected")
        gpio.write(ledPin, gpio.LOW)
    end
end)
