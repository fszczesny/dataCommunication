function rxCodMsg = demodulador(rxSig, EbN0dB, mod, r)
    if (strcmp(mod, '16-QAM'))
        rxCodMsg = dem_16qam(rxSig, EbN0dB, r);
    elseif (strcmp(mod, 'QPSK'))
        rxCodMsg = dem_qpsk(rxSig, EbN0dB, r);
    end
end