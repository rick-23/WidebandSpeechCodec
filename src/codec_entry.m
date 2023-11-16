clc;
clear all;

speechFile = 'test.wav';
[inputSpeech, Fs] = audioread(speechFile);

% LPC Vocoder
output = lpc_codec_main(inputSpeech);
% Voice excited LPC Vocoder
voiceExcited_output = voiceExcited_lpcEncoder(inputSpeech);
% Code excited LPC Vocoder
celp_output = celp_codec_main(inputSpeech);

% display the results
figure(1);
subplot(4,1,1);
plot(inputSpeech);
xlabel('time'); ylabel('Amplitude');
title('The original speech signal');
subplot(4,1,2);
plot(output);
xlabel('time'); ylabel('Amplitude');
title('LPC Codec output');
subplot(4,1,3);
plot(voiceExcited_output);
xlabel('time'); ylabel('Amplitude');
title('Voice excited LPC Codec output');
subplot(4,1,4);
plot(celp_output);
xlabel('time'); ylabel('Amplitude');
title('Code excited LPC Codec output');

disp('Press any key to play the input signal');
pause;
soundsc(inputSpeech, Fs);

disp('Press any key to play the LPC compressed sound!');
pause;
soundsc(output, 16000);

disp('Press any key to play the voice-excited LPC compressed sound!');
pause;
soundsc(voiceExcited_output, 16000);

disp('Press any key to play the code-excited LPC compressed sound!');
pause;
soundsc(celp_output, 16000);