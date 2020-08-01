function writegrid(x,y,z,name,nx,ny)
filename=name;
delete (filename)

nccreate(filename,'lat','Dimensions',{'lat' nx});
ncwriteatt(filename, 'lat', 'standard_name', 'lat');
ncwriteatt(filename, 'lat', 'long_name', 'lat');
ncwriteatt(filename, 'lat', 'units', 'meter');
ncwriteatt(filename, 'lat', '_CoordinateAxisType', 'Lat');
% ncwriteatt(filename,'/','standard_name','latitude');
nccreate(filename,'lon','Dimensions',{'lon' ny});
ncwriteatt(filename, 'lon', 'standard_name', 'lon');
ncwriteatt(filename, 'lon', 'long_name', 'lon');
ncwriteatt(filename, 'lon', 'units', 'meter');
ncwriteatt(filename, 'lon', '_CoordinateAxisType', 'Lon');

nccreate(filename,'Q','datatype','double','Dimensions',{'lat' nx 'lon' ny});
ncwriteatt(filename, 'Q', 'standard_name', 'ssh');
ncwriteatt(filename, 'Q', 'long_name', 'sea surface height');
ncwriteatt(filename, 'Q', 'units', 'm');

ncwrite(filename,'lat',x);
ncwrite(filename,'lon',y);

ncwrite(filename,'Q',z);

ncdisp(filename);
return 
end