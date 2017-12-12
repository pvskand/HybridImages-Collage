clc; clearvars;
img1 = imread('ele.png');
img2 = imread('leo.png');
img2 = imresize(img2, [size(img1, 1), size(img1, 2)]);

% img1 = rgb2gray(img1);  
[M N x] = size(img1);
low_filter =zeros(M,N);


d0=150;				%Cutoff Frequency
n=1; 				%Order of butterworth filter

	for i=1:M
    	for j=1:N
        	dist=(i-M/2)^2 + (j-N/2)^2;
        	low_filter(i,j)= ( 1 + (dist/d0)^(2*n))^(-1);
        
    	end
    end


high_filter = 1 - low_filter;    


low_freq = fourier_operation(img1, low_filter);
high_freq = fourier_operation(img2, high_filter);

hybrid_image = real(low_freq) + real(high_freq);

imshow(hybrid_image)
imwrite(hybrid_image, 'full_hybrid.png');

