#!/bin/bash

sudo service klipper stop
cd ~/klipper
git pull


make clean KCONFIG_CONFIG=~/klipper_config/config.robinE3
make KCONFIG_CONFIG=~/klipper_config/config.robinE3
./scripts/flash-sdcard.sh /dev/serial/by-id/usb-1a86_USB_Serial-if00-port0 mks-robin-e3

make clean KCONFIG_CONFIG=~/klipper_config/config.rpi
make KCONFIG_CONFIG=~/klipper_config/config.rpi
make flash KCONFIG_CONFIG=~/klipper_config/config.rpi

make clean KCONFIG_CONFIG=~/klipper_config/config.GT2560
make KCONFIG_CONFIG=~/klipper_config/config.GT2560
avrdude -carduino -patmega1280 -P/dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A904Y7PU-if00-port0  -b57600 -D -Uflash:w:out/klipper.elf.hex:i

make clean KCONFIG_CONFIG=~/klipper_config//config.EBBcan
make KCONFIG_CONFIG=~/klipper_config//config.EBBcan
python3 ~/CanBoot/scripts/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u 60b51521b7ac

#make clean KCONFIG_CONFIG=~/klipper_config/config.arduinonano
##make menuconfig KCONFIG_CONFIG=~/klipper_config/config.arduinonano
#make KCONFIG_CONFIG=~/klipper_config/config.arduinonano
#make flash KCONFIG_CONFIG=~/klipper_config/config.arduinonano FLASH_DEVICE=/dev/serial/by-id/usb-1a86_USB2.0-Serial-if00-port0


sudo service klipper start
