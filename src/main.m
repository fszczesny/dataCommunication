clear all;
close all;
% rng 'default';

% Constantes de entrada
nframes = 1600;               % numero de frames simulados
bitsFrame = 1500;             % quantidade de bits em um frame
EbN0dB = 5;

% ============================================================
% Constantes derivadas
nbits = nframes*bitsFrame;    % numero de bits simulados
% fprintf('Bits simulados: %d\n', nbits);

codRate = [2/3,       3/4];   % razoes de codificacao simuladas
modType = {'16-QAM', 'QPSK'}; % tipos de modulacao simulados

% -----------------------------
% Fonte de informacao
msg = fonte(nbits);
fprintf('Bits da msg original: %d\n\n', length(msg));

for c = 1:length(codRate)
    r = codRate(c);
    rfrac = strtrim(rats(r));
    
    % -----------------------------
    % Codificador
    msgCod = codificador(msg, r);
    fprintf('> Bits da msg cod. com CONV R=%s: %d\n', rfrac, length(msgCod));

    for m = 1:length(modType)
        mod = modType{m};
        
        % -----------------------------
        % Modulador
        txSig = modulador(msgCod, mod);
        fprintf('>> Simbs mod. com %s (CONV R=%s): %d\n', mod, rfrac, length(txSig));

        % -----------------------------
        % Canal AWGN
        rxSig = canalAWGN(txSig, EbN0dB, mod, r);
        
        % -----------------------------
        % Demodulador
        rxCodMsg = demodulador(rxSig, EbN0dB, mod, r);
        fprintf('>> Bits demod. com %s (CONV R=%s): %d\n', mod, rfrac, length(rxCodMsg));
        
        % -----------------------------
        % Decodificador
        msgDec = decodificador(rxCodMsg, r);
        fprintf('>> Bits decod. com %s (CONV R=%s): %d\n', mod, rfrac, length(msgDec));
        
        % -----------------------------
        % Comparador
        % TO-DO: calcular BER e FER!
        fprintf('>> Transm. correta %s (CONV R=%s)? %s\n\n', mod, rfrac, mat2str(isequal(msg, msgDec)));

    end
end

fprintf('Done!\n');
