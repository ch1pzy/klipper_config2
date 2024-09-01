#!/bin/bash

sudo service klipper stop
cd ~/klipper

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


sudo service klipper start
