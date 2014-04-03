function response = compute_response(filter, integral_images)
% filter is a mx6 matrix where each row defines a rectangle
% column 1 is the top left x value
% column 2 is the top left y value
% column 3 is the rectangle width
% column 4 is the rectangle height
% column 5 is the weight(coefficient)
% column 6 is the channel number
    response = 0;
    for ii = 1:size(filter, 1)
        x = filter(ii,1);
        y = filter(ii,2);
        width = filter(ii,3);
        height = filter(ii,4);
        weight = filter(ii,5);
        channel = filter(ii,6);

        rect_response = integral_images(x+width, y+height, channel) ...
            + integral_images(x, y, channel) ...
            - integral_images(x+width, y, channel) ...
            - integral_images(x, y+height, channel);
        rect_response = weight*rect_response;
        response = response + rect_response;
    end
end