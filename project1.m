% Shaun Howard
% EECS 490 Project 1: Image Quantization and Sampling

% read a 1024x1024 grayscale image
original_image=imread('proj1fig', 'jpg');
I=mat2gray(original_image);
% get image dimensions
[height,width] = size(I);
% store images and the total number of them
n_images=6;
figure('name', 'Subsampled by Factors of Two');
% display original image
margins=[0 0];
subplot_tight(3,2,1, margins);
imshow(I)
image_arr={I};
i=2;
while i <= n_images
    % downsample image rows, columns
    J=downsample(I,2);
    ds=downsample(J',2)';
    image_arr=[image_arr {ds}];
    % display downsampled image
    subplot_tight(3,2,i, margins);
    imshow(ds);
    I=ds;
    i=i+1;
end

i=1;
gray_levels=[256, 16, 4, 2];
quantized_images=[];
quantized_maps=[];
I=mat2gray(original_image);
figure('name', 'Gray Levels Reduced by Powers of Two')
% Quantize gray levels in original image from 256 to 2 in powers of 2
while i < 5
   [quantized_image,map32]=gray2ind(I, gray_levels(i));
   % display quantized images
   subplot_tight(3,2,i, margins)
   subimage(quantized_image,map32)
   i=i+1; 
end

% construct an image pyramid from the downsampled images
i = 1;
pyramid_cells={};
while i <= n_images
    py=impyramid(image_arr{i}, 'reduce');
    pyramid_cells=[pyramid_cells {py}];
    i=i+1;
end

% plot pyramid with imshowTruesize - true aspect ratio is preserved
margins = [0 0];
Handles = imshowTruesize(pyramid_cells,margins,'top');
for iCol = 1:n_images
  axis(Handles.hSubplot(1,iCol),'off')
end

% construct 3x3 avging filter
avg_filter=fspecial('average',[3 3]);

figure('name', 'Images Filtered and Subsampled by Factors of Two');

% display original image
subplot_tight(3,2,1, margins)
imshow(original_image)
I = original_image;
image_arr={I};
i=2;
while i <= n_images
    % average filter image
    I=imfilter(I,avg_filter);
    % downsample image rows and columns
    J=downsample(I,2);
    ds=downsample(J',2)';
    image_arr=[image_arr ds];
    % display downsampled image
    subplot_tight(3,2,i, margins)
    imshow(ds)
    I=ds;
    i=i+1;
end

% construct an image pyramid from the filtered and downsampled images
i = 1;
pyramid_cells={};
while i <= n_images
    py=impyramid(image_arr{i}, 'reduce');
    pyramid_cells=[pyramid_cells {py}];
    i=i+1;
end

% plot with imshowTruesize - true aspect ratio is preserved
margins = [0 0];
Handles = imshowTruesize(pyramid_cells,margins,'top');
for iCol = 1:n_images
  axis(Handles.hSubplot(1,iCol),'off')
end
