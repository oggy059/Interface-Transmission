function PSNR_Value = PSNR_RGB(X,Xhat)

% Read the dimensions of the image.
[rows, columns, ~] = size(X);

% Calculate mean square error of R, G, B.
mseRImage = (double(X(:,:,1)) - double(Xhat(:,:,1))) .^ 2;
mseGImage = (double(X(:,:,2)) - double(Xhat(:,:,2))) .^ 2;
mseBImage = (double(X(:,:,3)) - double(Xhat(:,:,3))) .^ 2;

mseR = sum(sum(mseRImage)) / (rows * columns);
mseG = sum(sum(mseGImage)) / (rows * columns);
mseB = sum(sum(mseBImage)) / (rows * columns);

% Average mean square error of R, G, B.
mse = (mseR + mseG + mseB)/3;

% Calculate PSNR (Peak Signal to noise ratio).
PSNR_Value = 10 * log10( 255^2 / mse);
end
