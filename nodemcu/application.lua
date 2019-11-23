mqtt = mqtt.Client("NodeMCU", 120)

mqtt:on("connect", function(con) print ("connected") end)
mqtt:on("offline",
     function(con)
          print ("offline")
          node.restart()
     end
)

function connect()
  mqtt:connect("192.168.1.116", 31883, 0, function(conn)
    publish()
    start()
  end)
end

function publish()
  mqtt:publish("/sensor/nodemcu/random",math.random(100),0,0, function(conn)
  end)
end

function start()
  tmr.alarm(1, 20000, 1, function()
       if pcall(publish) then
            print("Send OK")
       else
            print("Send err" )
       end
  end)
end

connect()