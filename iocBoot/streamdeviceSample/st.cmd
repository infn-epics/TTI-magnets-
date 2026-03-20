#!../../bin/linux-x86_64/streamdeviceSample

< envPaths


epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/db")

dbLoadDatabase "$(TOP)/dbd/streamdeviceSample.dbd"
streamdeviceSample_registerRecordDeviceDriver pdbbase

drvAsynIPPortConfigure("TTI1","192.168.197.49:4001", 0, 0, 0)
asynSetOption("TTI1", 0, "disconnectOnReadTimeout", "Y")

dbLoadRecords("$(TOP)/db/TTI.template", "P=SPARC:,R=TTI:,PORT=TTI1")

iocInit
epicsThreadSleep 1
dbl 
