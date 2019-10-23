function txSig = mod_qpsk(msgCod)
    M = 4; % QPSK
    modulador = comm.PSKModulator(M, ...
        'BitInput', true, ...
        'PhaseOffset', pi/4);
    % constellation(modulador)
    txSig = step(modulador, msgCod);
end