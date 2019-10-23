function txSig = mod_16qam(msgCod)
    M = 16; % 16-QAM
    modulador = comm.RectangularQAMModulator(M, 'BitInput', true);
    txSig = step(modulador, msgCod);
end