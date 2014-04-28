% A function to apply Multiplicative Gaussian noise to an image.
% Function takes the image as an input and the standard deviation of the Gaussian noise (σ).
% The function outputs the noisy image and also outputs the Total Variance of the noisy image generated by the function.

function [noisyImage, totalVariance] = multGaussNoise (imagePath, sigma)
    img = imread(imagePath);
    img = im2double(img);
    mean = 0;
    gaussNoise = mean + sigma.*randn(size(img));
    noisyImage = img .* (1 + gaussNoise);
 
    last = find(imagePath == '/');
    folder_path = imagePath(1:last(end));
    new_file_name = strcat(folder_path, 'Output_image_', num2str(sigma), '.bmp');
    imwrite(noisyImage, new_file_name);
    
    totalVariance = 0;
    [m,n] = size(noisyImage);
    for i=2:m-1;
        for j=2:n-1;
            for k=-1:1;
                for l=-1:1;
                    totalVariance = totalVariance+((1/9)*(noisyImage(i+k, j+l)-((sum(sum(noisyImage(i-1:i+1, j-1:j+1))) - noisyImage(i,j))/9) )^2);
                end
            end
        end
    end
    
    
    imshow(noisyImage);
end
