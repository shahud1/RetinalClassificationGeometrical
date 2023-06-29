
cd '/Users/shahud/Desktop/GroundTruth/original_80/'
a = [];
b = [];
for n_value = 1:80
   filename = [num2str(n_value) '_Original' '.jpeg'];
   img = imread(filename);
   imshow(img)
   impixelinfo();
   x = input('Input x number: ');
   y = input('Input y number: ');
   a =[a x];
   b =[b y];
   disp(n_value);
end


