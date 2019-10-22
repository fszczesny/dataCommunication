function dec = decodificador(msgCod, razao)
    if (razao == 2/3)
        dec = decodifica_conv_2_3(msgCod);
    elseif (razao == 3/4)
        dec = decodifica_conv_3_4(msgCod);
    end
end