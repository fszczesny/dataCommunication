% Codigo baseado na documentação do matlab disponivel nos links a seguir:
% https://www.mathworks.com/help/comm/ref/poly2trellis.html
% https://www.mathworks.com/help/comm/ref/vitdec.html

% MUDAR PARA SOFT!!

function dec = decodifica_conv_2_3(msgCod)
    tb = 8;
    trellis1 = poly2trellis([5 4],[23 35 0; 0 5 13]);
    dec = vitdec(msgCod,trellis1,tb,'trunc','hard');
end

