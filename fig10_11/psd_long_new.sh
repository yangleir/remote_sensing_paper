#!/usr/bin/env bash
# trasform the PSD to each other. 
# From space to time and from time to space.

gmt set FORMAT_DATE_MAP "o dd" FORMAT_CLOCK_MAP hh:mm 
gmt gmtset MAP_GRID_PEN_PRIMARY	= 0.1p,0/0/0,2_1_0.25_1:0
gmt gmtset FONT_LABEL = 10p,19, 
gmt gmtset FONT_TITLE = 14p
gmt gmtset MAP_TITLE_OFFSET = 3p

# high-pass filter
ps3=jizai_new.ps
data_jizai1_L=../data/simu_wave_space_new.txt
gnss1=../data/simu_wave_time_new.txt


awk '{print $1,$2}' $gnss1 | gmt spectrum1d  -S64 -W --GMT_FFT=brenner -N -i1 -D1  > pow5_pass.txt
awk '{print $1,$2}' $data_jizai1_L | gmt spectrum1d  -S512 -W --GMT_FFT=brenner -N -i1 -D1   > pow5_jizai1_x.txt

R=-R0/3000/-2/2
gmt psbasemap $R -Bxafg+l"Distance/meter" -Byagf+l"simulated WSSE/m" -JX5i/1.5i -BWSne -K  -Xc > $ps3
gmt psxy  $data_jizai1_L  $R  -J -W0.5p,blue  -K -O >> $ps3
gmt psbasemap -R0/400/-2/2 -Bxafg+l"Time/second" -Byagf+l"simulated WSSE/m" -JX5i/1.5i -BWSne -K  -O -Y2.2i  >> $ps3
gmt psxy  $gnss1 -R0/400/-2/2  -J -W0.5p,red  -K -O >> $ps3

# time to space
gmt psbasemap -R1/1000/0/15 -JX-2il/2i -Bxa1pf3g3+l"Wavelength:seconds(or m)"  -Byag+l"Power spectrum:m@+2@+/cycle/m(s)" -BWSne -K -O -Y2.2i >> $ps3
awk '{print 1/(2*3.14159/(9.8*$1*$1)),$2*9.8*$1/(4*3.14159)}' pow5_pass.txt | gmt psxy -R -JX-2il/2i -K -W2.25p,red -O -i0,1 >> $ps3
awk '{print $1,$2}' pow5_jizai1_x.txt | gmt psxy -R -JX-2il/2i -W2.25p,blue -O -K -i0,1 >> $ps3
# space to time
gmt psbasemap -R-7/0/-1e-1/4e-1 -JX2i/2i -Byag+l"variance preserving spectrum:/m@+2@+" -BWN -K -O -X3i>> $ps3
awk '{print log(1/$1),$2*(1/$1)}' pow5_pass.txt | gmt psxy -R -J -K -W4.25p,red -O -i0,1 >> $ps3
awk '{print log(1/sqrt($1*2*3.14/9.8)),2*$2*(1/$1)}' pow5_jizai1_x.txt | gmt psxy -R -J -W2.25p,blue -O -K -i0,1 -t50>> $ps3
gmt psbasemap -R-7/0/-1e-1/4e-1 -JX2i/2i  -BSEwn -Bxaf+l"Frequency:ln(cycle/s)" -O >> $ps3

gmt psconvert $ps3 $ps -A -Tf


rm gmt.* smooth_track* t.d