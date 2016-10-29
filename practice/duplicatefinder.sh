#!/bin/bash

#ask user for directory
#create a hash with file checksums as keys and filenames
#as values for regular files under that directory name
#if you find a file whose checksum is already in the hash,
#add thta file to a second hash which uses the filename as the key
#and the checksum as the value

#when you have checked all files found,
#display a list of files that have the same checksums, showing
#which have the same checksums

