% Shaun Howard
% EECS 490 Project 1: Image Quantization and Sampling

% read a (nearly) 1024x1024 grayscale image
original_image=imread('proj1fig', 'jpg');
I=original_image;
% get image dimensions
[height,width] = size(I);
% store images and the total number of them
n_images=6;
figure('name', 'Subsampled by Factors of Two');

% display original image
subplot(3,2,1)
subimage(I)

% subsample the image by factors of two until it reaches nearly 32 px wide
% 512x512 plot
J=downsample(I,2);
ds_1=downsample(J',2)';
subplot(3,2,2)
subimage(ds_1)

% 256x256 plot
J=downsample(ds_1,2);
ds_2=downsample(J',2)';
subplot(3,2,3)
subimage(ds_2)

% 128x128 plot
J=downsample(ds_2,2);
ds_3=downsample(J',2)';
subplot(3,2,4)
subimage(ds_3)

% 64x64 plot
J=downsample(ds_3,2);
ds_4=downsample(J',2)';
subplot(3,2,5)
subimage(ds_4)

% 32x32 plot
J=downsample(ds_4,2);
ds_5=downsample(J',2)';
subplot(3,2,6)
subimage(ds_5)

i=1;
gray_levels=[256, 16, 4, 2];
quantized_images=[];
quantized_maps=[];
I=mat2gray(original_image);
figure('name', 'Gray Levels Reduced by Powers of Two')
% Quantize gray levels in original image from 256 to 2 in powers of 2
while i < 5
   [quantized_image,map32]=gray2ind(I, gray_levels(i));
   subplot(3,2,i)
   subimage(quantized_image,map32)
   i=i+1; 
end

% construct an image pyramid from the downsampled images
py=impyramid(I, 'reduce');
py_1=impyramid(ds_1, 'reduce');
py_2=impyramid(ds_2, 'reduce');
py_3=impyramid(ds_3, 'reduce');
py_4=impyramid(ds_4, 'reduce');
py_5=impyramid(ds_5, 'reduce');
i_cells = {py, py_1, py_2, py_3, py_4, py_5};
% plot with imshowTruesize - true aspect ration is preserved
dim=6;
margins = [0 10];
Handles = imshowTruesize(i_cells,margins,'left');
for iRow = 1:1
   for iCol = 1:dim
      axis(Handles.hSubplot(iRow,iCol),'on')
   end
end

% construct 3x3 avging filter
avg_filter=fspecial('average',[3 3]);

figure('name', 'Images Filtered and Subsampled by Factors of Two');

% display original image
subplot(3,2,1)
subimage(I)

% subsample the image by factors of two until it reaches nearly 32 px wide
% 512x512 plot
I1=imfilter(I,avg_filter);
J=downsample(I1,2);
ds_1=downsample(J',2)';
subplot(3,2,2)
subimage(ds_1)

% 256x256 plot
ds_1=imfilter(ds_1,avg_filter);
J=downsample(ds_1,2);
ds_2=downsample(J',2)';
subplot(3,2,3)
subimage(ds_2)

% 128x128 plot
ds_2=imfilter(ds_2,avg_filter);
J=downsample(ds_2,2);
ds_3=downsample(J',2)';
subplot(3,2,4)
subimage(ds_3)

% 64x64 plot
ds_3=imfilter(ds_3,avg_filter);
J=downsample(ds_3,2);
ds_4=downsample(J',2)';
subplot(3,2,5)
subimage(ds_4)

% 32x32 plot
ds_4=imfilter(ds_4,avg_filter);
J=downsample(ds_4,2);
ds_5=downsample(J',2)';
subplot(3,2,6)
subimage(ds_5)

% construct an image pyramid from the downsampled images
py=impyramid(I, 'reduce');
py_1=impyramid(ds_1, 'reduce');
py_2=impyramid(ds_2, 'reduce');
py_3=impyramid(ds_3, 'reduce');
py_4=impyramid(ds_4, 'reduce');
py_5=impyramid(ds_5, 'reduce');
i_cells = {py, py_1, py_2, py_3, py_4, py_5};
% plot with imshowTruesize - true aspect ration is preserved
dim=6;
margins = [0 10];
Handles = imshowTruesize(i_cells,margins,'left');
for iRow = 1:1
   for iCol = 1:dim
      axis(Handles.hSubplot(iRow,iCol),'on')
   end
end