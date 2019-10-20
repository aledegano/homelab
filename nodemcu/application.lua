broker_addr = "192.168.1.116"
broker_port = 31883
-- init mqtt client with keepalive timer 120sec
clientId=node.chipid()
m = mqtt.Client(clientId, 120, "user", "password")
-- setup Last Will and Testament (optional)
-- Broker will publish a message with qos = 0, retain = 0, data = "offline" 
-- to topic "/lwt" if client don't send keepalive packet
m:lwt("/lwt", "offline", 0, 0)
m:on("connect", function(con) print ("connected") end)
m:on("offline", 
     function(con) 
          print ("offline") 
          node.restart()
     end
)
-- on publish message receive event
m:on("message", function(conn, topic, data) 
  print(topic .. ":" ) 
  if data ~= nil then
    print(data)
  end
end)
function connect()
     -- subscribe topic with qos = 0
     m:connect(broker_addr, broker_port, 0, 
          function(conn) 
               print("connected") 
               publish()
               start()
          end
     )
end

function publish()
    local rand = math.random(100)
    msg = '{ "Id": '..clientId..', "fix": "42", "rand": "'..rand..'" }'
    m:publish("/home/sensor/random",msg,0,0, function(conn) print("sent") end)
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
