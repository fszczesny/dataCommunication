% Codigo baseado na documentação do matlab disponivel nos links a seguir:
% https://www.mathworks.com/help/comm/ref/poly2trellis.html
% https://www.mathworks.com/help/comm/ref/vitdec.html

% AJUSTAR tb!!!

function dec = decodifica_conv_2_3(msgCod)
    tb = 32;
    t = poly2trellis([5 4],[23 35 0; 0 5 13]);
    % Decodificacao SOFT
    dec = vitdec(msgCod,t,tb,'trunc','unquant');
end

