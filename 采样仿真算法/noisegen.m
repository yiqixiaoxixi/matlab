function [y,noise] = noisegen(x,SNR)
% noisegen add white Gaussian noise to a signal.
% [y, noise] = NOISEGEN(x,SNR) adds white Gaussian NOISE to x.  The SNR is in dB.
noise=randn(size(x));
noise=noise-mean(noise);
signal_power = 1/length(x)*sum(x.*x);
noise_variance = signal_power / ( 10^(SNR/10) );
noise=sqrt(noise_variance)/std(noise)*noise;
y=x+noise;
end

