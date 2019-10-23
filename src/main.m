clear all;
close all;
rng 'default';

% Constantes de entrada
nframes = 1;                  % numero de frames simulados
bitsFrame = 1200;             % quantidade de bits em um frame

% ============================================================
% Constantes derivadas
nbits = nframes*bitsFrame;    % numero de bits simulados
EbN0dB = 10;
% DEBUG:
% fprintf('Bits simulados: %d\n', nbits);

% -----------------------------
% Fonte de informacao
msg = fonte(nbits);
% DEBUG:
% fprintf('Bits da msg original: %d\n', length(msg));

% -----------------------------
% Codificador
msgCod_2_3 = codificador(msg, 2/3);
msgCod_3_4 = codificador(msg, 3/4);
% DEBUG:
% fprintf('Bits da msg cod. com CONV R=2/3: %d\n', length(msgCod_2_3));
% fprintf('Bits da msg cod. com CONV R=3/4: %d\n', length(msgCod_3_4));

% -----------------------------
% Modulador
txSig_2_3_16qam = modulador(msgCod_2_3, '16-QAM');
txSig_3_4_16qam = modulador(msgCod_3_4, '16-QAM');
txSig_2_3_qpsk = modulador(msgCod_2_3, 'QPSK');
txSig_3_4_qpsk = modulador(msgCod_3_4, 'QPSK');
% DEBUG:
% fprintf('Simbs mod. com 16-QAM (CONV R=2/3): %d\n', length(txSig_2_3_16qam));
% fprintf('Simbs mod. com 16-QAM (CONV R=3/4): %d\n', length(txSig_3_4_16qam));
% fprintf('Simbs mod. com QPSK (CONV R=2/3): %d\n', length(txSig_2_3_qpsk));
% fprintf('Simbs mod. com QPSK (CONV R=3/4): %d\n', length(txSig_3_4_qpsk));

% -----------------------------
% Canal AWGN
rxSig_2_3_16qam = canalAWGN(txSig_2_3_16qam, EbN0dB, '16-QAM', 2/3);
rxSig_3_4_16qam = canalAWGN(txSig_3_4_16qam, EbN0dB, '16-QAM', 3/4);
rxSig_2_3_qpsk = canalAWGN(txSig_2_3_qpsk, EbN0dB, 'QPSK', 2/3);
rxSig_3_4_qpsk = canalAWGN(txSig_3_4_qpsk, EbN0dB, 'QPSK', 3/4);

% -----------------------------
% Demodulador
rxCodMsg_2_3_16qam = demodulador(rxSig_2_3_16qam, '16-QAM');
rxCodMsg_3_4_16qam = demodulador(rxSig_3_4_16qam, '16-QAM');
rxCodMsg_2_3_qpsk = demodulador(rxSig_2_3_qpsk, 'QPSK');
rxCodMsg_3_4_qpsk = demodulador(rxSig_3_4_qpsk, 'QPSK');
% DEBUG:
% fprintf('Bits demod. com 16-QAM (CONV R=2/3): %d\n', length(rxCodMsg_2_3_16qam));
% fprintf('Bits demod. com 16-QAM (CONV R=3/4): %d\n', length(rxCodMsg_3_4_16qam));
% fprintf('Bits demod. com QPSK (CONV R=2/3): %d\n', length(rxCodMsg_2_3_qpsk));
% fprintf('Bits demod. com QPSK (CONV R=3/4): %d\n', length(rxCodMsg_3_4_qpsk));

% -----------------------------
% Decodificador
msgDec_3_4_16qam = decodificador(rxCodMsg_3_4_16qam, 3/4);
msgDec_2_3_16qam = decodificador(rxCodMsg_2_3_16qam, 2/3);
msgDec_2_3_qpsk = decodificador(rxCodMsg_2_3_qpsk, 2/3);
msgDec_3_4_qpsk = decodificador(rxCodMsg_3_4_qpsk, 3/4);
% DEBUG:
% fprintf('Bits decod. com 16-QAM (CONV R=2/3): %d\n', length(msgDec_2_3_16qam));
% fprintf('Bits decod. com 16-QAM (CONV R=3/4): %d\n', length(msgDec_3_4_16qam));
% fprintf('Bits decod. com QPSK (CONV R=2/3): %d\n', length(msgDec_2_3_qpsk));
% fprintf('Bits decod. com QPSK (CONV R=3/4): %d\n', length(msgDec_3_4_qpsk));

% -----------------------------
% Comparador
fprintf('Transm. correta c/ 16-QAM e CONV R=2/3? %d\n', isequal(msg, msgDec_2_3_16qam));
fprintf('Transm. correta c/ 16-QAM e CONV R=3/4? %d\n', isequal(msg, msgDec_3_4_16qam));
fprintf('Transm. correta c/ QPSK e CONV R=2/3? %d\n', isequal(msg, msgDec_2_3_qpsk));
fprintf('Transm. correta c/ QPSK e CONV R=3/4? %d\n', isequal(msg, msgDec_3_4_qpsk));


