#!/usr/bin/env iocsh
##############################################################################
# EPICS IOC Startup Script for TSX Power Supply
# Single unit: SBNQUA01
##############################################################################

#!../../bin/linux-x86_64/streamdeviceSample

< envPaths

cd "${TOP}"

## Load database definition
dbLoadDatabase "dbd/streamdeviceSample.dbd"
streamdeviceSample_registerRecordDeviceDriver pdbbase

epicsEnvSet("STREAM_PROTOCOL_PATH", "${TOP}/db:${TOP}/protocol")
epicsEnvSet("BOOT", "${TOP}/iocBoot/${IOC}")

epicsEnvSet("DEVICE", "SBNQUA01")
epicsEnvSet("PORT", "SBNQUA01_PORT")
epicsEnvSet("MOXA_IP", "192.168.197.125")
epicsEnvSet("MOXA_TCP_PORT", "4001")

drvAsynIPPortConfigure("$(PORT)", "$(MOXA_IP):$(MOXA_TCP_PORT)", 0, 0, 0)

asynSetOption("$(PORT)", 0, "disconnectOnReadTimeout", "Y")

asynOctetSetOutputEos("$(PORT)", 0, "\n")

asynOctetSetInputEos("$(PORT)", 0, "\r\n")
dbLoadRecords("db/TSX.db", "P=MAGNETS:, R=SBNQUA01:, PORT=$(PORT)")

# IOC INITIALIZATION

cd "${TOP}/iocBoot/${IOC}"
iocInit
dbl