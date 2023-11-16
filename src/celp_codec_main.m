function [outputSpeech] = celp_codec_main(inputSpeech)
%CELP_CODEC_MAIN The CodeExcited LPC codec
%   The parameters corresponding to CELP can be configured here
%   Frame length (N), Sub-frame length (L) LPC Order (M)
%   Perceptual weighted filter coefficient and Pitch lag range
%   This code and its relevant subroutines are extracted:
%   Sourav Mondal (2020). CELP codec
% (https://www.mathworks.com/matlabcentral/fileexchange/39038-celp-codec)
% MATLAB Central File Exchange.


% input speech argument check
if(nargin ~= 1)
    error('Input speech not detected');
end

N = 20;    % Frame length
L = 5;     % Sub-frame length
M = 16;     % Order of LP analysis
c = 0.9;   % constant parameter for perceptual weighted filter
Pidx = [34 231]; % Pitch lag range

% creating the Gaussian codebook
randn('state',0);
cb = randn(L,1024);

% invoking the CELP codecs
[xhat2, e, k, theta0, P, b] = celp_main(inputSpeech,N,L,M,c,cb,Pidx);
outputSpeech = xhat2;

end