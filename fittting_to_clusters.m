image = imread('/Users/shahud-work/Desktop/From_Backup/Downloads/GroundTruth/original_80_cnned/1.png');

srcDir = '/Users/shahud-work/Desktop/From_Backup/Downloads/GroundTruth/original_80_cnned/';
srcFiles = dir(fullfile(srcDir,'*.png'));

% 4 , 33
Cluster1 = 0;

% 34 , 61
Cluster2 = 0;

% 62  , 90
Cluster3 = 0;

% 91 , 127
Cluster4 = 0;

% 128  , 180
Cluster5 = 0;

% 181  , 255
Cluster6 = 0;

cluster1_arr = [];
cluster2_arr = [];
cluster3_arr = [];
cluster4_arr = [];
cluster5_arr = [];
cluster6_arr = [];

% use a counter 

for k = 1:80
    disp(k)
    Cluster1 = 0;
    Cluster2 = 0;
    Cluster3 = 0;
    Cluster4 = 0;
    Cluster5 = 0;
    Cluster6 = 0;
    filename = fullfile(srcDir,srcFiles(k).name);
    I = imread(filename);
    %imshow(I)
    I = I(:);
    I = I';
    for j = 1:size(I,2)
        if (I(j)>0) && (I(j)<=33)
            Cluster1 = Cluster1+1 ;
        elseif (I(j)>=34) && (I(j)<61)
            Cluster2 = Cluster2+1 ;
        elseif (I(j)>=62) && (I(j)<90)
            Cluster3 = Cluster3+1 ;
        elseif (I(j)>=91) && (I(j)<127)
            Cluster4 = Cluster4+1 ;
        elseif (I(j)>=128) && (I(j)<=180)
            Cluster5 = Cluster5+1 ;
        elseif (I(j)>=181) && (I(j)<=255)
            Cluster6 = Cluster6+1 ;
        end
    end
    cluster1_arr = [cluster1_arr Cluster1 ];
    cluster2_arr = [cluster2_arr Cluster2 ];
    cluster3_arr = [cluster3_arr Cluster3 ];
    cluster4_arr = [cluster4_arr Cluster4 ];
    cluster5_arr = [cluster5_arr Cluster5 ];
    cluster6_arr = [cluster6_arr Cluster6 ];
end

%adding to all 80 images arrays


bar(cluster1_arr,'red')
hold on;
bar(cluster2_arr,'green')
hold on;
bar(cluster3_arr,'blue')
hold on;
bar(cluster4_arr,'black')
hold on;
bar(cluster5_arr,'cyan')
hold on;
bar(clusterz_arr,'yellow')





