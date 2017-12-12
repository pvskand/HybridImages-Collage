function image = fourier_operation(img1, filter)

    F=fft2(double(img1));
    F = fftshift(F);
    [M N x] = size(img1);

   

    lowpass(:, :, 1) = filter .* F(:, :, 1);
    lowpass(:, :, 2) = filter  .* F(:, :, 2);
    lowpass(:, :, 3) = filter .* F(:, :, 3);


    lowpass = ifftshift(lowpass);

    I = ifft2(lowpass);
    
    image = uint8(I);


end
