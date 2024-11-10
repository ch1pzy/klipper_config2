#!/bin/bash

NEWY=$(ls -Art /tmp/calibration_data_y_*.csv | tail -n 1)
DATE=$(date +'%Y-%m-%d-%H%M%S')
if [ ! -d "/home/pi/klipper_config/input_shaper" ]
then
    mkdir /home/pi/klipper_config/input_shaper
    chown pi:pi /home/pi/klipper_config/input_shaper
fi

~/klipper/scripts/calibrate_shaper.py /tmp/calibration_data_y_*.csv -o /home/pi/klipper_config/input_shaper/resonances_y_$DATE.png
