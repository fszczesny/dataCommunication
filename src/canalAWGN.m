function rxSig = canalAWGN(txSig, EbN0dB, mod, r)
    k = 0;
    if (strcmp(mod, '16-QAM'))
        k = log2(16);
    elseif (strcmp(mod, 'QPSK'))
        k = log2(4);
    end
    snr_dB = EbN0dB + 10*log10(k * r);
    rxSig = awgn(txSig, snr_dB, 'measured');
end