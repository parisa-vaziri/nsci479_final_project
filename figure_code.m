%Code to draw all figures
clear
load('Main_results')

 
hfig=figure;
imagesc(reshape(mean(C,2),dim1,dim2)) % Plot the mean face
axis off;
colormap(gray)
exportgraphics(hfig,'fig1.pdf','Resolution',300,'ContentType','vector')

 
hfig=figure;
for i=1:9
    subplot(3, 3, i);
    imagesc(reshape(U(:,i),dim1,dim2)) % Plot first 9 eigenfaces 
    colormap(gray)
    axis off;
end
exportgraphics(hfig,'fig2.pdf','Resolution',300,'ContentType','vector')

 
%Load up test pic and try reconstruction with variable number of PCs
test_image=imread("iy.jpeg");
img=imresize(double(rgb2gray( test_image )),[dim1 dim2]);
img = img(:) - mean(C,2);
figure (3)
hfig=figure;
ind=1;
for pc=[1 150 300 450 600 750 900 1050 1200]
    subplot(3, 3, ind);
    img2 = mean(C,2) + (U(:,1:pc)*(U(:,1:pc)'*img));
    imagesc(reshape(img2,dim1,dim2))
    axis off;
    colormap(gray)
    ind=ind+1;
end
exportgraphics(hfig,'fig3.pdf','Resolution',300,'ContentType','vector')



%variance calculation for figure
var_list=cumsum(diag(S))/sum(diag(S));

%plot variance contribution for first 800 eigenvalues
 
hfig=figure;
plot(var_list(1:2000))
ylim([0 1])
exportgraphics(hfig,'fig4.pdf','Resolution',300,'ContentType','vector')