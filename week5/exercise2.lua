wifi.setmode(wifi.STATIONAP)
-- it can be done manually with
-- wifi.ap.config({ssid = "nameyournodeMCU", pwd = "yourpassword", auth = wifi.WPA2_PSK})
-- enduser_setup.manual(true)
enduser_setup.start()
print("AP IP: " .. wifi.ap.getip())
print("AP MAC: " .. wifi.ap.getmac())
print("STA MAC: " .. wifi.sta.getmac())
print("WIFI STATUS: " .. wifi.sta.status())