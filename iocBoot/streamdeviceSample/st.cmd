#!../../bin/linux-x86_64/streamdeviceSample

#- You may have to change streamdeviceSample to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"
dbLoadDatabase "dbd/TTI.dbd"

# Evironment variables
epicsEnvSet("STREAM_PROTOCOL_PATH", "${TOP}/db")
epicsEnvSet("BOOT","${TOP}/iocBoot/${IOC}")

## Register all support components
dbLoadDatabase "dbd/streamdeviceSample.dbd"
streamdeviceSample_registerRecordDeviceDriver pdbbase

epicsEnvSet("DEVICE", "TTF001")
epicsEnvSet("PORT", "ttf001_port")
epicsEnvSet("ADDR", "192.168.1.100:5025")  # Il tuo indirizzo

drvAsynIPPortConfigure("$(PORT)", "$(ADDR)")

dbLoadRecords("db/TTI.db", "P=MAGNETS:, R=TTF001:, PORT=$(PORT)")

iocInit

### Create a IPCMini device instance
epicsEnvSet("DEVICE", "TEST:STREAMDEVICESAMPLE")
epicsEnvSet("IP", "192.168.197.105:4002")
## Create asyn IP port for communication over TCP/IP
drvAsynIPPortConfigure ("ASYNPORT", "$(IP)")
## Load record instances
dbLoadRecords("db/streamdevicesample.template","DEVICE=$(DEVICE),PORT=ASYNPORT,module=1,max=100")


cd "${TOP}/iocBoot/${IOC}"
iocInit
