#!/bin/bash
#Lab 1 - Step 4
#"makes a copy of your bin directory in a directory named backups using the rsync command"
#-a: archive mode - preserves file permissions

rsync -arv ~/bin ~/backups
