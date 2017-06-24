function similarity = isSimilar(picture1,picture2)


t1=rgb2gray(picture1);
[a1,b1]=size(t1);
t2=rgb2gray(picture2);
t2=imresize(t2,[a1 b1],'bicubic');%???????
similarity = corr2(t1,t2);

