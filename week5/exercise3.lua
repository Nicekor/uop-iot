wifi.setmode(wifi.STATION)
local function listap(t) -- (SSID : Authmode, RSSI, BSSID, Channel)
    print("\n" .. string.format("%32s", "SSID") ..
              "\tBSSID\t\t\t\t  RSSI\t\tAUTHMODE\tCHANNEL")
    for ssid, v in pairs(t) do
        local authmode, rssi, bssid, channel =
            string.match(v, "([^,]+),([^,]+),([^,]+),([^,]+)")
        print(string.format("%32s", ssid) .. "\t" .. bssid .. "\t  " .. rssi ..
                  "\t\t" .. authmode .. "\t\t\t" .. channel)
    end
end
wifi.sta.getap(listap)

