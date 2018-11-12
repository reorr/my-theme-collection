#!/bin/bash
ARGS=$(getopt -o "1:2:3" -l "one:two:three" -n $0 -- "$@")
[[ $? -eq 0 ]] || exit 1
eval set -- "$ARGS"
while true
do
  case "$1" in
    -1|--one)
      echo "one: " $2
      shift 2;;
    -2|--two)
      echo "Two: " $2
      shift 2;;
    -3|--three)
      echo "Three: " $2
      shift;;
    --)
      shift
      break;;
esac
done