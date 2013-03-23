#!/bin/bash

# Cleans up backup files. "*~"
find ./ -name '*~' -exec rm '{}' \; -print -or -name ".*~" -exec rm {} \; -print