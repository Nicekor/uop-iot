local dhtPin = 4

local myTimer = tmr.create()
myTimer:alarm(1200, tmr.ALARM_AUTO, function()
    status, temp, humi = dht.read11(dhtPin)
    if (status == dht.OK) then
        print("DHT Temperature: " .. temp .. "; " .. "Humidity: " .. humi)
    elseif (status == dht.ERROR_CHECKSUM) then
        print("DHT Checksum error.")
    elseif (status == dht.ERROR_TIMEOUT) then
        print("DHT timed out")
    end
end)
