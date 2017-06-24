function imout = Sharpen(im_s)
% %Roberts       
% [m,n,p]=size(im_s);      
% x=double(im_s);   
% b=zeros(m,n);
% c=zeros(m,n);
% for i=1:m-2   
%      for j=1:n-2 
%          b(i+1,j+1)=x(i,j)-x(i+1,j+1);   
%          c(i+1,j+1)=x(i,j+1)-x(i+1,j);   
%          b(i+1,j+1)=sqrt(b(i+1,j+1)^2+c(i+1,j+1)^2)+100;   
%      end  
% end
% imout = uint8(b);

%l=fspecial('Laplacia',0);
l=[-1,-1,-1;-1,9,-1;-1,-1,-1];
imout=imfilter(im_s,l);