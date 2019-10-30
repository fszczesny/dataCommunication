clear all;
close all;
% rng 'default';

% Constantes de entrada
nframes = 1;                  % numero de frames simulados
bitsFrame = 1500*8;           % quantidade de bits em um frame

% Constantes derivadas
nbits = nframes*bitsFrame;    % numero de bits simulados

EbN0dB_vec = 0:1:15;

codRate = [2/3,       3/4];   % razoes de codificacao simuladas
modType = {'16-QAM', 'QPSK'}; % tipos de modulacao simulados

z = length(codRate) * length(modType);
ber = zeros(z, length(EbN0dB_vec));
fer = zeros(z, length(EbN0dB_vec));
leg = cell(1, z);

msg = fonte(nbits);
    
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

        txSig = modulador(msgCod, mod);

        for i = 1:length(EbN0dB_vec)
            EbN0dB = EbN0dB_vec(i);
            fprintf('>> (%d/%d) Eb/N0=%d dB => ', i, length(EbN0dB_vec), EbN0dB);

            numErrs = 0;
            numBits = 0;
            while numErrs < 300 && numBits < 2e7
                rxSig = canalAWGN(txSig, EbN0dB, mod, r);
                rxCodMsg = demodulador(rxSig, EbN0dB, mod, r);
                msgDec = decodificador(rxCodMsg, r);

                nErrors = biterr(msg, msgDec);
                numErrs = numErrs + nErrors;
                numBits = numBits + nbits;
            end
            
            ber(j,i) = numErrs / numBits;
            fer(j,i) = 1 - (1 - ber(j,i))^nbits;
            fprintf('BER = %.8f, FER (calc) = %.8f\n', ber(j,i), fer(j,i));
        end
        fprintf('\n');
    end
end

% Plot BER vs Eb/N0
figure;
semilogy(EbN0dB_vec, ber(1,:), EbN0dB_vec, ber(2,:), ...
    EbN0dB_vec, ber(3,:), EbN0dB_vec, ber(4,:), 'LineWidth', 2);
grid on;
title('Taxa de erros para QPSK e 16-QAM com códigos convolucionais R={2/3,3/4}');
legend(leg);
ylabel('BER');
xlabel('Eb/N0 (dB)');

% Plot FER Calculado vs Eb/N0
figure;
semilogy(EbN0dB_vec, fer(1,:), EbN0dB_vec, fer(2,:), ...
    EbN0dB_vec, fer(3,:), EbN0dB_vec, fer(4,:), 'LineWidth', 2);
grid on;
title('Taxa de erro de frame para QPSK e 16-QAM com códigos convolucionais R={2/3,3/4}');
legend(leg);
ylabel('FER');
xlabel('Eb/N0 (dB)');

fprintf('Done!\n');
