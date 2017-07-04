#!/usr/bin/python2
# -*- coding: utf-8 -*-
'''Program to toggle Touchpad Enable to Disable or vice-versa.'''

import commands
import re


def current_id():
    """ Search through the output of xinput and find the line that has the
    word TouchPad.  At that point, I believe we can find the ID of that device."""

    props = commands.getoutput("xinput").split("\n")
    match = [line for line in props if "TouchPad" in line]
    assert len(match) == 1, "Problem finding Touchpad string! %s" % match

    pat = re.match(r"(.*)id=(\d+)", match[0])
    assert pat, "No matching ID found!"

    return int(pat.group(2))


def current_status(tpad_id):
    """Find the current Device ID, it has to have the word TouchPad in the line."""

    props = commands.getoutput("""xinput list-props %d""" % tpad_id).split('\n')
    match = [line for line in props if "Device Enabled" in line]
    assert len(match) == 1, "Can't find the status of device #%d" % tpad_id

    pat = re.match(r"(.*):\s*(\d+)", match[0])
    assert pat, "No matching status found!"
    return int(pat.group(2))

def flop(tpad_id, status):
    """Change the value of status, and call xinput to reverse that status."""
    if status == 0:
        status = 1
    else:
        status = 0

    print "Changing Device #%d Device Enabled %d" % (tpad_id, status)
    commands.getoutput("""xinput set-prop %d "Device Enabled" %d""" % (tpad_id, status))

def main():
    """Get curent device id and status, and flop status value."""
    tpad = current_id()
    stat = current_status(tpad)
    flop(tpad, stat)

main()
