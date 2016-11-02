function [xCb, yCb, iFrame] = getCbCoor(dirExp,imageType)

locationCbFile = strcat(dirExp,'CB location.txt');

if (imageType)
    dirName     = strcat(dirExp,'IR\');
else
    dirName     = strcat(dirExp,'HRV\');
end

vList          = dir([dirName, '*.gif']);
L              = length(vList);
fid            = fopen(locationCbFile);
C              = textscan(fid,'%s %s %s %s');
xCb            = str2double(C{1,2}{2});
yCb            = str2double(C{1,4}{2});
timeStr        = C{1,3}{4};
temp           = strsplit(timeStr,':');
timeStr        = strcat(temp(1),temp(2));
fclose(fid);

for ii = 1:L
    
    curTimeStr = strsplit(vList(ii).name,'_');
    curTimeStr = regexp(curTimeStr(2),'\d*','Match');

   if (strcmp(curTimeStr{1},timeStr))
       iFrame = ii;
   end
   
end