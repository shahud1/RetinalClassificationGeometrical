
image_num =10;
ilm_x = ILM1;
opl_x = OPL1;
rpe_x = RPE1;
% img = imread("/Users/shahud/Desktop/GroundTruth/original_80/"+ image_num +"_Original.jpeg");
%img = imread("/Users/shahud/Desktop/GroundTruth/23.png");
img = imread("/Users/shahudm/Downloads/GroundTruth/original_80_cnned/1.png");
img = imresize(img,0.5);

%ilm_x = ILM34;
ilm_y_n = size(ilm_x,2);
ilm_y = 1:ilm_y_n; 

%opl_x = OPL34;
opl_y_n = size(opl_x,2);
opl_y = 1:opl_y_n;

%rpe_x = RPE34;
rpe_y_n = size(rpe_x,2);
rpe_y = 1:rpe_y_n;

imshow(img,'Border','tight')
hold on;

%plot(ilm_y,ilm_x,'red','LineWidth', 2)
h = area(ilm_y,ilm_x);
colororder('White');
saveas(gcf,'below_ILM.png')
hold on;


%plot(opl_y,opl_x,'green','LineWidth', 2)
i = area(opl_y,opl_x);
colororder('White');
saveas(gcf,'below_OPL.png')
hold on;


%plot(rpe_y,rpe_x,'blue','LineWidth', 2);
j = area(rpe_y,rpe_x);
colororder('White');
saveas(gcf,'below_RPE.png')
hold off;



A = imread("below_ILM.png");
B = imread("below_OPL.png");
C = imread("below_RPE.png");

btw_ilm_opl = A - B;
btw_opl_rpe = B - C;
btw_ilm_rpe = A - C;



% Finding the area between ILM and RPE

count_btw_ilm_rpe = sum(btw_ilm_rpe(:) ~=0);
disp(count_btw_ilm_rpe)


% Finding the area between ILM and OPL (1)

count_btw_ilm_opl = sum(btw_ilm_opl(:) ~=0);
disp(count_btw_ilm_opl)


% Finding the area between OPL and RPE (2)

count_btw_opl_rpe = sum(btw_opl_rpe(:) ~=0);
disp(count_btw_opl_rpe)


% Finding the area of 1st quadrant and 2nd quarant( left and right part of (1))


foveax = a(image_num);
foveay = b(image_num);
length_of_img = size(img,2);
width_of_img = size(img,1);
adjusted_size_of_left_side_first_q = foveax;
adjusted_size_of_right_side_first_q = length_of_img - foveax;
real_size_of_left_side_first_q = foveax;
real_size_of_right_side_first_q = length_of_img - foveax;
difference_first_q = adjusted_size_of_left_side_first_q - adjusted_size_of_right_side_first_q;
difference_first_q = abs(difference_first_q);

left_side_of_first_q = btw_ilm_opl(:, 1:foveax, :);
right_side_of_first_q = btw_ilm_opl(:, foveax:length_of_img, :);

if adjusted_size_of_left_side_first_q > adjusted_size_of_right_side_first_q
   left_side_of_first_q = btw_ilm_opl(:, difference_first_q:foveax, :);
   adjusted_size_of_left_side_first_q = foveax - difference_first_q;
else
   right_side_of_first_q = btw_ilm_opl(:, foveax:length_of_img-difference_first_q, :);
   adjusted_size_of_right_side_first_q = length_of_img - (foveax + difference_first_q);
end

count_first_quadrant = sum(left_side_of_first_q(:) ~=0);
count_second_quadrant = sum(right_side_of_first_q(:) ~=0);

%imshow(left_side_of_first_q);
%pause;
%imshow(right_side_of_first_q)
%pause;


% Finding the area of 3rd quadrant and 4th quarant( left and right part of (2))


adjusted_size_of_left_side_third_q = foveax;
adjusted_size_of_right_side_third_q = length_of_img - foveax;
real_size_of_left_side_third_q = foveax;
real_size_of_right_side_third_q = length_of_img - foveax;
difference_third_q = adjusted_size_of_left_side_third_q - adjusted_size_of_right_side_third_q;
difference_third_q = abs(difference_third_q);

left_side_of_third_q = btw_opl_rpe(:, 1:foveax, :);
right_side_of_third_q = btw_opl_rpe(:, foveax:length_of_img, :);

if adjusted_size_of_left_side_third_q > adjusted_size_of_right_side_third_q
   left_side_of_third_q = btw_opl_rpe(:, difference_third_q:foveax, :);
   adjusted_size_of_left_side_third_q = foveax - difference_third_q;
else
   right_side_of_third_q = btw_opl_rpe(:, foveax:length_of_img-difference_third_q, :);
   adjusted_size_of_right_side_third_q = length_of_img - (foveax + difference_third_q);
end

count_third_quadrant = sum(left_side_of_third_q(:) ~=0);
count_fourth_quadrant = sum(right_side_of_third_q(:) ~=0);

%imshow(left_side_of_third_q);
%pause;
%imshow(right_side_of_third_q)


% distance between fovea and the OPL layer

dist_fovea_opl = abs(foveay - (opl_x(foveax)));


% distance between fovea and the RPE layer

dist_fovea_rpe = abs(foveay - (rpe_x(foveax)));


% global maximum of each half
imshow(img)
% ILM left
first_qx_left = ilm_x(:, 1:foveax, :);
first_qy_left = ilm_y(:, 1:foveax, :);

%ILM right
first_qx_right = ilm_x(:, foveax:length_of_img, :);
first_qy_right = ilm_y(:, foveax:length_of_img, :);

% % OPL left
third_qx_left = opl_x(:, 1:foveax, :);
third_qy_left = opl_y(:, 1:foveax, :);
% OPL right
third_qx_right = opl_x(:, foveax:length_of_img, :);
third_qy_right = opl_y(:, foveax:length_of_img, :);
% 
% % RPE left
fourth_qx_left = rpe_x(:, 1:foveax, :);
fourth_qy_left = rpe_y(:, 1:foveax, :);
% RPE right
fourth_qx_right = rpe_x(:, foveax:length_of_img, :);
fourth_qy_right = rpe_y(:, foveax:length_of_img, :);

% plot(first_qy_left,first_qx_left,'LineWidth', 3)
% plot(first_qy_right,first_qx_right,'LineWidth', 3)
% plot(third_qy_left,third_qx_left,'LineWidth', 3)
% plot(third_qy_right,third_qx_right,'LineWidth', 3)
% plot(fourth_qy_left,fourth_qx_left,'LineWidth', 3)
% plot(fourth_qy_right,fourth_qx_right,'LineWidth', 3)

%max point of ILM:
[M_first_qy_left I_first_qy_left] = min(first_qx_left);
[M_first_qy_right I_first_qy_right] = min(first_qx_right);

% min distance between curve of ILM and OPL layer
rx = third_qx_left(I_first_qy_left);
ry = third_qx_right(I_first_qy_right);
min_distance_ilm_opl_firstq = abs(M_first_qy_left - rx );
min_distance_ilm_opl_secondq = abs(M_first_qy_left - ry );



% min distance between curve of ILM and RPE layer

qx = fourth_qx_left(I_first_qy_left);
qy = fourth_qx_right(I_first_qy_right);
min_distance_ilm_rpe_firstq = abs(M_first_qy_left - qx );
min_distance_ilm_rpe_secondq = abs(M_first_qy_left - qy );


%middle point of OPL
distance_between_opl_rpe = dist_fovea_rpe - dist_fovea_opl;










% to initiate feature vars only
% feature_area_btw_ilm_opl = [];
% feature_area_btw_opl_rpe = [];
% feature_area_btw_ilm_rpe = [];
% feature_area_first_quadrant = [];
% feature_area_second_quadrant = [];
% feature_area_third_quadrant = [];
% feature_area_fourth_quadrant = [];
% feature_dist_fovea_opl = [];
% feature_dist_fovea_rpe = [];
% feature_min_distance_ilm_opl_firstq = [];
% feature_min_distance_ilm_opl_secondq = [];
% feature_min_distance_ilm_rpe_firstq = [];
% feature_min_distance_ilm_rpe_secondq = [];
% feature_dist_between_opl_fovea_atfovea = [];

% feature_area_btw_ilm_opl = [feature_area_btw_ilm_opl count_btw_ilm_opl];
% feature_area_btw_opl_rpe = [feature_area_btw_opl_rpe count_btw_opl_rpe];
% feature_area_btw_ilm_rpe = [feature_area_btw_ilm_rpe count_btw_ilm_rpe];
% feature_area_first_quadrant = [feature_area_first_quadrant count_first_quadrant];
% feature_area_second_quadrant = [feature_area_second_quadrant count_second_quadrant];
% feature_area_third_quadrant = [feature_area_third_quadrant count_third_quadrant];
% feature_area_fourth_quadrant = [feature_area_fourth_quadrant count_fourth_quadrant];
% feature_dist_fovea_opl = [feature_dist_fovea_opl dist_fovea_opl];
% feature_dist_fovea_rpe = [feature_dist_fovea_rpe dist_fovea_rpe];
feature_min_distance_ilm_opl_firstq = [min_distance_ilm_opl_firstq];
feature_min_distance_ilm_opl_secondq = [min_distance_ilm_opl_secondq];
feature_min_distance_ilm_rpe_firstq = [min_distance_ilm_rpe_firstq];
feature_min_distance_ilm_rpe_secondq = [min_distance_ilm_rpe_secondq];
feature_dist_between_opl_fovea_atfovea = [distance_between_opl_rpe];


