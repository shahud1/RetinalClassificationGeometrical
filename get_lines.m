% Load the OCT image
image = imread('/Users/shahudm/Downloads/GroundTruth/original_80_cnned/2.png');

% Convert the image to grayscale
grayImage = rgb2gray(image);
lower = 0.15;
upper = 0.9;
grayImage = imadjust(grayImage, [lower upper]);

% Threshold the image to separate the layers
threshold = graythresh(grayImage);
bwImage = imbinarize(grayImage, threshold);

% Fill any holes in the image to make a solid object
filledImage = imfill(bwImage, 'holes');

% Remove any small objects in the image
minObjectArea = 10; % adjust this value as needed
cleanedImage = bwareaopen(filledImage, minObjectArea);

% Label the objects in the image
labeledImage = bwlabel(cleanedImage);

% Get the properties of each object
properties = regionprops(labeledImage, 'BoundingBox', 'Area');

% Sort the objects based on their area
[~, areaIndex] = sort([properties.Area], 'descend');

% Create a binary image that contains only the boundary lines of the 2 largest objects
boundaryImage = false(size(labeledImage));
b1 = {};
b2 = {};
for i = 1:2
    boundary = bwboundaries(labeledImage == areaIndex(i));
    boundary = boundary{1};
    b1{i} = boundary(:,1);
    b2{i} = boundary(:,2);
    boundarySub = sub2ind(size(labeledImage), boundary(:,1), boundary(:,2));
    boundaryImage(boundarySub) = true;
end

% Use the boundary image as a mask to extract the boundary lines from the original image
outputImage = image;
outputImage(~repmat(boundaryImage, [1 1 3])) = 0;

% Save the output image
imwrite(outputImage, 'output.png');


outputImage = imread('output.png');
grayImage = rgb2gray(outputImage);
threshold = graythresh(grayImage);
binaryImage = imbinarize(grayImage, threshold);


numLoops = size(binaryImage,2);
numClustersArray = []; 

for x = 1:numLoops
    column_values = binaryImage(:, x);

    column_values = int8(column_values);
    column_values = transpose(column_values);
    cluster_starts = find(diff([0 column_values 0]) == 1);  % Find starting indices of clusters
    cluster_ends = find(diff([0 column_values 0]) == -1);   % Find ending indices of clusters
    num_clusters = length(cluster_starts);                   % Count the number of clusters
    numClustersArray = [numClustersArray, num_clusters];  % Append num_clusters to the array
end

avgNumClusters = mean(numClustersArray); 
modeNumClusters = mode(numClustersArray); 
disp(['Average: ', num2str(avgNumClusters)])
disp(['Mode: ', num2str(modeNumClusters)])



%%%%%% Choosing right cluster by using lowest mean %%%%%%

outputImage = image;

b1_average = mean(b1{1});
b2_average = mean(b1{2});

if b1_average < b2_average
    X_values = b2{1};
    Y_values = b1{1};
else
    X_values = b2{2};
    Y_values = b1{2};
end 

% X_values = boundary(:,2);
% Y_values = boundary(:,1);

max_val = max(X_values);
max_idx = find(X_values == max_val);
last_max_idx = max_idx(end);
X = X_values(last_max_idx+1:end);
Y = Y_values(last_max_idx+1:end);

X_values_transposed = transpose(X);
Y_values_transposed = transpose(Y);

imshow(binaryImage)
hold on;
plot(X_values_transposed,Y_values_transposed,'r', 'LineWidth', 2)

% Next: Pick the correct area!


% Comparing the line with the Ground truth

hold off;

imshow(image);
hold on
plot(-Y_values_transposed)

