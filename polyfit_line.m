rmses_left = [];
rmses_right = [];
for q = 1:20  

[pr,Sr,mur] = polyfit(first_qy_right, first_qx_right, q);
[pl,Sl,mul] = polyfit(first_qy_left, first_qx_left, q);

  
fr = polyval(pr,first_qy_right,Sr,mur);
fl = polyval(pl,first_qy_left,Sl,mul);

imshow(img);
hold on
plot(first_qy_right,fr,'LineWidth', 2)
hold on;
plot(first_qy_left,fl,'LineWidth', 2)


if size(fl,2)<size(fr,2)
    new_oct = img(:, 1: (foveax + size(fl,2)));
    first_qy_right_final = first_qy_right(:,(1:(size(first_qy_right,2))));
    fr_final = fr(:,(1:(size(fr,2))));
    A = -first_qy_right_final+(foveax*2);
    cutoff = find(A==0);
    A = A(:,1:cutoff,:);
    fr_final = fr_final(:,1:cutoff,:);
    f = fr_final;
    
 else
    new_oct = img(:, 1: (foveax + size(fl,2)));
    %new_oct = img(:, abs(size(fl,2)-size(fr,2)) :size(img,2) );
    disp(1)
end


hold off;


% calculating the RMSE
% RMSE = sqrt(mean((y0-y1).^2)) ; % Root mean square error 

% err = [];
% for i = (length(f))
%     e = f(i)-f(first_qy_left);
%     e = e.*e;
%     err = [err e];
% end
% 
% err_mean = mean(err);
% RMSE = sqrt(err_mean);
% disp(RMSE)
% 
% rmses = [rmses RMSE];

% imshow(new_oct)
% hold on
% plot(A,fr_final,'LineWidth', 2)
% hold on;
% plot(first_qy_left,fl,'LineWidth', 2)
% set(gcf, 'Name', string(RMSE));

% comparing the Q1 GT and polynomial

% err_right = [];
% for i = (length(fr))
%     e = fr(i)-fr(first_qy_right);
%     e = e.*e;
%     err_right = [err_right e];
% end
% 
% err_mean_right = mean(err_mean_right);
% RMSE_right = sqrt(err_mean_right);
% disp(RMSE_right)
% rmses_right = [rmses_right RMSE_right];


% rmse left side
err_left = []; 
for i = (length(fl))
    e = first_qx_left(i)-fl(i);
    e = e.^2;
    err_left = [err_left e];
end

err_mean_left = mean(err_left);
RMSE_left = sqrt(err_mean_left);
disp(RMSE_left)

rmses_left = [rmses_left RMSE_left];

hold off;
imshow(img)
hold on;
plot(first_qy_left,first_qx_left,"g","LineWidth",2)
hold on;
plot(first_qy_left,fl,"r",'LineWidth',2)
set(gcf, 'Name', string(q));

pause();

% rmse right side


err_right = []; 
for i = (length(fr_final))
    e = first_qx_right(i)-fr_final(i);
    e = e.^2;
    err_right = [err_right e];
end

err_mean_right = mean(err_right);
RMSE_right = sqrt(err_mean_right); 
disp(RMSE_right)

rmses_right = [rmses_right RMSE_right];

hold off;
imshow(img)
hold on;
plot(first_qy_right,first_qx_right,"g","LineWidth",2)
hold on;
plot(first_qy_right,fr,"r",'LineWidth',2)
set(gcf, 'Name', string(q));


pause();   

end

% plotting:

  
[val_left,idx_left] = min(rmses_left)
[val_right,idx_right] = min(rmses_right)

hold off;

   














% hold on
% 
% imshow(img);
% hold on;
% A = -first_qy_right+(190*2);
% cutoff = find(A==0);
% A = A(:,1:cutoff,:);
% f = f(:,1:cutoff,:);
% plot(A,f,'LineWidth', 2)
% hold on;
% plot(first_qy_left,first_qx_left,'LineWidth', 2)
% % calculating the RMSE
% % RMSE = sqrt(mean((y0-y1).^2)) ; % Root mean square error 
% %
% % err = [];
% % for i = (length(f))
% %     e = f(i)-f(first_qy_left);
% %     e = e.*e;
% %     err = [err e];
% % end
% % 
% % err_mean = mean(err);
% % RMSE = sqrt(err_mean);
% % disp(RMSE)