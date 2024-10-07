#!/bin/bash

awk -F: '$3 >= 1000 && $3 <= 60000 {print $1, $3} ' /etc/passwd
