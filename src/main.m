clear all;
close all;
% rng 'default';

% Constantes de entrada
nframes = 1600;               % numero de frames simulados
bitsFrame = 1500*8;           % quantidade de bits em um frame

% ============================================================
% Constantes derivadas
nbits = nframes*bitsFrame;    % numero de bits simulados
% fprintf('Bits simulados: %d\n', nbits);

EbN0dB_vec = 0:1:15;

codRate = [2/3,       3/4];   % razoes de codificacao simuladas
modType = {'16-QAM', 'QPSK'}; % tipos de modulacao simulados

z = length(codRate) * length(modType);
ber = zeros(z, length(EbN0dB_vec));
fer = zeros(z, length(EbN0dB_vec));
ferCalc = zeros(z, length(EbN0dB_vec));
leg = cell(1, z);
    
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

    for m = 1:length(modType)
        mod = modType{m};

        j = (c-1) * length(codRate) + m;
        leg{j} = strcat(mod, ' + CONV R=', rfrac);
        fprintf('> (%d/%d) %s - CONV R=%s\n', j, z, mod, rfrac);

        % -----------------------------
        % Modulador
        txSig = modulador(msgCod, mod);

        for i = 1:length(EbN0dB_vec)
            EbN0dB = EbN0dB_vec(i);
            fprintf('>> (%d/%d) EbN0 = %d dB => ', i, length(EbN0dB_vec), EbN0dB);

            % -----------------------------
            % Canal AWGN
            rxSig = canalAWGN(txSig, EbN0dB, mod, r);

            % -----------------------------
            % Demodulador
            rxCodMsg = demodulador(rxSig, EbN0dB, mod, r);

            % -----------------------------
            % Decodificador
            msgDec = decodificador(rxCodMsg, r);

            % -----------------------------
            % Comparador
            [BER, FER, FERCalc] = comparador(msg, msgDec, nframes);
            ber(j,i) = BER;
            fer(j,i) = FER;
            ferCalc(j,i) = FERCalc;
            fprintf('BER = %f, FER = %f, FER (calc) = %f\n', ber(j,i), fer(j,i), ferCalc(j,i));
        end
    end
    fprintf('\n');
end

% Plot BER vs Eb/N0
figure;
semilogy(EbN0dB_vec, ber(1,:), EbN0dB_vec, ber(2,:), ...
    EbN0dB_vec, ber(3,:), EbN0dB_vec, ber(4,:), 'LineWidth', 2);
grid on;
title('Taxa de erros para QPSK e 16-QAM com c�digos convolucionais R={2/3,3/4}');
legend(leg);
ylabel('BER');
xlabel('Eb/N0 (dB)');

% Plot FER vs Eb/N0
figure;
semilogy(EbN0dB_vec, fer(1,:), EbN0dB_vec, fer(2,:), ...
    EbN0dB_vec, fer(3,:), EbN0dB_vec, fer(4,:), 'LineWidth', 2);
grid on;
title('Taxa de erro de frame para QPSK e 16-QAM com c�digos convolucionais R={2/3,3/4}');
legend(leg);
ylabel('FER');
xlabel('Eb/N0 (dB)');

% Plot FER Calculado vs Eb/N0
figure;
semilogy(EbN0dB_vec, ferCalc(1,:), EbN0dB_vec, ferCalc(2,:), ...
    EbN0dB_vec, ferCalc(3,:), EbN0dB_vec, ferCalc(4,:), 'LineWidth', 2);
grid on;
title('Taxa de erro de frame (calculado )para QPSK e 16-QAM com c�digos convolucionais R={2/3,3/4}');
legend(leg);
ylabel('FER Calculado');
xlabel('Eb/N0 (dB)');

fprintf('Done!\n');
