function demMsg = dem_16qam(rxSig)
    M = 16;
    demodulador = comm.RectangularQAMDemodulator(M,'BitOutput',true,'DecisionMethod','Approximate log-likelihood ratio');
    demMsg = step(demodulador, rxSig);
end