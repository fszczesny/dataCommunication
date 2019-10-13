clear all;
close all;

% Constantes e definicoes
    numeroDeBits = 12000;   % Quantidade de bits simulados 1500bytes * 8bits por byte

% FONTE DE INFORMAÇÃO + CODIFICAÇÃO DE FONTE
    % Cria vetor de mensagem com numeros complexos
    mensagemComplexa = complex(2*randi(2, 1, numeroDeBits)-3, 0); % Vetor complexo com parte real {-1, 1} e parte imaginaria = 0
    % Converte a mensagem complexa em binaria zerando parte negativa
    mensagemBinaria = sign(real(mensagemComplexa));                                            
    mensagemBinaria(mensagemBinaria == -1) = 0;

% CODIFICADOR DE CANAL - TIPO CONVULACIONAL RAZAO 2/3 E 3/4
    mensagemCodificada_2_3 = codifica_conv_2_3(mensagemBinaria);
    size_2_3 = length(mensagemCodificada_2_3);
    mensagemCodificada_3_4 = codifica_conv_3_4(mensagemBinaria);
    size_3_4 = length(mensagemCodificada_3_4);