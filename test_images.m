%Code to generate test images from lfw dataset: download from https://vis-www.cs.umass.edu/lfw/
cd '/Users/parisavaziri/Downloads/CN_exp/lfw-deepfunneled' %replace with folder with downloaded images
k=dir;
test_set_size=100;
dim1=100;
dim2=100;
TT=zeros(dim1*dim2,test_set_size); 
ind=1;
for i=4000:4100-1
    s=strcat('/Users/parisavaziri/Downloads/CN_exp/lfw-deepfunneled',k(i).name);
    cd(s) 
    file_struct = dir('**/*.jpg'); %struct for all image files
    A=imread(file_struct(1).name);
    s2=strcat('/Users/parisavaziri/Downloads/CN_exp/Test_Images/',num2str(ind),'.jpg');
    imwrite(A, s2);
    if size(A,3) > 1
        I = double(rgb2gray( A ));
    else
        I=double(A);
    end
    I2=imresize(I,[100 100]);
    TT(:,ind)=I2(:);
    ind=ind+1;
    cd '/Users/parisavaziri/Downloads/CN_exp/lfw-deepfunneled'
end
save('testdata')

