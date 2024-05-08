
%Create figure window
clear
load('Main_results')
%for L2 matrix find 1st, 2nd, 4th, 8th, and 16th best matches in the
%training images for each 100 test images
img_ind=Linf_rank_matrix(:,[1,2,4,8,16]);
%}
%run an experiment, going through each 100 images and recording user
%closeness ratings file_struct(i).name
answers=zeros(100,1);
for i=1:100

    r=randperm(5);
    tiledlayout(2,5,'TileSpacing', 'none');
    nexttile(3)
    s=strcat('/Users/parisavaziri/Downloads/CN_exp/Test_Images/',num2str(i),'.jpg');
    A=imread(s);  %test pic
    imshow(A)

    nexttile
    text(0,0.5, sprintf(' Select which face \n number below is \n closest to the right \n face'),'FontSize', 18)
    Ax = gca;
    Ax.Visible = 0;


    %training pics
    nexttile(6)
    s=strcat('/Users/parisavaziri/Downloads/CN_exp/Training_Images/',num2str(img_ind(i,r(1))),'.jpg');
    A=imread(s);
    imshow(A)
    title('1','FontSize',20)


    nexttile(7)
    s=strcat('/Users/parisavaziri/Downloads/CN_exp/Training_Images/',num2str(img_ind(i,r(2))),'.jpg');
    A=imread(s);
    imshow(A)
    title('2','FontSize',20)

    nexttile(8)
    s=strcat('/Users/parisavaziri/Downloads/CN_exp/Training_Images/',num2str(img_ind(i,r(3))),'.jpg');
    A=imread(s);
    imshow(A)
    title('3','FontSize',20)

    nexttile(9)
    s=strcat('/Users/parisavaziri/Downloads/CN_exp/Training_Images/',num2str(img_ind(i,r(4))),'.jpg');
    A=imread(s);
    imshow(A)
    title('4','FontSize',20)

    nexttile(10)
    s=strcat('/Users/parisavaziri/Downloads/CN_exp/Training_Images/',num2str(img_ind(i,r(5))),'.jpg');
    A=imread(s);
    imshow(A)
    title('5','FontSize',20)
    prompt = "Select the closest face number: ";
    x= input(prompt);
    answers(i,1)= r(x);
    close
end

disp("thank you. the experiment is finished")
 