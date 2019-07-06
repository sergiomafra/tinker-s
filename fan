#!/usr/bin/env python3

from time import sleep

import ASUS.GPIO as GPIO
import os
import signal
import sys


pin = 184
max_temp = 60

def setup():

    GPIO.setwarnings(False)
    GPIO.setmode(GPIO.ASUS)
    GPIO.setup(pin, GPIO.OUT)

    return

def get_cpu_temp():

    res = os.popen('cat /sys/class/thermal/thermal_zone0/temp').readline().rstrip('\n')
    temp = float(res)/1000
    print("temp is {0}".format(temp))

    return temp

def fan_on():

    set_pin(GPIO.HIGH)

    return

def fan_off():

    set_pin(GPIO.LOW)

    return

def get_temp():

    cpu_temp = get_cpu_temp()
    if cpu_temp > max_temp:
        fan_on()
    else:
        fan_off()

    return

def set_pin(mode):

    GPIO.output(pin, mode)

    return

try:
    setup()
    while True:
        get_temp()
        sleep(2)

except KeyboardInterrupt:
    GPIO.cleanup()

