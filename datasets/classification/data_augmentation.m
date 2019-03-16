for i = 1:399
    img_orig = imread(strcat(int2str(i),'.jpg'));
    
    img_aug = fliplr(img_orig);
    imwrite(img_aug, strcat(int2str(i+400),'.jpg'));
end