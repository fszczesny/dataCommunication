function txSig = modulador(msgCod, mod)
    if (strcmp(mod, '16-QAM'))
        txSig = mod_16qam(msgCod);
    elseif (strcmp(mod, 'QPSK'))
        txSig = mod_qpsk(msgCod);
    end
end