% Codigo baseado na documenta��o do matlab disponivel nos links a seguir:
% https://www.mathworks.com/help/comm/ref/poly2trellis.html
% https://www.mathworks.com/help/comm/ref/vitdec.html

% AJUSTAR tb!!!

function dem = decodifica_conv_3_4(msgCod)
    tb = 32;
    t.numInputSymbols = 2^3;
    t.numOutputSymbols = 2^4;
    t.numStates  = 2^3;
    t.nextStates = [0  1  2  3  0  1  2  3;
                    6  7  4  5  6  7  4  5;
                    1  0  3  2  1  0  3  2;
                    7  6  5  4  7  6  5  4;
                    2  3  0  1  2  3  0  1;
                    4  5  6  7  4  5  6  7;
                    3  2  1  0  3  2  1  0;
                    5  4  7  6  5  4  7  6];
     outputs =  [0  2  4  6  10  12  14  16;
                 1  3  5  7  11  13  15  17;
                 0  2  4  6  10  12  14  16;
                 1  3  5  7  11  13  15  17;
                 0  2  4  6  10  12  14  16;
                 1  3  5  7  11  13  15  17;
                 0  2  4  6  10  12  14  16;
                 1  3  5  7  11  13  15  17];
    t.outputs = outputs;
    dem = vitdec(msgCod, t, tb, 'trunc', 'unquant');
end