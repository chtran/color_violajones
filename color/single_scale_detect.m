function isFace = single_scale_detect(stages, integral_images)

    for stage = stages
        stage_sum = 0;
        for tree = stage.trees
            response = compute_response(tree.filter, integral_images);
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