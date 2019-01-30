#!/bin/bash

open=true
prv_num_monitors=0
while :
do
    sleep 0.5

    ### Wallpaper change for single/dual monitor. ###
    # If there are two active monitors, change the wallpaper directory so that
    # each display gets the same image.
    num_monitors="$(xrandr --listactivemonitors | head -n1 |grep -o '[0-9]')"
    bg_dir="/home/nathan/Pictures/backgrounds/compiz/in_use"
    single_dir="/home/nathan/Pictures/backgrounds/compiz/single/"
    dual_dir="/home/nathan/Pictures/backgrounds/compiz/dual/"
    temp_file="/home/nathan/Documents/testt.txt"
    # Only change if state has changed.
    if [ "$num_monitors" -ne "$prv_num_monitors" ]
    then
        rm $bg_dir
        if [ "$num_monitors" -eq "2" ]
        then
            prv_num_monitors=2
            ln -s $dual_dir $bg_dir
        else
            prv_num_monitors=1
            ln -s $single_dir $bg_dir
        fi
        compiz --replace &
    fi

    ### Turn off laptop display when lid closes. ###
    xrandr --listmonitors | grep -q HDMI
    if [ $? = 0 ]
    then
        if [ "$open" = "true" ]
        then
            grep -q closed /proc/acpi/button/lid/*/state
            if [ $? = 0 ]
            then
                xrandr --output eDP1 --off
                open=false
            fi
        else
            grep -q open /proc/acpi/button/lid/*/state
            if [ $? = 0 -a $open ]
            then
                xrandr --output eDP1 --auto
                xrandr --output eDP1 --right-of HDMI1
                open=true
            fi
        fi
    fi
done
