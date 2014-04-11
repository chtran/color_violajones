function responses = compute_response(x, y, scale, filter, integral_images)
% filter is a mx6 matrix where each row defines a rectangle
% column 1 is the top left x value
% column 2 is the top left y value
% column 3 is the rectangle width
% column 4 is the rectangle height
% column 5 is the weight(coefficient)
% column 6 is the channel number (1=R, 2=G, 3=B)
    num_windows = size(x, 1);
    responses = zeros(num_windows, 1);
    for wd_id = 1:num_windows
        wd_x = x(wd_id);
        wd_y = y(wd_id);
        
        for ii = 1:size(filter, 1)
            f_x = filter(ii,1);
            f_y = filter(ii,2);
            f_w = filter(ii,3);
            f_h = filter(ii,4);
            weight = filter(ii,5);
            channel = filter(ii,6);

            rect_response = integral_images(wd_x+scale*(f_x+f_w), wd_y+scale*(f_y+f_h), channel) ...
                + integral_images(wd_x+scale*f_x, wd_y+scale*f_y, channel) ...
                - integral_images(wd_x+scale*(f_x+f_w), wd_y+scale*f_y, channel) ...
                - integral_images(wd_x+scale*f_x, wd_y+scale*(f_y+f_h), channel);
            rect_response = weight*rect_response;
            responses = responses + rect_response;
        end
    end
end