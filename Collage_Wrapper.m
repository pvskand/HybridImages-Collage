clc; clearvars;
addpath Utilities;
n = input('Enter number of images\n');

names = cell(1,n);

for i = 1:n
   fprintf('Enter path of image %d\n', i);
   str = input('','s'); 
   names{i} = str;
end

if n == 2
    img1 = imread(names{1});
    img2 = imread(names{2});
    
    img2 = imresize(img2, [size(img1, 1), size(img1, 2)]);
    
    collage = hybrid_collage2(img1, img2);
end
if n == 3
    img1 = imread(names{1});
    img2 = imread(names{2});
    img3 = imread(names{3});

    
    img2 = imresize(img2, [size(img1, 1), size(img1, 2)]);
    img3 = imresize(img3, [size(img1, 1), size(img1, 2)]);
    
    if round(rand(1)*1) == 1
    collage = hybrid_collage3_rev(img1, img2, img3);
    else
        collage = hybrid_collage3(img1, img2, img3);
    end
end
if n == 5
    img1 = imread(names{1});
    img2 = imread(names{2});
    img3 = imread(names{3});
    img4 = imread(names{4});
    img5 = imread(names{5});
    
    img2 = imresize(img2, [size(img1, 1), size(img1, 2)]);
    img3 = imresize(img3, [size(img1, 1), size(img1, 2)]);
    img4 = imresize(img4, [size(img1, 1), size(img1, 2)]);
    img5 = imresize(img5, [size(img1, 1), size(img1, 2)]);
    
    collage = hybrid_collage5(img1, img2, img3, img4, img5);
end


imshow(collage);

imwrite(collage, 'collage.png')

