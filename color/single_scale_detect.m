function [f_x, f_y, f_scale] = single_scale_detect(x, y, scale, cascade, integral_images)
    num_windows = size(x,1);
    isFace = ones(num_windows, 1);
    % Go through each stage in the cascade
    for stage = stages
        stage_sum = 0;
        % Go through each tree in the stage
        for tree_i = 1:size(stage.trees,1)
            tree = stage.trees(tree_i);
            % Compute the response of the image to the filter
            response = compute_response(x,y,w,h,cascade.w, cascade.h, tree.filter, integral_images);
            % Add left_val if response is under threshold, right_val
            % otherwise
            if response < tree.threshold
                stage_sum = stage_sum + tree.left_val;
            else
                stage_sum = stage_sum + tree.right_val;
            end
        end
        
        if stage_sum < stage.stage_threshold
            isFace = 0;
            return;
        end
    end
    isFace = 1;
end