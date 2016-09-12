% Shaun Howard
% EECS 490 Project 1: Image Quantization and Sampling

% read a (nearly) 1024x1024 grayscale image
original_image=imread('proj1fig', 'jpg');
I=original_image;
% get image dimensions
[height,width] = size(I);
% store images and the total number of them
images=[];
n_images=0;
% subsample the image by factors of two until it reaches nearly 32 px wide
while width > 32
    J=downsample(I,2);
    J=downsample(J',2)';
    I=J;
    images=[images,J];
    [height,width] = size(J);
    n_images=n_images+1;
end

i=1;
% build a subplot for about 6 images
while i < n_images
    subplot(3,2,i)
    subimage(images(i))
    i=i+1;
end

i=1;
gray_levels=[256, 16, 4, 2];
quantized_images=[];
I=original_image;
% Quantize gray levels in original image from 256 to 2 in powers of 2
while i < 5
   quantized_image=uint8(mat2gray(I) * (gray_levels(i)));
   quantized_images=[quantized_images, quantized_image];
   i=i+1; 
end

% construct an image pyramid from images array
i=1;
while i < num_images
   p = impyramid(images(i));
   i=i+1; 
end

% average filter and subsample steps
% replace old images
images=[];
I=original_image;
% construct 3x3 avging filter
avg_filter=fspecial('average',[3 3]);
% filter and subsample the image by factors of two until it reaches nearly 32 px wide
while width > 32
    I=imfilter(I,avg_filter);
    J=downsample(I,2);
    J=downsample(J',2)';
    I=J;
    images=[images,J];
    [height,width] = size(J);
end

% construct image pyramid from filtered and subsampled images
i=1;
while i < num_images
   p = impyramid(images(i));
   i=i+1; 
end