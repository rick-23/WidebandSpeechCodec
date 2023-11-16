function [outputSpeech] = voiceExcited_lpcEncoder(inputSpeech)
% VoiceExcited LPC Encoder 
% Speech Compression using Linear Predictive Coding (LPC)
% The order of LPC coefficients is configurable lpc_order
% For the excitation the residual signal is used. In order to decrease the
% bitrate, the residual signal is discrete cosine transformed and then
% compressed. This means only the first 50 coefficients of the DCT are kept.
% While most of the energy of the signal is stored there, we don't lose a lot
% of information.
% input speech argument check
if(nargin ~= 1)
    error('Input speech not detected');
end

% Sampling Frequency
wideband_Fs = 16000;
% Order of Linear Prediction 
lpc_order = 10;

% LPC encoding
[lpcCoeff, residue, pitch, Gain, parcor, stream] = lpc_encoder(inputSpeech, wideband_Fs, lpc_order); 

% perform a discrete cosine transform on the residual
residue = dct(residue);
[a,b] = size(residue);
% only use the first 50 DCT-coefficients this can be done
% because most of the energy of the signal is conserved in these coeffs
residue = [ residue(1:50,:); zeros(430,b) ];

% quantize the data
residue = uencode(residue,4);
residue = udecode(residue,4);

% perform an inverse DCT
residue = idct(residue);

% add some noise to the signal to make it sound better
noise = [ zeros(50,b); 0.01*randn(430,b) ];
residue = residue + noise;

% decode/synthesize speech using LPC and the compressed residual as excitation
outputSpeech = voiceExcited_lpcDecoder(lpcCoeff, residue, wideband_Fs, Gain);

end

