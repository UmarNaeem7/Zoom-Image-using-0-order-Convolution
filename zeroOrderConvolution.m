function [f] = zeroOrderConvolution(image,row,col,height,width)
%Zoom image using zero order convolution
%   Detailed explanation goes here
a = image;
[p, q, s] = size(a);
if s==1
    mask = ones(2, 2);
    r = row;    c = col;
    m = 2*width+1;  n = 2*height+1;
    b = zeros(n, m);
    d = b;
    zoom = a(r:r+height-1, c:c+width-1);

    %place the extracted portion in mask properly
    b(2:2:end-1, 2:2:end-1) = zoom(1:end, 1:end);
    
    %apply convolution
    for i=1:n-1
        for j=1:m-1
            mul = b(i:i+1, j:j+1);
            temp = dot(mask, mul);
            %get scalar dot products
            sum = temp(1, 1) + temp(1, 2);
            %place the scalars in new matrix
            d(i, j) = sum;
        end
    end
    
    %remove padding
    e = d(2:end-1, 2:end-1);
    
    %normalize image
    f = uint8(e);
    
else
    %create convolution mask for 1st order hold
    mask = ones(2, 2, 3);
    
    %calculate row and col count of ending point of zoom from
    %width and height
    r = 95;    c = 96;
    width = 36;  height = 36;
    m = 2*width+1;  n = 2*height+1;
    
    %initialize mask of right size
    b = zeros(n, m, 3);
    d = b;
    
    %extract portion of image to be zoomed
    zoom = a(r:r+height-1, c:c+width-1, :);
    
    %place the extracted portion in mask properly
    b(2:2:end-1, 2:2:end-1, :) = zoom(1:end, 1:end, :);
    
    %apply convolution
    for i=1:n-1
        for j=1:m-1
            mul = b(i:i+1, j:j+1, :);
            temp = dot(mask, mul);
            %get scalar dot products
            sum1 = temp(1, 1, 1) + temp(1, 2, 1);
            sum2 = temp(1, 1, 2) + temp(1, 2, 2);
            sum3 = temp(1, 1, 3) + temp(1, 2, 3);
            %place the scalars in new matrix
            d(i, j, 1) = sum1;
            d(i, j, 2) = sum2;
            d(i, j, 3) = sum3;
        end
    end
    
    %remove padding
    e = d(2:end-1, 2:end-1, :);
    
    %normalize image
    f = uint8(e);
    
end

end

