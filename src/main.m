clear all;
close all;

% Constantes de entrada
nframes = 1;                  % numero de frames simulados
bitsFrame = 1200;             % quantidade de bits em um frame

% Constantes derivadas
nbits = nframes*bitsFrame;    % numero de bits simulados
fprintf('Bits simulados: %d\n', nbits);

% -----------------------------
% Fonte de informacao
msg = fonte(nbits);

% -----------------------------
% Codificador
msgCod_2_3 = codificador(msg, 2/3);
msgCod_3_4 = codificador(msg, 3/4);
% DEBUG:
% fprintf('Bits da msg cod. com CONV R=2/3: %d\n', length(msgCod_2_3));
% fprintf('Num. de bits da msg codificada com CONV R=3/4: %d\n', length(msgCod_3_4));

% -----------------------------
% Modulador
txSig_2_3_16qam = mod_16qam(msgCod_2_3);
txSig_3_4_16qam = mod_16qam(msgCod_3_4);
% TO-DO: mod_qpsk
% txSig_2_3_qpsk = mod_qpsk(msgCod_2_3);
% txSig_3_4_qpsk = mod_qpsk(msgCod_3_4);
% DEBUG:
% fprintf('Simbs mod. com 16-QAM (CONV R=2/3): %d\n', length(txSig_2_3_16qam));
% fprintf('Simbs mod. com 16-QAM (CONV R=3/4): %d\n', length(txSig_3_4_16qam));


% -----------------------------
% Canal AWGN
% TO-DO: canalAWGN (funcao MatLAB: awgn)
% saidaCanal = canalAWGN(mod)
% rxSig_2_3_qpsk = txSig_2_3_qpsk;
% rxSig_3_4_qpsk = txSig_3_4_qpsk;
% TEMP:
rxSig_2_3_16qam = txSig_2_3_16qam;
rxSig_3_4_16qam = txSig_3_4_16qam;

% -----------------------------
% Demodulador
rxCodMsg_2_3_16qam = dem_16qam(rxSig_2_3_16qam);
rxCodMsg_3_4_16qam = dem_16qam(rxSig_3_4_16qam);
% TO-DO: dem_qpsk
% rxCodMsg_2_3_qpsk = dem_qpsk(rxSig_2_3_qpsk);
% rxCodMsg_3_4_qpsk = dem_qpsk(rxSig_3_4_qpsk);
% DEBUG:
% fprintf('Bits demod. com 16-QAM (CONV R=2/3): %d\n', length(rxCodMsg_2_3_16qam));
% fprintf('Bits demod. com 16-QAM (CONV R=3/4): %d\n', length(rxCodMsg_3_4_16qam));

% -----------------------------
% Decodificador
msgDec_3_4_16qam = decodificador(rxCodMsg_3_4_16qam, 3/4);
msgDec_2_3_16qam = decodificador(rxCodMsg_2_3_16qam, 2/3);
% TO-DO:
% msgDec_2_3_qpsk = decodificador(rxCodMsg_2_3_qpsk, 2/3);
% msgDec_3_4_qpsk = decodificador(rxCodMsg_3_4_qpsk, 3/4);
% DEBUG:
% fprintf('Bits decod. com 16-QAM (CONV R=2/3): %d\n', length(msgDec_2_3_16qam));
% fprintf('Bits decod. com 16-QAM (CONV R=3/4): %d\n', length(msgDec_3_4_16qam));

% -----------------------------
% Comparador
fprintf('Transm. correta c/ 16-QAM e CONV R=2/3? %d\n', isequal(msg, msgDec_2_3_16qam));
fprintf('Transm. correta c/ 16-QAM e CONV R=3/4? %d\n', isequal(msg, msgDec_3_4_16qam));
% fprintf('Transm. correta c/ QPSK e CONV R=2/3? %d\n', isequal(msg, msgDec_2_3_qpsk));
% fprintf('Transm. correta c/ QPSK e CONV R=3/4? %d\n', isequal(msg, msgDec_3_4_qpsk));


