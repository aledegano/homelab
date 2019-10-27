function makepromlines(prefix, name, source)
  local buffer = {"# TYPE ", prefix, name, " gauge\n", prefix, name, " ", source, "\n"}
  local lines = table.concat(buffer)
  return lines
end

function metrics()
    local rand = math.random(100)
    -- this table contains the metric names and sources.
    local metricspecs = {
      "random_number", rand,
      "fixed_number", 42,
      }
    local metrics = {}
    for i = 1, #metricspecs, 2 do
      table.insert(metrics, makepromlines("nodemcu_", metricspecs[i], metricspecs[i+1]))
    end
    local body = table.concat(metrics)
    return body
end

function response()
  local header = "HTTP/1.0 200 OK\r\nServer: NodeMCU on ESP8266\r\nContent-Type: text/plain; version=0.0.4\r\n\r\n"
  local response = header .. metrics()
  print("> " .. response)
  return response
end

-- Sensor setup here

srv = net.createServer(net.TCP, 20) -- 20s timeout

if srv then
  srv:listen(80, function(conn)
    conn:on("receive", function(conn, data)
      print("< "  .. data)
      conn:send(response())
      conn:close()
    end)
  end)
end