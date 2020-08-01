#!/usr/bin/env bash

# The data is under protection now. If you need the data, please contact me.

gmt gmtset FONT_TITLE = 10p,19  FONT_LABEL = 10p,19, 
gmt gmtset MAP_TITLE_OFFSET = 0.4c
data_jizai_large2=C:/Users/yangleir/Documents/jianguoyun/Documents/projects/guanlan/23_air_alti_sar/airborne_data/23suo/data1/test_files.nc
data_jizai_large1=C:/Users/yangleir/Documents/jianguoyun/Documents/projects/guanlan/23_air_alti_sar/airborne_data/23suo/data2/test_files.nc

gmt grdfft  $data_jizai_large1 -Gjizai1.nc  -F150/3/2
gmt grdfft  $data_jizai_large2 -Gjizai2.nc  -F150/3/2

# PLOT MAP
ps3=map.ps
J=JX3c/8c # J=JX3c/8c for large
gmt grd2cpt jizai1.nc >mss2.cpt
gmt grd2cpt $data_jizai_large1 >mss.cpt

gmt psbasemap -Rjizai1.nc -$J  -BWNSE+t"Band Filted WSSE" -Bya200+l"AIRAS at buoy 1"+s" "+u"m"  -Bxa150+um   -K -fc -p90/90 > $ps3
gmt grdimage jizai1.nc -$J -Cmss2.cpt -K -O -fc -p>> $ps3
gmt psscale -DjCB+w1.5i+o0c/-2c+h -Cmss2 -Bxaf -By+lm -R -J -O -K -p>> $ps3
for((i=100;i<=1000;i=i+10000));  
do   
	((xa=0))
	((ya=$i))
	((xb=100))
	((yb=58+$i))
	echo $i
	echo $xa $ya >loc$i.txt
	echo $xb $yb >>loc$i.txt
	gmt sample1d loc$i.txt -Fa -T0.866025 > tr$i.txt
	
	gmt grdtrack tr$i.txt -Gjizai1.nc > track$i.txt
	
	gmt psxy -R -JX -W1p,black,+ve0.05i+gblack+pfaint+bc+vb0.1i+gblue  -O -K -i0,1 -p track$i.txt>> $ps3
done
gmt grdimage $data_jizai_large1 -$J -Cmss.cpt -K -O -X15c -fc -p>> $ps3 
gmt psbasemap -R -$J -BWNSE+t"Original WSSE" -Bya200+l"AIRAS at buoy 1"+s" "+um  -Bxa150+um  -K -O -fc -p >> $ps3
gmt psscale -DjCB+w1.5i+o0c/-2c+h -Cmss -Bxaf -By+lm -R -J -O  -K -p>> $ps3

# 2
gmt grd2cpt jizai2.nc >mss2.cpt
gmt grd2cpt $data_jizai_large2 >mss.cpt

gmt psbasemap -Rjizai2.nc -$J -BWNSE+t"Band Filted WSSE" -Bya200+l"AIRAS at buoy 2"+s" "+um  -Bxa150+um  -K -fc -p -O -Y8c -X-15c >> $ps3
gmt grdimage jizai2.nc -$J -Cmss2.cpt -K -O -fc -p>> $ps3
gmt psscale -DjCB+w1.5i+o0c/-2c+h -Cmss2 -Bxaf -By+lm -R -J -O -K -p>> $ps3
for((i=100;i<=1000;i=i+10000));  
do   
	((xa=0))
	((ya=$i))
	((xb=100))
	((yb=58+$i))
	echo $i
	echo $xa $ya >loc$i.txt
	echo $xb $yb >>loc$i.txt
	gmt sample1d loc$i.txt -Fa -T0.866025 > tr$i.txt
	
	gmt grdtrack tr$i.txt -Gjizai2.nc > track$i.txt
	
	gmt psxy -R -JX  -O -K -i0,1 -p track$i.txt -W1p,black,+ve0.05i+gblack+pfaint+bc+vb0.1i+gblue >> $ps3
done
gmt grdimage $data_jizai_large2 -$J -Cmss.cpt -K -O -X15c -fc -p>> $ps3 
gmt psbasemap -R -$J -BWNSE+t"Original WSSE" -Bya200+l"AIRAS at buoy 2"+s" "+um  -Bxa150+um  -K -O -fc -p >> $ps3

gmt psscale -DjCB+w1.5i+o0c/-2c+h -Cmss -Bxaf -By+lm -R -J -O -p >> $ps3

gmt psconvert $ps3 -A -P -Tf
rm  *.history *.cpt gmt.* *.txt *.ps *.nc