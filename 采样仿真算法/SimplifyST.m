function [ST]=SimplifyST(h,fs,factor)
M=length(h);
H=[fft(h) fft(h)];
t=[0:floor(M/2)-1 -floor(M/2):-1]/fs;
W=[1 zeros(1,M-1)];
ST=zeros(M/2,M);
for m=0:floor(M/2)-1 
    ST(m+1,:) = ifft(H(m+1:m+M).*W); 
    w = (abs(m+1))^factor/sqrt(2.*pi)*exp(-((m+1)^factor)^2*t.^2/2); 
    W = fft(w/sum(w));
end
end



