clear all;
close all;
% rng 'default';

% Constantes de entrada
nframes = 100;                % numero de frames simulados
bitsFrame = 1500*8;           % quantidade de bits em um frame
minBitErrs = 3000;            % quantidade minima de erros de bit simulados
minBits = 2e7;                % quantidade minima de bits simulados
minFrameErrs = 300;           % quantidade minima de erros de frame simulados
minFrames = 2000;             % quantidade minima de frames simulados

% Constantes derivadas
nbits = nframes*bitsFrame;    % numero de bits simulados

EbN0dB_vec = 0:1:15;

codRate = [2/3,       3/4];   % razoes de codificacao simuladas
modType = {'16-QAM', 'QPSK'}; % tipos de modulacao simulados

z = length(codRate) * length(modType);
ber = zeros(z, length(EbN0dB_vec));
fer = zeros(z, length(EbN0dB_vec));
ferCalc = zeros(z, length(EbN0dB_vec));
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
            numFrameErrs = 0;
            numBits = 0;
            numFrames = 0;
            while (numErrs < minBitErrs && numBits < minBits) || (numFrameErrs < minFrameErrs && numFrames < minFrames)
                rxSig = canalAWGN(txSig, EbN0dB, mod, r);
                rxCodMsg = demodulador(rxSig, EbN0dB, mod, r);
                msgDec = decodificador(rxCodMsg, r);
                
                x = reshape(msg, [nframes, bitsFrame]);
                y = reshape(msgDec, [nframes, bitsFrame]);
                errors = biterr(x, y, [], 'row-wise');
                bitErrors = sum(errors);
                frameErrors = sum(errors > 0);
                
                numErrs = numErrs + bitErrors;
                numFrameErrs = numFrameErrs + frameErrors;
                numBits = numBits + nbits;
                numFrames = numFrames + nframes;
            end
            
            ber(j,i) = numErrs / numBits;
            fer(j,i) = numFrameErrs / numFrames;
            ferCalc(j,i) = 1 - (1 - ber(j,i))^nbits;
            fprintf('BER=%.8f, FERcalc=%.8f, FER=%.8f\n', ber(j,i), ferCalc(j,i), fer(j,i));
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

% Plot FER Medido vs Eb/N0
figure;
semilogy(EbN0dB_vec, fer(1,:), EbN0dB_vec, fer(2,:), ...
    EbN0dB_vec, fer(3,:), EbN0dB_vec, fer(4,:), 'LineWidth', 2);
grid on;
title('Taxa de erro de frame para QPSK e 16-QAM com códigos convolucionais R={2/3,3/4}');
legend(leg);
ylabel('FER Medido');
xlabel('Eb/N0 (dB)');

% Plot FER Calculado vs Eb/N0
figure;
semilogy(EbN0dB_vec, ferCalc(1,:), EbN0dB_vec, ferCalc(2,:), ...
    EbN0dB_vec, ferCalc(3,:), EbN0dB_vec, ferCalc(4,:), 'LineWidth', 2);
grid on;
title('Taxa de erro de frame para QPSK e 16-QAM com códigos convolucionais R={2/3,3/4}');
legend(leg);
ylabel('FER Calculado');
xlabel('Eb/N0 (dB)');

fprintf('Done!\n');
