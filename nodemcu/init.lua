-- load location specific data 'altitude', 'ssid' and 'wifipassword'
dofile("location.lua")

function startup()
    if file.open("init.lua") == nil then
        print("init.lua deleted or renamed")
    else
        print("Running")
        file.close("init.lua")
        -- the actual application is stored in 'application.lua'
        dofile("application.lua")
    end
end

print("Connecting to WiFi access point...")
wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid=ssid
station_cfg.pwd=wifipassword
wifi.sta.config(station_cfg)
    print("Connected to wifi:" .. ssid)
-- wifi.sta.connect() not necessary because config() uses auto-connect=true by default
tmr.create():alarm(1000, tmr.ALARM_AUTO, function(cb_timer)
    if wifi.sta.getip() == nil then
        print("Waiting for IP address...")
    else
        cb_timer:unregister()
        print("WiFi connection established, IP address: " .. wifi.sta.getip())
        print("You have 3 seconds to abort")
        print("Waiting...")
        tmr.create():alarm(3000, tmr.ALARM_SINGLE, startup)
    end
end)
