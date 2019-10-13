clear all;
close all;

% Constantes e definicoes
    numeroDeBits = 12000;   % Quantidade de bits simulados 1500bytes * 8bits por byte


% FONTE DE INFORMAÇÃO
    % Cria vetor de mensagem com numeros complexos
    mensagemComplexa = complex(2*randi(2, 1, numeroDeBits)-3, 0); % Vetor complexo com parte real {-1, 1} e parte imaginaria = 0
    % Converte a mensagem complexa em binaria zerando parte negativa
    mensagemBinaria = sign(real(mensagemComplexa));                                            
    mensagemBinaria(mensagemBinaria == -1) = 0;