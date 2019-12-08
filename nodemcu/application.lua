dht11_pin = 4
mqtt = mqtt.Client("NodeMCU", 120)
mqtt_broker_addr = "192.168.1.116"
mqtt_broker_port = 31883
timer = tmr.create()

mqtt:on("connect", function(con) print ("connected") end)
mqtt:on("offline",
     function(con)
          print ("offline")
          node.restart()
     end
)

function connect()
  mqtt:connect(mqtt_broker_addr, mqtt_broker_port, 0, function(conn)
    publish()
    start()
  end)
end

function publish()
  status, temp, humi, temp_dec, humi_dec = dht.read11(dht11_pin)
  if status == dht.ERROR_CHECKSUM then
    print( "DHT Checksum error." )
  elseif status == dht.ERROR_TIMEOUT then
    print( "DHT timed out." )
  end
  mqtt:publish("/sensor/nodemcu/temperature",temp,0,0, function(conn)
  end)
  mqtt:publish("/sensor/nodemcu/humidity",humi,0,0, function(conn)
  end)
  mqtt:publish("/sensor/nodemcu/status",status,0,0, function(conn)
  end)
end

function start()
  timer:alarm(20000, tmr.ALARM_AUTO, function()
       if pcall(publish) then
            print("Send OK")
       else
            print("Send err" )
       end
  end)
end

connect()