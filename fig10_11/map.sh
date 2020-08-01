#!/usr/bin/env bash

# data_jizai_large1=../data/simu_wave.nc
data_jizai_large1=../wave_simulation/simu_wave.nc
gmt grdfft  $data_jizai_large1 -Gjizai1.nc -F50/-

# PLOT MAP
ps3=mss.ps
J=JX16c/4c
gmt grd2cpt $data_jizai_large1 >mss.cpt

gmt psbasemap -R0/800/0/200 -$J  -BWNSE -Bya+u"m"  -Bxa+u"m" -K -fc  > $ps3
gmt grdimage $data_jizai_large1 -R -$J -Cmss.cpt -K -O -fc>> $ps3
gmt psscale -DjCB+w1.5i+o0c/-2c+h -Cmss -Bxaf -By+lm -R -J -O  >> $ps3

gmt psconvert $ps3 -A -P -Tf
rm gmt.* jizai1.nc *.cpt *.ps
