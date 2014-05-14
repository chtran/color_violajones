function IntegralImages = GetIntergralImages(Picture,Options)
% Make integral image from a color image
%
%

% Convert the Picture to double 
Picture=im2double(Picture);

% Resize the image to decrease the processing-time
if(Options.Resize)
    if (size(Picture,2) > size(Picture,1)),
        Ratio = size(Picture,2) / 384;
    else
        Ratio = size(Picture,1) / 384;
    end
    Picture = imresize(Picture, [size(Picture,1) size(Picture,2) ]/ Ratio);
else
    Ratio=1;
end

% Convert the picture to greyscale (this line is the same as rgb2gray, see help)

% Make the integral image for fast region sum look up
num_channels = size(Picture, 3);
height = size(Picture, 1);
width = size(Picture, 2);
IntegralImages.ii = zeros(height+1, width+1, num_channels);
for c = 1:num_channels
    prepad_ii=cumsum(cumsum(Picture(:,:,c),1),2); %before padding
    IntegralImages.ii(:,:,c) = padarray(prepad_ii,[1 1], 0, 'pre');
end

% Make integral image to calculate fast a local standard deviation of the
% pixel data
Picture = rgb2gray(Picture);

IntegralImages.ii2=cumsum(cumsum(Picture.^2,1),2);
IntegralImages.ii2=padarray(IntegralImages.ii2,[1 1], 0, 'pre');

% Store other data
IntegralImages.width = size(Picture,2);
IntegralImages.height = size(Picture,1);
IntegralImages.Ratio=Ratio;
