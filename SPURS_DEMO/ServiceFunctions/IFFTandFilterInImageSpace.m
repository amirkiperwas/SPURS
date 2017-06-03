function [uniform_k_samples, OutputImage] = IFFTandFilterInImageSpace(c,ImgFilter,sqrtN,OverGridFactor)

if mod(sqrtN,2)==0
    FOV_idx = round((sqrtN*OverGridFactor)/2-sqrtN/2+1:(sqrtN*OverGridFactor)/2+sqrtN/2);
else    
    FOV_idx = (ceil((sqrtN*OverGridFactor)/2-sqrtN/2)+1:ceil((sqrtN*OverGridFactor)/2+sqrtN/2));
end
IFFT_c = ifftshift(ifft2(fftshift(c)));
OutputImage = (sqrtN*OverGridFactor)^2.*IFFT_c.*abs(ImgFilter);

%calculate k-space samples on the uniform grid
uniform_k_samples = ifftshift(fft2(fftshift(OutputImage)));

% Crop to FOV and returen real Image
OutputImage = OutputImage(FOV_idx,FOV_idx); 
end

