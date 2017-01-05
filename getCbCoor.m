function [xCb, yCb, iFrame] = getCbCoor(dirExp,imageType)

locationCbFile = strcat(dirExp,'CB location.txt');

if (imageType)
    dirName     = strcat(dirExp,'IR\');
else
    dirName     = strcat(dirExp,'HRV\');
end


vList = dir([dirName, '*.gif']);
L     = length(vList);
fid   = fopen(locationCbFile);

xCb   = [];
yCb   = [];

tline = fgets(fid);
while ischar(tline)
%     disp(tline)
    tline = fgets(fid);
    if (tline(1) == '~');
        break;
    end
    
    cLineSplit   = strsplit(tline);
    xCb(end + 1) = str2double(cLineSplit{2});
    yCb(end + 1) = str2double(cLineSplit{4});
end
tline      = fgets(fid);
cLineSplit = strsplit(tline);
timeStr    = cLineSplit{3}

temp           = strsplit(timeStr,':');
timeStr        = strcat(temp(1),temp(2));
fclose(fid);

xCb = xCb';
yCb = yCb';

for ii = 1:L
    
    curTimeStr = strsplit(vList(ii).name,'_');
    curTimeStr = regexp(curTimeStr(2),'\d*','Match');

   if (strcmp(curTimeStr{1},timeStr))
       iFrame = ii;
   end
   
end