function [integral_images] = get_integral_images(img)
    img=im2double(img);

    num_channels = size(img,3);
    width = size(img, 2);
    height = size(img, 1);
    integral_images = zeros(height, width, num_channels);
    for channel = 1:num_channels
        integral_images(:, :, channel) = cumsum(cumsum(img(:,:,channel),1),2);
    end
end