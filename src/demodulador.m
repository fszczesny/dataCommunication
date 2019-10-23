function rxCodMsg = demodulador(rxSig, mod)
    if (strcmp(mod, '16-QAM'))
        rxCodMsg = dem_16qam(rxSig);
    elseif (strcmp(mod, 'QPSK'))
        rxCodMsg = dem_qpsk(rxSig);
    end
end