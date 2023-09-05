#!/bin/bash

charge_status=$(cat /sys/class/power_supply/BAT0/uevent | grep POWER_SUPPLY_CAPACITY_LEVEL | awk -F '=' '{print($2)}')

charge_value=$(cat /sys/class/power_supply/BAT0/uevent | grep POWER_SUPPLY_CHARGE_NOW | awk -F '=' '{print($2)}')

charge_full=$(cat /sys/class/power_supply/BAT0/uevent | grep POWER_SUPPLY_CHARGE_FULL | awk -F '=' '{print($2)}')

#calculation=$((charge_value * 100 / charge_full))
calculation=0

echo "BAT: $charge_full VAL: $calculation"
