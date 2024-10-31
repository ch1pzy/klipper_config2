#!/bin/bash

sudo service klipper stop
cd ~/klipper
git pull


#make clean KCONFIG_CONFIG=~/klipper_config/config.rpi
#make KCONFIG_CONFIG=~/klipper_config/config.rpi
#make flash KCONFIG_CONFIG=~/klipper_config/config.rpi

#make clean KCONFIG_CONFIG=~/klipper_config/config.GT2560
#make KCONFIG_CONFIG=~/klipper_config/config.GT2560
#avrdude -carduino -patmega1280 -P/dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A904Y7PU-if00-port0  -b57600 -D -Uflash:w:out/klipper.elf.hex:i

make clean KCONFIG_CONFIG=~/klipper_config//config.sb2040
make KCONFIG_CONFIG=~/klipper_config/config.sb2040 -j4
python3 ~/Katapult/scripts/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u 94ed859879a5

make clean KCONFIG_CONFIG=~/klipper_config/config.dp5.can
make KCONFIG_CONFIG=~/klipper_config/config.dp5.can -j4
# Need a pause here to notify that the board needs to be put into DFU Mode... just include the below into a bash script and give the user the instruction to run it after the're in DFU
make KCONFIG_CONFIG=config.dp5.can flash FLASH_DEVICE=0483:df11
#./scripts/flash-sdcard.sh /dev/serial/by-id/usb-1a86_USB_Serial-if00-port0 mks-robin-e3

#make clean KCONFIG_CONFIG=~/klipper_config/config.arduinonano
##make menuconfig KCONFIG_CONFIG=~/klipper_config/config.arduinonano
#make KCONFIG_CONFIG=~/klipper_config/config.arduinonano
#make flash KCONFIG_CONFIG=~/klipper_config/config.arduinonano FLASH_DEVICE=/dev/serial/by-id/usb-1a86_USB2.0-Serial-if00-port0


sudo service klipper start
