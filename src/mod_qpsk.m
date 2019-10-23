function txSig = mod_qpsk(msgCod)
    M = 4; % QPSK
    modulador = comm.PSKModulator(M, 'BitInput', true);
    txSig = step(modulador, msgCod);
end