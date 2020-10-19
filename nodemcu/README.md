# Developing for the ESP8266

## Interfacing

Use the Python tool: [Esptool](https://github.com/espressif/esptool)
 * install with Pip: `pip3 install esptool`
 * grant the unprivilege user access to tty: `sudo usermod -a -G dialout <USERNAME>`

## Firmware

### Cloud-builder

A cloud builder is available to build firmwares for the ESP8266: https://nodemcu-build.com.
For this project the following modules are mandatory: `dht`, `wifi`, `gpio`, `net`.

### Flashing the firmware

Use [esptool.py](https://github.com/espressif/esptool), install it through `pip`.
Flash the firmware created with the above Cloud-builder:
`esptool.py write_flash -fm qio 0x00000 ~/Downloads/<downloaded_firmare>.bin`

## Application

The application reads a DHT11 sensor data and uploads it to the MQTT server over WIFI.
The credentials for the WIFI connections must be created in a lua file, in this folder, to be named
"location.lua", with the following content:
```
ssid = "<the wifi ssid>"
wifipassword = "<the wifi password>"
```
`location.lua` is in the .gitignore so it won't be included in git.

### Upload the application

Use [NodeMCU-Tool](https://github.com/andidittrich/NodeMCU-Tool), install it through `npm` *not*
globally: `npm install nodemcu-tool`.
Upload the application lua files:
```
nodemcu-tool upload --port /dev/ttyUSB0 nodemcu/application.lua
nodemcu-tool upload --port /dev/ttyUSB0 nodemcu/location.lua
nodemcu-tool upload --port /dev/ttyUSB0 nodemcu/init.lua
```
And reset the NodeMCU with the hardware reset button.

### Debug the application

Open a terminal using nodemcu-tool:
```
nodemcu-tool terminal
```
reset the NodeMCU, if the lua application runs correctly this output should appear:
```
NodeMCU 3.0.0.0 built on nodemcu-build.com provided by frightanic.com
	branch: release
	commit: 64bbf006898109b936fcc09478cbae9d099885a8
	release: 3.0-master_20200910
	release DTS: 202009090323
	SSL: false
	build type: float
	LFS: 0x0 bytes total capacity
	modules: dht,file,gpio,mqtt,net,node,tmr,uart,wifi
 build 2020-10-19 15:55 powered by Lua 5.1.4 on SDK 3.0.1-dev(fce080e)
Connecting to WiFi access point...
Connected to wifi:<redacted>
> Waiting for IP address...
Waiting for IP address...
Waiting for IP address...
WiFi connection established, IP address:<redacted>
```
