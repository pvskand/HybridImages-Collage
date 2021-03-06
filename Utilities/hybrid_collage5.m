function [collage] = hybrid_collage5(img1, img2, img3, img4, img5)


[collage, M1, N1] = hybrid_collage3(img1, img2, img3);
[collage1, M2, N2] = hybrid_collage3_rev(img4, img5, img3);


M = int16(size(img4, 1) * 0.2);
N = size(img4, 2);







[low_filter, high_filter] = butterworth(M, N);


% 

im1 = collage(size(collage, 1)-M+1:size(collage, 1), 1:N, :); 
im2 = img4(1:M, 1:N, :);

im1_1= collage(size(collage, 1)-M+1:size(collage, 1), size(collage, 2)-N+1:size(collage, 2), :); 
im2_1 = img5(1:M, 1:N, :);



low_freq = fourier_operation(im1, low_filter);
high_freq = fourier_operation(im2, high_filter);

low_freq_1 = fourier_operation(im1_1, low_filter);
high_freq_1 = fourier_operation(im2_1, high_filter);
% 
hybrid_image = real(low_freq) + real(high_freq);
hybrid_image_1 = real(low_freq_1) + real(high_freq_1);



% 

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



hybrid = uint8(zeros(size(collage, 1)-M+size(img4, 1), size(collage, 2), 3));
hybrid(size(collage, 1)-size(img1, 1)+1:size(hybrid, 1), 1:size(collage, 2), :) = collage1;
hybrid(1:size(collage, 1), 1:size(collage, 2), :) = collage;

size(hybrid(size(collage, 1)-M+1:size(hybrid, 1), 1:N, :))
size(hybrid_image_1)
hybrid(size(collage, 1)-M+1:size(collage, 1),1:N, :) = hybrid_image;

hybrid(size(collage, 1)-M+1:size(collage, 1), size(hybrid, 2)-N+1:size(hybrid, 2), :) = hybrid_image_1;




% 
collage = hybrid;





end
