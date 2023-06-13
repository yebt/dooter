#!/bin/bash

# VARS
SLEEP_TIME=10s
FULL=98
LOW=15
CRITICAL=10
BAT="BAT0"
NOTIFY=dunstify

# SOUND_DISCHARGE='~/.config/i3/scripts/sounds/mixkit-wrong-answer-fail-notification-946.wav'
# SOUND_DISCHARGE='./sounds/mixkit-wrong-answer-fail-notification-946.wav'
SOUND_DISCHARGE='/usr/share/sounds/speech-dispatcher/cembalo-6.wav'
# SOUND_FULL='~/.config/i3/scripts/sounds/mixkit-positive-notification-951.wav'
SOUND_FULL='/usr/share/sounds/speech-dispatcher/electric-piano-3.wav'
# PROCCESS

## Kill other isntances

script_name=${BASH_SOURCE[0]}
for pid in $(pidof -x $script_name); do
    if [ $pid != $$ ]; then
        kill -9 $pid
    fi 
done

## LOOP
while true;
do
	BAT_NOW=$(cat /sys/class/power_supply/$BAT/capacity)
	BAT_STATUS=$(cat /sys/class/power_supply/$BAT/status)
	if [[ $BAT_STATUS == 'Charging' ]];
	then
		# charging status
		if [ $BAT_NOW -ge $FULL ];
		then
			$NOTIFY -u normal -t 10000 "BATTERYSTATUS" "Battery FUll"
			aplay $SOUND_FULL
		fi
	else
		# charging status
		if [ $BAT_NOW -le $CRITICAL ];then
			$NOTIFY -u critical -t 10000 "BATTERYSTATUS" "Critical Low battery $BAT_NOW"
			aplay $SOUND_DISCHARGE
		elif [ $BAT_NOW -le $LOW ];then
			$NOTIFY -u critical -t 10000 "BATTERYSTATUS" "Low battery $BAT_NOW"
			aplay $SOUND_DISCHARGE
		fi

	fi
	sleep $SLEEP_TIME
done

unset SLEEP_TIME
