#!/bin/sh

CPT=0
while read HEXCODE; do
    printf '*color%d: %s\n' "$CPT" "$HEXCODE"
    CPT=$(expr $CPT + 1)
done | column -t
