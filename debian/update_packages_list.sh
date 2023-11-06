#!/bin/bash

# This is a script to update the Packages list with the following command
dpkg-scanpackages -m . /dev/null > Packages
