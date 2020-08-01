#!/usr/bin/env bash
gmt set FORMAT_DATE_MAP "o dd" FORMAT_CLOCK_MAP hh:mm FONT_LABEL 15p,,black
ps=power2D.ps

# ==========================================================================================================
# The GNSS buoy data were bandpass filtered 
gnss1=../data/gnss_b1_hlf_all.txt
gnss2=../data/gnss_b2_hlf_all.txt
# The GNSS buoy data were not bandpass filtered  
# gnss1=../data/gfb1.txt
# gnss2=../data/gfb2.txt

gmt psbasemap -R2/200/1e-3/1e4 -JX-4il/4il -Bxa2f3g3+l"Wavelength:seconds" -Bya-1pg+l"Power spectrum density:cm@+2@+/cycle/s" -BWNse -K > $ps

awk ' $1>57600 && $1<115200 {print $1,$2*100}' $gnss1 | gmt spectrum1d  -S64 -W --GMT_FFT=brenner -N -i1 -D1 > pow5.txt
awk ' $1>57600 && $1<115200 {print $1,$2*100}' $gnss2 | gmt spectrum1d  -S64 -W --GMT_FFT=brenner -N -i1 -D1 > pow52.txt

gmt psxy -R -JX -K pow5.txt -W2.25p,red,1_3_1_3:1p -O -i0,1 --PS_LINE_CAP=round>> $ps
gmt psxy -R -K -JX pow52.txt -W2.25p,blue -O -i0,1 >> $ps
gmt psxy -R -J -O -K pow5.txt -Sc0.04i -Gblack -Ey >> $ps
gmt psxy -R -J -O  -K pow52.txt -Sc0.04i -Gblack -Ey >> $ps

gmt psbasemap -R0.005/0.5/1e-3/1e4 -JX4il/4il -BSE -Bxa1pf3+l"Frequency:cycle/seconds" -O -K >> $ps

gmt pslegend -D+w1.0i+jBL+o0.3i/3.5i -R -J -O -F+p1p+glightgray --FONT_ANNOT_PRIMARY=7p,40,blue << EOF >> $ps
S 0.2i - 0.5i - 1p,red,1_3_1_3:1p 0.5i GNSS 1
S 0.2i - 0.5i - 1p,blue 0.5i GNSS 2

EOF

gmt psconvert  $ps -P -Tf -A
rm gmt.*  smooth_track* t.d *.txt *.ps