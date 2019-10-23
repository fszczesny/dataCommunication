function demMsg = dem_qpsk(rxSig)
    M = 4;  % QPSK
    demodulador = comm.PSKDemodulator(M, 'BitOutput', true, 'DecisionMethod', 'Approximate log-likelihood ratio');
    demMsg = step(demodulador, rxSig);
end