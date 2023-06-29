srcDir = '/Users/shahud-work/Desktop/From_Backup/Downloads/GroundTruth/original_80_cnned/';
srcFiles = dir(fullfile(srcDir,'*.png'));

ohno = [];

for k = 1:numel(srcFiles)
    filename = fullfile(srcDir,srcFiles(k).name);
    I = imread(filename);
    %imshow(I)
    I = I(:);
    I = I';
    ohno = [ohno , I];
    disp(k)
end


% 5 clusters. C1,C2,C3,C4,C5
% run this after getting 5 clusters
ohno = ohno';
% [idx,C,sumd,D] = kmeans( ohno, 7 );
% 
% P0 = [0, 0];
% P1 = [C(1), 0];
% P2 = [C(2), 0];
% P3 = [C(3), 0];
% P4 = [C(4), 0];
% P5 = [C(5), 0];
% 
% 
% startval = 0;
% first_second = (P1(:)  + P2(:)).'/2;
% second_third = (P2(:)  + P3(:)).'/2;
% third_fourth = (P3(:)  + P4(:)).'/2;
% fourth_fifth = (P4(:)  + P5(:)).'/2;
% endval = 255;
% 
% 
% 
% histogram(img)
% hold on;
% plot(P1(1),0,'rX');
% hold on
% plot(P2(1),0,'rX');
% hold on
% plot(P3(1),0,'rX');
% hold on
% plot(P4(1),0,'rX');
% hold on
% plot(P5(1),0,'rX');
% hold on
% 
% 
% xline(0,'--r')
% xline(first_second(1),'--r')
% xline(second_third(1),'--r')
% xline(third_fourth(1),'--r')
% xline(fourth_fifth(1),'--r')
% xline(255,'--r')



