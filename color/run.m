filename = '../Images/1.jpg';
integral_images = get_integral_images(imread(filename));


% Mocking tree data
stage1 = struct();
tree1 = struct();
tree1.filter = [3 7 14 4 -1. 1; 3 9 14 2 2. 2];
tree1.threshold = 4.0141958743333817e-003;
tree1.left_val = 0.0337941907346249;
tree1.right_val = 0.8378106951713562;

tree2 = struct();
tree2.filter = [1 2 18 4 -1. 2; 7 2 6 4 3. 1];
tree2.threshold = 0.0151513395830989;
tree2.left_val = 0.1514132022857666;
tree2.right_val = 0.7488812208175659;
stage1.trees = [tree1; tree2];
stage1.threshold = 0.8226894140243530;
stages = [stage1];

single_scale_detect(stages, integral_images)