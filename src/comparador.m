function [BER, FER, FERCalc] = comparador(msg, msgDec, nframes)
    nbits = length(msg);
    bitsPerFrame = nbits / nframes;
    x = reshape(msg, [nframes, bitsPerFrame]);
    y = reshape(msgDec, [nframes, bitsPerFrame]);
    errors = biterr(x, y, [], 'row-wise');
    bitErrors = sum(errors);
    frameErrors = sum(errors > 0);
    BER = bitErrors / nbits;
    FER = frameErrors / nframes;
    FERCalc = 1 - (1 - BER)^bitsPerFrame;
end