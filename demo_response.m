filename = 'additive_color.tif';
addpath('./SubFunctions');
img = imread(filename);
defaultoptions=struct('ScaleUpdate',1/1.2,'Resize',false,'Verbose',true);

IntegralImages = GetIntergralImages(img,defaultoptions);

im_width = size(img, 2);
im_height = size(img, 1);


R_C = [+2/sqrt(6), 1;
          -1/sqrt(6),  2;
          -1/sqrt(6),  3;];

R_G = [+1/sqrt(2), 1;
          -1/sqrt(2),  2];
[x,y] = ndgrid(1:im_width-1, 1:im_height-1);
x=x(:);
y=y(:);
w=ones(length(x),1);
h=ones(length(y),1);
rect_sums = zeros(length(x),1);
rects = R_G;
num_rects = size(rects, 1);
for rect_id=1:num_rects
    channel = rects(rect_id, 2);
    weight = rects(rect_id, 1);
    rect_sums = rect_sums + GetSumRect(IntegralImages.ii,x,y,w,h,channel)*weight;
end
responses = reshape(rect_sums',im_width-1,im_height-1)';

figure;
imagesc(responses);
title('Filter response');
colorbar;