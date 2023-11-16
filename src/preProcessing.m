function [output_frames] = preProcessing(inputSpeech, fs, frame_length, preemp_coeff)
% This function divides the input signal into frames
% After framing, hamming windowing and pre-emphasis filtering is done

frame_size = round(fs/1000*frame_length);
signal_length = length(inputSpeech);
num_of_frames = floor(signal_length/frame_size);

% Frame splitting

initial_frame_index = 0;
for i = 1 : num_of_frames
    output_frames(i, :) = inputSpeech(initial_frame_index + 1 : initial_frame_index + frame_size);
    
    output_frames(i, :) = output_frames(i, :).* hamming(length(output_frames(i, :)))';
    
    output_frames = filter([1 -preemp_coeff], 1, output_frames(i, :));
    initial_frame_index = initial_frame_index + frame_size;
end

end