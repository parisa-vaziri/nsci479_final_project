%For lfw datasets see here: https://vis-www.cs.umass.edu/lfw/#download
%Run through every image and generate eigenspace%%%%%%%%%%%%%
%Only run this if you need to retrain on different training set, otherwise
%load training.mat (if you run this again it will override training.mat!)

cd '/Users/parisavaziri/Downloads/CN_exp/lfw-deepfunneled'
k=dir;
training_set_size=3000;  

%these are the dimensions every image will be downsampled to (dim1 is
%height and dim2 is width). By default, we use 100 for both. 
dim1=100;
dim2=100;
%number of images from the dataset used to build the eigenspace. Max is
%size(file_struct,1) but not recommended since it will take a long time 
%and because we want to keep some images for our test set later
C=zeros(dim1*dim2,training_set_size);  %matrix to hold all img info
ind=1;
for i=4:training_set_size+3  %this goes through each folder and adds an image to the training matrix (C)
    %read in image and convert to grayscale if necessary
    s=strcat('/Users/parisavaziri/Downloads/CN_exp/lfw-deepfunneled',k(i).name);
    cd(s) 
    file_struct = dir('**/*.jpg'); %struct for all image files
    A=imread(file_struct(1).name);
    %read into Training_Images folder
    s2=strcat('/Users/parisavaziri/Downloads/CN_exp/Training_Images/',num2str(ind),'.jpg');
    imwrite(A, s2);
    if size(A,3) > 1
        I = double(rgb2gray( A ));
    else
        I=double(A);
    end
    I2=imresize(I,[100 100]);
    C(:,ind)=I2(:);
    ind=ind+1;
    cd '/Users/parisavaziri/Downloads/CN_exp/lfw-deepfunneled'
end
save('training')