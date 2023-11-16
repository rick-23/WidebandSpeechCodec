function [outputSpeech] = lpc_codec_main(inputSpeech)
% Speech Codec using Linear Predictive Coding (LPC)
% The order of LPC can be configurable by modifying the lpc_order variable
% For the excitation impulse-trains are used. 
% Output has poor speech quality but this solution achieves a low bitrate!
if(nargin ~= 1)
    error('Input speech not detected');
end

% Sampling Frequency
wideband_Fs = 16000;
% Order of Linear Prediction 
lpc_order = 10;

% LPC encoding
[lpcCoeff, residue, pitch, Gain, parcor, stream] = lpc_encoder(inputSpeech, wideband_Fs, lpc_order); 
% LPC decodig
outputSpeech = lpc_decoder(lpcCoeff, pitch, wideband_Fs, Gain);

end