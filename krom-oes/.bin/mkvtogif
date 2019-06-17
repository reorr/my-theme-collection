#!/bin/env bash
#requirements ffmpeg

ffmpeg -i $1 \
-vf scale=600:-1 -r 10 \
-f image2pipe -vcodec ppm \
- | convert -delay 5 \
-loop 0 - gif:- \
| convert -layers Optimize - $2
