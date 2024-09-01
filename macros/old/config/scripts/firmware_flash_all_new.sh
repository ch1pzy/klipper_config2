#!/bin/bash

sudo service klipper stop
cd ~/klipper
git pull

cp -f /home/pi/klipper_config/config/config.robinE3 /home/pi/klipper/.config
make olddefconfig
make clean
make
./scripts/flash-sdcard.sh /dev/serial/by-id/usb-1a86_USB_Serial-if00-port0 mks-robin-e3

cp -f /home/pi/klipper_config/config/config.rpi /home/pi/klipper/.config
make olddefconfig
make clean
make
make flash

cp -f /home/pi/klipper_config/config/config.GT2560 /home/pi/klipper/.config
make olddefconfig
make clean
make
avrdude -carduino -patmega1280 -P/dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A904Y7PU-if00-port0  -b57600 -D -Uflash:w:out/klipper.elf.hex:i

cp -f /home/pi/klipper_config/config/config.EBBcan /home/pi/klipper/.config
make olddefconfig
make clean
make
python3 ~/CanBoot/scripts/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u 60b51521b7ac

#make clean KCONFIG_CONFIG=~/klipper_config/config.arduinonano
##make menuconfig KCONFIG_CONFIG=~/klipper_config/config.arduinonano
#make KCONFIG_CONFIG=~/klipper_config/config.arduinonano
#make flash KCONFIG_CONFIG=~/klipper_config/config.arduinonano FLASH_DEVICE=/dev/serial/by-id/usb-1a86_USB2.0-Serial-if00-port0


sudo service klipper start
