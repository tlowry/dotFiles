#!/usr/bin/env python
import subprocess, re , signal, os, sys

def add_dirs(dir_name):
  pos = 0

  while pos != -1:
    pos = dir_name.find('/',pos+1)
    if pos != -1:
        sub_dir = dir_name[0:pos]
        ps = subprocess.Popen(['cvs', 'add', sub_dir], stdout=subprocess.PIPE)
        out, err = ps.communicate()

if len(sys.argv) > 1 :
  add_dirs(sys.argv[1])
else:
  print("Please supply a path to add recursively")
