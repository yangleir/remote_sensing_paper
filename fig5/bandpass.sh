#!/usr/bin/env bash
# This is not used in paper. But it is usefull to show the bandpass result.

gmt set FORMAT_DATE_MAP "o dd" FORMAT_CLOCK_MAP hh:mm 
gmt gmtset MAP_GRID_PEN_PRIMARY	= 0.1p,0/0/0,2_1_0.25_1:0
gmt gmtset FONT_LABEL = 10p,19, 
gmt gmtset FONT_TITLE = 14p
gmt gmtset MAP_TITLE_OFFSET = 3p


#==============
#==========================================================================================================================================================
# jizai (one line length 4800m,bin 3m)
data_jizai_large2=C:/Users/yangleir/Documents/jianguoyun/Documents/projects/guanlan/23_air_alti_sar/airborne_data/23suo/data1/test_files.nc
data_jizai_large1=C:/Users/yangleir/Documents/jianguoyun/Documents/projects/guanlan/23_air_alti_sar/airborne_data/23suo/data2/test_files.nc

# long wave
gmt grdfft  $data_jizai_large1 -Gjizai1.nc  -F-/150/2
gmt grdfft  $data_jizai_large2 -Gjizai2.nc  -F-/150/2

ps=bandpass.ps
J=JX3c/8c # J=JX3c/8c for large
gmt grd2cpt jizai1.nc >mss2.cpt
gmt psbasemap -Rjizai1.nc -$J  -BWNSE+t"Band Filted WSSE" -Bya100+l"AIRAS at buoy 1"+s" "  -Bxa100 -K -fc  -p90/90> $ps
gmt grdimage jizai1.nc -$J -Cmss2.cpt -K -O -fc -p >> $ps
gmt psscale -DjCB+w1.5i+o0c/-2c+h -Cmss2 -Bxaf -By+lm -R -J -O  -K -p>> $ps

gmt grd2cpt jizai2.nc >mss2.cpt
gmt psbasemap -Rjizai2.nc -$J  -BWNSE+t"Band Filted WSSE" -Bya100+l"AIRAS at buoy 2"+s" "  -Bxa100 -K -fc  -p90/90 -O -X12c>> $ps
gmt grdimage jizai2.nc -$J -Cmss2.cpt -K -O -fc -p >> $ps
gmt psscale -DjCB+w1.5i+o0c/-2c+h -Cmss2 -Bxaf -By+lm -R -J -O  -K -p>> $ps
# noise
gmt grdfft  $data_jizai_large1 -Gjizai1.nc  -F3/-/2
gmt grdfft  $data_jizai_large2 -Gjizai2.nc  -F3/-/2

gmt grd2cpt jizai1.nc >mss2.cpt
gmt psbasemap -Rjizai1.nc -$J  -BWNSE+t"Band Filted WSSE" -Bya100+l"AIRAS at buoy 1"+s" "  -Bxa100 -K -fc  -O -p -X-12c -Y8c>> $ps
gmt grdimage jizai1.nc -$J -Cmss2.cpt -K -O -fc -p >> $ps
gmt psscale -DjCB+w1.5i+o0c/-2c+h -Cmss2 -Bxaf -By+lm -R -J -O  -K -p>> $ps

gmt grd2cpt jizai2.nc >mss2.cpt
gmt psbasemap -Rjizai2.nc -$J  -BWNSE+t"Band Filted WSSE" -Bya100+l"AIRAS at buoy 2"+s" "  -Bxa100 -K -fc  -p90/90 -O -X12c>> $ps
gmt grdimage jizai2.nc -$J -Cmss2.cpt -K -O -fc -p >> $ps
gmt psscale -DjCB+w1.5i+o0c/-2c+h -Cmss2 -Bxaf -By+lm -R -J -O  -p>> $ps

gmt psconvert $ps  -A -Tf