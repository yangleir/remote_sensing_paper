#!/usr/bin/env bash
#
gmt gmtset FONT_LABEL = 10p,1,black
gmt gmtset MAP_FRAME_WIDTH	= 0.3c 
gmt gmtset MAP_LABEL_OFFSET 2p
gmt gmtset MAP_GRID_PEN_PRIMARY	= 0.1p,0/0/0,2_1_0.25_1:0
gmt gmtset MAP_FRAME_TYPE plain MAP_TICK_LENGTH_PRIMARY -5p 
gmt set FORMAT_DATE_MAP "o dd" FORMAT_CLOCK_MAP hh:mm FONT_ANNOT_PRIMARY 10p FONT_ANNOT_SECONDARY 12p

gmt psbasemap -R2019-03-31T09:00:00/2019-04-01T09:15:00/3/9  -BnSeW -Bpxa4Hf1h -Bsxa1Df1D -Bpya1g1f0.5+l"1 Hz SSH/m" -JX5i/3i -K >swh.ps
# "Time(2019/03/31 09:00:00-2019/04/01 09:00:00)"
awk '{print $1,$2}' ../data/gfb1.txt | gmt psxy -R32400/119700/3/9 -JX -Ss0.05c -Gyellow -K -P -O >> swh.ps
awk '{print $1,$2}' ../data/gfb2.txt | gmt psxy -R32400/119700/3/9 -JX -Ss0.05c -Gblue -K -P -O -t90 >> swh.ps
awk '{print $1,$3}' ../data/gfb2.txt | gmt psxy -R32400/119700/3/9 -JX  -W0.5p,white, -O -K >> swh.ps
awk '{print $1,$3}' ../data/gfb1.txt | gmt psxy -R32400/119700/3/9 -JX  -W0.5p,red, -O -K >> swh.ps

awk '{print $1,$2}' ../data/out.txt | gmt psxy -R32400/119700/3/9 -JX  -W0.5p,green, -O -K >> swh.ps

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

echo 2019-03-31T11:08:27 8.5 | gmt pstext -R -J -O -K -F+f10p,5+jBR+t"AIRAS"  >> swh.ps
echo 2019-03-31T16:00:00 8.5 | gmt pstext -R -J -O -K -F+f10p,5+jBL+t"BUOY@-1@-@ MOVING"  >> swh.ps

gmt pslegend -D+w1.5i+jBL+o3.5i/2.2i -R -J -O -F+p1p+glightgray --FONT_ANNOT_PRIMARY=7p << EOF >> swh.ps
S 0.2i s 0.15c yellow 1p,yellow 0.5i GNSS buoy 1 
S 0.2i s 0.15c blue 1p,blue 0.5i GNSS buoy 2
S 0.2i - 0.5i - 1p,red 0.5i GNSS buoy 1 Filterd
S 0.2i - 0.5i - 1p,white 0.5i GNSS buoy 2 Filterd
S 0.2i - 0.5i - 1p,green 0.5i in-situ
EOF

gmt psconvert  swh.ps -P -Tf -A
rm gmt.* 
