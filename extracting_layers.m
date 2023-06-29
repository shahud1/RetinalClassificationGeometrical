%-----------------------------------------------------------
%THIS IS THE SKELETON CODE TO HELP YOU START OFF WITH A SIMPLE APPROACH TO
%FIND THE TOP-MOST LINE IN AN OCT IMAGE AND THE FOVEA, RESPECTIVELY.
%YOUR TASK ARE
%   - TO COMPLETE AND OPTIMISE.
%   - TO DEVELOP OTHER APPROACH OF YOUR OWN.
%   - TO COMPARE THE BETWEEN THE APPROACHES DEVELOPED & OTHER AVALABLE APPROACHES.

%DR.SOMRUDEE
%-----------------------------------------------------------

clear all;

maskILM = imread('/Users/shahudm/Downloads/GroundTruth/groundtruth/21_ILM.png');
maskOPL = imread('/Users/shahudm/Downloads/GroundTruth/groundtruth/21_OPL.png');
maskRPE = imread('/Users/shahudm/Downloads/GroundTruth/groundtruth/21_RPE.png');

% Getting the ILM layer

%img = imread('/Users/shahud/Desktop/GroundTruth/original_80/2_Original.jpeg');


mask = maskILM;


oct = mask; 

%GO THROUGH ALL VALUES IN THE IMAGE ARRAY.

t=0;
for j=1:size(oct,2) %x coordinate (column index)
    for i=1:(size(oct,1))-9 %y coordinate (row index)
        subset_col = double(oct(i:1:i+9,j)); %pick 10 successive rows from the same column
        avg_subset_col(i,j) = mean(subset_col); %average over the grey scale values in the 10 successive rows.
        st_dev_subset_col(i,j) = std(subset_col,1); % S.D. of avg_subset_col
        var_dev_subset_col(i,j) = var(subset_col,1); %Variance of avg_subset_col
        
    end
end

%------------FIND THE TOP-MOST LINE------------
%threshold0 = std(avg_subset_col(:,1),1);
min_point = 0;
threshold_option1 = 1.5*mean(st_dev_subset_col) + 1.5*(std(st_dev_subset_col)); %threshold value to be adjusted (this one is column-independent)
threshold = threshold_option1;
for l = 1:size(oct,2) %only look at the upper half of the image 
    k = 1;
    while k < size(oct,1) %go through every pixels of the image width
        k = k+1;
        %if the S.D. of the 10 successive pixels exceed the value of the defined threshold, select as the coordinates of the top-most line
        if st_dev_subset_col(k,l) >= threshold(1,l)%&& k<=size(oct,1)/2
            min_point = k+8;
            %int_min_point = oct_sq(k,l);
            line(1, l) = min_point;
            top_line(1, l) = 263-min_point;
            k = size(oct,1);
        end
    end
    
end


%figure;
imshow(mask) %Plot the OCT image
hold on;
plot(line, 'LineWidth', 3) %Plot the top-most line found
lineilm = line;

%pause;

%%%%%%%%%%%%%%%%%%%%%%%%%
% Getting the OPL layer %
%%%%%%%%%%%%%%%%%%%%%%%%%

mask = maskOPL;
mask = rgb2gray(mask)
oct = mask; 


%GO THROUGH ALL VALUES IN THE IMAGE ARRAY.

t=0;
for j=1:size(oct,2) %x coordinate (column index)
    for i=1:(size(oct,1))-9 %y coordinate (row index)
        subset_col = double(oct(i:1:i+9,j)); %pick 10 successive rows from the same column
        avg_subset_col(i,j) = mean(subset_col); %average over the grey scale values in the 10 successive rows.
        st_dev_subset_col(i,j) = std(subset_col,1); % S.D. of avg_subset_col
        var_dev_subset_col(i,j) = var(subset_col,1); %Variance of avg_subset_col
        
    end
end

%------------FIND THE TOP-MOST LINE------------
%threshold0 = std(avg_subset_col(:,1),1);
min_point = 0;
threshold_option1 = 1.5*mean(st_dev_subset_col) + 1.5*(std(st_dev_subset_col)); %threshold value to be adjusted (this one is column-independent)
threshold = threshold_option1;
for l = 1:size(oct,2) %only look at the upper half of the image
    k = 1;
    while k < size(oct,1) %go through every pixels of the image width
        k = k+1;
        %if the S.D. of the 10 successive pixels exceed the value of the defined threshold, select as the coordinates of the top-most line
        if st_dev_subset_col(k,l) >= threshold(1,l)%&& k<=size(oct,1)/2
            min_point = k+8;
            %int_min_point = oct_sq(k,l);
            line(1, l) = min_point;
            top_line(1, l) = 263-min_point;
            k = size(oct,1);
        end
    end
    
end


%figure;
imshow(mask) %Plot the OCT image
hold on;
plot(line, 'LineWidth', 3) %Plot the top-most line found
lineopl = line;

%pause;

%%%%%%%%%%%%%%%%%%%%%%%%%
% Getting the RPE layer %
%%%%%%%%%%%%%%%%%%%%%%%%%

mask = maskRPE;
mask = rgb2gray(mask);
oct = mask; 


%GO THROUGH ALL VALUES IN THE IMAGE ARRAY.

t=0;
for j=1:size(oct,2) %x coordinate (column index)
    for i=1:(size(oct,1))-9 %y coordinate (row index)
        subset_col = double(oct(i:1:i+9,j)); %pick 10 successive rows from the same column
        avg_subset_col(i,j) = mean(subset_col); %average over the grey scale values in the 10 successive rows.
        st_dev_subset_col(i,j) = std(subset_col,1); % S.D. of avg_subset_col
        var_dev_subset_col(i,j) = var(subset_col,1); %Variance of avg_subset_col
        
    end
end

%------------FIND THE TOP-MOST LINE------------
%threshold0 = std(avg_subset_col(:,1),1);
min_point = 0;
threshold_option1 = 1.5*mean(st_dev_subset_col) + 1.5*(std(st_dev_subset_col)); %threshold value to be adjusted (this one is column-independent)
threshold = threshold_option1;
for l = 1:size(oct,2) %only look at the upper half of the image
    k = 1;
    while k < size(oct,1) %go through every pixels of the image width
        k = k+1;
        %if the S.D. of the 10 successive pixels exceed the value of the defined threshold, select as the coordinates of the top-most line
        if st_dev_subset_col(k,l) >= threshold(1,l)%&& k<=size(oct,1)/2
            min_point = k+8;
            %int_min_point = oct_sq(k,l);
            line(1, l) = min_point;
            top_line(1, l) = 263-min_point;
            k = size(oct,1);
        end
    end
    
end


%figure;
imshow(mask) %Plot the OCT image
hold on;
plot(line, 'LineWidth', 3) %Plot the top-most line found
linerpe = line;


ILM21 = lineilm;
OPL21 = lineopl;
RPE21 = linerpe;
save GT_ILM.mat ILM21 -append
save GT_OPL.mat OPL21 -append
save GT_RPE.mat RPE21 -append
