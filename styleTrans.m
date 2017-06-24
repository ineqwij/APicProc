function target_im = styleTrans(source_im,img,img2)
hiTh = 1.3;
loTh = 0.8;

siTh = 0.02;

%filter
s1 = isSimilar(img,img2);
K1 = img;
kernel = fspecial('gaussian',5,30);
K1(:,:,1)=filter2(kernel,img(:,:,1));
K1(:,:,2)=filter2(kernel,img(:,:,2));
K1(:,:,3)=filter2(kernel,img(:,:,3));
s2 = isSimilar(K1,img2);

if s2 -s1 > siTh
    source_im(:,:,1)=filter2(kernel,source_im(:,:,1));
    source_im(:,:,2)=filter2(kernel,source_im(:,:,2));
    source_im(:,:,3)=filter2(kernel,source_im(:,:,3));
end

%sharpen
imgS = Sharpen(img);
sS = isSimilar(img,img2);
sS2 = isSimilar(imgS,img2);
a = sS2-sS
if abs(sS2-sS) < siTh
    source_im = Sharpen(source_im);
end

%hsv
h = rgb2hsv(img);
h2 = rgb2hsv(img2);
delta_v = mean(mean(h2(:,:,3))) / mean(mean((h(:,:,3))));
delta_s = mean(mean(h2(:,:,2))) / mean(mean((h(:,:,2))));
delta_h = mean(mean(h2(:,:,1))) / mean(mean((h(:,:,1))));

h_s = rgb2hsv(source_im);
h_s(:,:,3) = delta_v * h_s(:,:,3);
h_s(:,:,2) = delta_s * h_s(:,:,2);


if delta_h > hiTh || delta_h < loTh
    source_im = hsv2rgb(h_s);
    s = source_im > 1;
    source_im(s) = 1;
	source_im = source_im * 255;
    target_im = Reinhard(source_im,img,img2);
    s = target_im > 1;
    target_im(s) = 1;
    s = target_im < 0;
    target_im(s) = 0;
	target_im = target_im * 255;
else
    h_s(:,:,1) = delta_h * h_s(:,:,1);
    source_im = hsv2rgb(h_s);
    s = source_im > 1;
    source_im(s) = 1;
    target_im = source_im * 255;
end



      
    