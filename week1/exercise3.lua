pinLED1 = 4
gpio.mode(pinLED1, gpio.OUTPUT)
gpio.write(pinLED1, gpio.LOW)

intervals = {5000, 500, 1000, 200}
index = 1

myTimer = tmr.create()
myTimer:register(intervals[1], tmr.ALARM_AUTO, function()
    -- same as ternary operator
    levelDesired = (index % 2 == 0) and gpio.LOW or gpio.HIGH
    gpio.write(pinLED1, levelDesired)

    index = (index >= #intervals) and 1 or (index + 1)

    myTimer:interval(intervals[index])
end)
myTimer:start()
