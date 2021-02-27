local buttonPin = 7
gpio.mode(buttonPin, gpio.INPUT)
gpio.write(buttonPin, gpio.LOW)

local ledPin = 0
gpio.mode(ledPin, gpio.OUTPUT)
gpio.write(ledPin, gpio.HIGH)

local dhtPin = 4

local dhtTimer = tmr.create()
dhtTimer:register(1200, tmr.ALARM_AUTO, function()
    status, temp, humi = dht.read11(dhtPin)
    if (status == dht.OK) then
        print("DHT Temperature: " .. temp .. "; " .. "Humidity: " .. humi)
    elseif (status == dht.ERROR_CHECKSUM) then
        print("DHT Checksum error.")
    elseif (status == dht.ERROR_TIMEOUT) then
        print("DHT timed out")
    end
end)

local buttonTimer = tmr.create()
buttonTimer:alarm(100, tmr.ALARM_AUTO, function()
    local ledLevel = gpio.read(ledPin)

    if gpio.read(buttonPin) == gpio.HIGH and ledLevel == gpio.HIGH then
        gpio.write(ledPin, gpio.LOW)
        dhtTimer:start()
    end
    if (gpio.read(buttonPin) == gpio.HIGH and ledLevel == gpio.LOW) then
        gpio.write(ledPin, gpio.HIGH)
        dhtTimer:stop()
    end
end)

