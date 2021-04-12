local env = require("env")

-- STATION
wifi.sta.autoconnect(1)
wifi.setmode(wifi.STATION)
wifi.sta.config({ssid = env.ssid, pwd = env.pwd, save = true})

-- manual connect and disconnect:
-- wifi.sta.connect()
-- wifi.sta.disconnect()

-- ACCESS POINT
wifi.setmode(wifi.SOFTAP)
wifi.ap.config({ssid = "MY-AP", pwd = "my-ap-pwd"})
