clear
load('training')
%subtract away the mean face to center the data. if you choose to use pca()
%in Matlab this is automatically done
C_norm=C-mean(C,2);
[U,S,~] = svd(C_norm,'econ');  %Run SVD to generate eigenfaces

 
%Keep first n PCs (eigenfaces) and project images into this space
n=1200;
eigenface_mat=U(:,1:n);
%lower dimensional representation using eigenfaces that we'll use to create
%the distance matrices for the different metrics
C_proj = zeros(size(eigenface_mat,2),training_set_size);  
%in general you can project an image (column vector) by taking the dot
%product with each eigenface (which is equivalent to below)
for i = 1 : training_set_size
    C_proj(:,i) = eigenface_mat' * C_norm(:,i);
end
 
%load a set of test images that are not in the training set and then project into the new
%eigenspace to get new coordinates
load('testdata')

TT_norm=TT-mean(TT,2); 
%new coordinates for TT
TT_proj = zeros(size(eigenface_mat,2),test_set_size);  
for i = 1 : test_set_size
    TT_proj(:,i) = eigenface_mat' * TT_norm(:,i);
end

%distance matrices
%the first rank matrix tells you the index of that place in the sorting (so
%the first element in each row tells you the index of the best performing
%(lowest distance) training image
%the second rank matrix tells you the performance of that index training
%image, so the first element in each row tells you how well the first
%training image did against that test image

%L2 (Euclidian)
L2_dist_matrix=pdist2(TT_proj.',C_proj.');
[ranked_L2,L2_rank_matrix]=sort(L2_dist_matrix,2);
L2_rank_matrix2=size(L2_rank_matrix);
for i=1:size(L2_dist_matrix,1)
    temp=L2_dist_matrix(i,:);
    for j=1:size(L2_dist_matrix,2)
        L2_rank_matrix2(i,j)=find(temp(j)==ranked_L2(i,:));
    end
end
%L1
L1_dist_matrix=pdist2(TT_proj.',C_proj.','cityblock');
[ranked_L1,L1_rank_matrix]=sort(L1_dist_matrix,2);
L1_rank_matrix2=size(L1_rank_matrix);
for i=1:size(L1_dist_matrix,1)
    temp=L1_dist_matrix(i,:);
    for j=1:size(L1_dist_matrix,2)
        L1_rank_matrix2(i,j)=find(temp(j)==ranked_L1(i,:));
    end
end
%Linf
Linf_dist_matrix=pdist2(TT_proj.',C_proj.','chebychev');
[ranked_Linf,Linf_rank_matrix]=sort(Linf_dist_matrix,2);
Linf_rank_matrix2=size(Linf_rank_matrix);
for i=1:size(Linf_dist_matrix,1)
    temp=Linf_dist_matrix(i,:);
    for j=1:size(Linf_dist_matrix,2)
        Linf_rank_matrix2(i,j)=find(temp(j)==ranked_Linf(i,:));
    end
end
%cosine
cos_dist_matrix=pdist2(TT_proj.',C_proj.','cosine');
[ranked_cos,cos_rank_matrix]=sort(cos_dist_matrix,2);
cos_rank_matrix2=size(cos_rank_matrix);
for i=1:size(cos_dist_matrix,1)
    temp=cos_dist_matrix(i,:);
    for j=1:size(cos_dist_matrix,2)
        cos_rank_matrix2(i,j)=find(temp(j)==ranked_cos(i,:));
    end
end


% which is the farthest from euclidian?
%calculation for first type of rank matrix
diss_values=[sum(abs(L2_rank_matrix-L1_rank_matrix),'all');  sum(abs(L2_rank_matrix-Linf_rank_matrix),'all'); sum(abs(L2_rank_matrix-cos_rank_matrix),'all')];
diss_values=diss_values./numel(L2_rank_matrix);
%in order from top to bottom: L1, L2, Linf

%calculation for second type of rank matrix
diss_values2=[sum(abs(L2_rank_matrix2-L1_rank_matrix2),'all');  sum(abs(L2_rank_matrix2-Linf_rank_matrix2),'all'); sum(abs(L2_rank_matrix2-cos_rank_matrix2),'all')];
diss_values2=diss_values2./numel(L2_rank_matrix2);




save('Main_results')
 

 