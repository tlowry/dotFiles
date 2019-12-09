#!/usr/bin/env python
import subprocess

confKeys = "localectl set-x11-keymap us"
setKeys = "setxkbmap us"
subprocess.run(["setxkbmap","us"])
