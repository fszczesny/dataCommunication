function txSig = mod_qpsk(msgCod)
    modulador = comm.QPSKModulator(...
        'BitInput', true, ...
        'PhaseOffset', pi/4);
    % constellation(modulador)
    txSig = step(modulador, msgCod);
end