function [f_x, f_y, f_scale] = multi_scale_detect(x, y, scale, cascade, integral_images)
    num_windows = size(x,1);
    isFace = 1:num_windows;
    % Go through each stage in the cascade
    for stage = cascade.stages
        stage_sums = zeros(length(isFace), 1);
        % Go through each tree in the stage
        for tree_i = 1:size(stage.trees,1)
            tree = stage.trees(tree_i);
            % Compute the response of the windows to the filter
            responses = compute_response(x, y, scale, tree.filter, integral_images);
            % Add left_val if response is under threshold, right_val
            % otherwise
            
            positives = responses > tree.threshold;
            negatives = responses <= tree.threshold;
            stage_sums(positives) = stage_sums(positives) + tree.right_val;
            stage_sums(negatives) = stage_sums(negatives) + tree.left_val;
           
        end
        faces = stage_sums >= stage.stage_threshold;
        isFace = isFace(faces);
    end
    f_x = x(isFace);
    f_y = y(isFace);
    f_scale = scale(isFace);
end