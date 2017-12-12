function [collage, M, N] = hybrid_collage3(img1, img2, img3)


[collage, m, n] = hybrid_collage2(img1, img2);

ratio = size(collage, 2)/double(size(img3, 2));


img3 = imresize(img3, [ratio*size(collage, 1), size(collage, 2)]);
M = int16(size(img3, 1) * 0.2);
N = size(img3, 2);



[low_filter, high_filter]= butterworth(M, N);

   


im1 = collage(size(collage, 1)-M+1:size(collage, 1), size(collage, 2)/2-N/2+1:size(collage, 2)/2+N/2, :);
im2 = img3(1:M, 1:N, :);


% figure;
% subplot 121;imshow(im1);subplot 122;imshow(img1);
% figure;
% subplot 121;imshow(im2);subplot 122;imshow(img2);
% figure;
low_freq = fourier_operation(im1, low_filter);
high_freq = fourier_operation(im2, high_filter);
% 
% 
% 
hybrid_image = real(low_freq) + real(high_freq);


for i = 1:size(hybrid_image, 2)
    for j = 1:size(hybrid_image, 1)
        alpha = j/double(size(hybrid_image, 1));
        hybrid_image(j, i, :) = (alpha)*hybrid_image(j, i, :) + (1-alpha)*im1(j, i, :);
    end
    
    for j = 1:size(hybrid_image, 1) % floor(size(hybrid_image, 2)/2):size(hybrid_image, 2)
        alpha = j/double(size(hybrid_image, 1));
        hybrid_image(j, i, :) = (1-alpha)*hybrid_image(j, i, :) + alpha*im2(j, i, :);
    end
    
end

hybrid = uint8(zeros(size(collage, 1)-M+size(img3, 1), size(collage, 2), 3));
hybrid(1:size(collage, 1), 1:size(collage, 2), :) = collage;

hybrid(size(collage, 1)-M+1:size(hybrid, 1), size(hybrid, 2)/2-N/2+1:size(hybrid, 2)/2+N/2, :) = img3;
hybrid(size(collage, 1)-M+1:size(collage, 1), size(collage, 2)/2-N/2+1:size(collage, 2)/2+N/2, :) = hybrid_image;

collage = hybrid;

% collage(1:size(img1, 1), size(img1, 2)-N+1:size(collage, 2), :) = img2;
% 
% collage(1:size(img1, 1), size(img1, 2)-N+1:size(img1, 2), :) = hybrid_image;
% % collage(1:size(img1, 1), 1:size(img1, 2), 2) = img1(:, :, 2);
% % collage(1:size(img1, 1), 1:size(img1, 2), 3) = img1(:, :, 3);
% size(collage)
% collage = uint8(collage);




end
