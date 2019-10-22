clear all;
close all;

% Constantes de entrada
nframes = 1;                  % numero de frames simulados
bitsFrame = 1200;             % quantidade de bits em um frame

% Constantes derivadas
nbits = nframes*bitsFrame;    % numero de bits simulados
nbits

% -----------------------------
% Fonte de informacao
msg = fonte(nbits);

% -----------------------------
% Codificador
% msgCod_2_3 = codificador(msg, 2/3);
% length(msgCod_2_3);
msgCod_3_4 = codificador(msg, 3/4);
length(msgCod_3_4);

% -----------------------------
% Modulador
% modQPSK = mod_qpsk(msgCod)
% mod16QAM = mod_16qam(msgCod)

% -----------------------------
% Canal AWGN
% saidaCanal = canalAWGN(mod)

% -----------------------------
% Demodulador
% dem = dem_qpsk(saidaCanal)

% -----------------------------
% Decodificador
% msgDec_2_3 = decodificador(msgCod_2_3, 2/3);
% length(msgDec_2_3)
msgDec_3_4 = decodificador(msgCod_3_4, 3/4);
length(msgDec_3_4)

% -----------------------------
% Comparador
%isequal(msg, msgDec_2_3)
isequal(msg, msgDec_3_4)



