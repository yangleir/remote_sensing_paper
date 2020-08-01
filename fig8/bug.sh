#!/usr/bin/env bash
#

gmt psbasemap -R2019-03-31T09:00:00/2019-04-01T09:15:00/3/9  -BnSeW -Bpxa4Hf1h -Bsxa1Df1D -Bpya1g1f0.5+l"1 Hz SSH/m" -JX5i/3i -K >swh.ps

echo 2019-03-31T14:20:00 3 >h5.d
echo 2019-03-31T14:20:00 9 >>h5.d
echo 2019-03-31T16:10:00 9 >>h5.d
echo 2019-03-31T16:10:00 3 >>h5.d
gmt psxy  h5.d -R2019-03-31T09:00:00/2019-04-01T09:00:00/3/9 -JX  -W1p,red, -Gred -t90 -O -K >> swh.ps

echo 2019-03-31T11:08:27 3 >h5.d
echo 2019-03-31T11:08:27 9 >>h5.d
echo 2019-03-31T11:12:36 9 >>h5.d
echo 2019-03-31T11:12:36 3 >>h5.d
gmt psxy  h5.d -R2019-03-31T09:00:00/2019-04-01T09:00:00/3/9 -JX  -W1p,green, -Ggreen -t90 -O -K >> swh.ps

echo 2019-03-31T11:08:27 8.5 | gmt pstext -R2019-03-31T09:00:00/2019-04-01T09:00:00/3/9 -J -O -K -F+f10p,5+jBR+t"AIRAS"  >> swh.ps
echo 2019-03-31T16:00:00 8.5 | gmt pstext -R2019-03-31T09:00:00/2019-04-01T09:00:00/3/9 -J -O  -F+f10p,5+jBL+t"BUOY@-1@-@ MOVING"  >> swh.ps

gmt psconvert  swh.ps -P -Tf -A
rm gmt.* *.d
