function [collage,M, N] = hybrid_collage2(img1, img2)

M = size(img1, 1);
N = int16(size(img1, 2) * 0.3); %int16(size(img1, 2) * 0.3);


[low_filter, high_filter]= butterworth(M, N);
 



im1 = img1(1:M, size(img1, 2)-N+1:size(img1, 2), :);
im2 = img2(1:M, 1:N, :);
% figure;
% subplot 121;imshow(im1);subplot 122;imshow(img1);
% figure;
% subplot 121;imshow(im2);subplot 122;imshow(img2);
% figure;
low_freq = fourier_operation(im1, low_filter);
high_freq = fourier_operation(im2, high_filter);


hybrid_image = real(low_freq) + real(high_freq);

        
for i = 1:size(hybrid_image, 1)
    for j = 1:size(hybrid_image, 2)
        alpha = j/double(size(hybrid_image, 2));
        hybrid_image(i, j, :) = (alpha)*hybrid_image(i, j, :) + (1-alpha)*im1(i, j, :);
    end
    
    for j = 1:size(hybrid_image, 2) % floor(size(hybrid_image, 2)/2):size(hybrid_image, 2)
        alpha = j/double(size(hybrid_image, 2));
        hybrid_image(i, j, :) = (1-alpha)*hybrid_image(i, j, :) + alpha*im2(i, j, :);
    end
    
end

collage = hybrid_image;





% figure;
% subplot 131;imshow(grad1);subplot 132;imshow(grad2);subplot 133;imshow(grad3);
% figure;


collage = zeros(size(img1, 1), 2*size(img1, 2)-N, 3);
collage(1:size(img1, 1), 1:size(img1, 2), :) = img1;

collage(1:size(img1, 1), size(img1, 2)-N+1:size(collage, 2), :) = img2;

collage(1:size(img1, 1), size(img1, 2)-N+1:size(img1, 2), :) = hybrid_image;
% collage(1:size(img1, 1), 1:size(img1, 2), 2) = img1(:, :, 2);
% collage(1:size(img1, 1), 1:size(img1, 2), 3) = img1(:, :, 3);

collage = uint8(collage);




end
