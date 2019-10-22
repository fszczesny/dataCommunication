% Codigo baseado na documentação do matlab disponivel nos links a seguir:
% https://www.mathworks.com/help/comm/ref/poly2trellis.html
% https://www.mathworks.com/help/comm/ref/convenc.html

function cod = codificador(bits, razao)
    if (razao == 2/3)
        cod = codifica_conv_2_3(bits);
    elseif (razao == 3/4)
        cod = codifica_conv_3_4(bits);
    end
end