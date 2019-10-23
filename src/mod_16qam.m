function txSig = mod_16qam(msgCod)
    M = 16; % 16-QAM
    modulador = comm.RectangularQAMModulator(M, ...
        'BitInput', true, ...
        'NormalizationMethod', 'Average power');
    % constellation(modulador)
    txSig = step(modulador, msgCod);
end