#!/bin/bash

sudo service klipper stop
cd ~/klipper
git pull

make clean KCONFIG_CONFIG=config.robinE3
make menuconfig KCONFIG_CONFIG=config.robinE3
make KCONFIG_CONFIG=config.robinE3
./scripts/flash-sdcard.sh /dev/serial/by-path/platform-fd500000.pcie-pci-0000:01:00.0-usb-0:1.4:1.0-port0 mks-robin-e3

make clean KCONFIG_CONFIG=config.rpi
make menuconfig KCONFIG_CONFIG=config.rpi
make KCONFIG_CONFIG=config.rpi
make flash KCONFIG_CONFIG=config.rpi

make clean KCONFIG_CONFIG=config.GT2560
make menuconfig KCONFIG_CONFIG=config.GT2560
make KCONFIG_CONFIG=config.GT2560
avrdude -carduino -patmega1280 -P/dev/serial/by-path/platform-fd500000.pcie-pci-0000:01:00.0-usb-0:1.3:1.0-port0 -b57600 -D -Uflash:w:out/klipper.elf.hex:i

make clean KCONFIG_CONFIG=config.EBBcan
make menuconfig KCONFIG_CONFIG=config.EBBcan
make KCONFIG_CONFIG=config.EBBcan
python3 ~/CanBoot/scripts/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u 60b51521b7ac

sudo service klipper start
