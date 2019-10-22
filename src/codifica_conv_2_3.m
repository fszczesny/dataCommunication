% Codigo baseado na documentação do matlab disponivel nos links a seguir:
% https://www.mathworks.com/help/comm/ref/poly2trellis.html
% https://www.mathworks.com/help/comm/ref/convenc.html

function codifica_conv_2_3 = codifica_conv_2_3(mensagemBinaria)
    trellis1 = poly2trellis([5 4],[23 35 0; 0 5 13]);
    codigoCalculado = convenc(mensagemBinaria,trellis1);
    codifica_conv_2_3 = codigoCalculado;
end

