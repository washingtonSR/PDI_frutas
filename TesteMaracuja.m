function maracuja = TesteMaracuja(posicao, imB, Nim)
  isYellow=false;
  count=0;
  intensidade_vermelho=150;
  intensidade_verde=200;
  intensidade_azul=0;
  tamesq = 0;
  tamdir = 0;
  tamdcima = 0;
  tambaixo = 0;
  Y = uint16(posicao(1));
  X = uint16(posicao(2));
  
  #percorre pixel do centro da massa do objeto ate chegar no limite dela
  #na direção horizontal esq/dir 
  do
    if(Nim(X,Y,1)>= intensidade_vermelho && Nim(X,Y,2)>=intensidade_verde)
      isYellow=true;
    endif
    if(Y < size(imB,2))
      tamesq ++;
      Y++;
    endif
  until(imB(X,Y) == 0 || Y == size(imB,2))
  #Reseta a posição para proximo teste
  Y = uint16(posicao(1));
  #percorre pixel do centro da massa do objeto ate chegar no limite dela do outro lado
  #na direção horizontal esq/dir
  do
    if(Nim(X,Y,1)>= intensidade_vermelho && Nim(X,Y,2)>=intensidade_verde)
      isYellow=true;
    endif
    tamdir ++;
    Y--;
  until(imB(X,Y) == 0 || Y == 1)
  #Reseta
  Y = uint16(posicao(1));
  #percorre pixel do centro da massa do objeto ate chegar no limite dela
  #na direção vertical cima/baixo
  do
    if(Nim(X,Y,1)>= intensidade_vermelho && Nim(X,Y,2)>=intensidade_verde)
      count++;
      isYellow=true;
    endif
    tamdcima ++;
    X--;
  until(imB(X,Y) == 0 || X == 1)
  #Reseta posição
  X = uint16(posicao(2));
  #percorre pixel do centro da massa do objeto ate chegar no limite dela
  #na direção vertical cima/baixo  
  do
    if(Nim(X,Y,1)>= intensidade_vermelho && Nim(X,Y,2)>=intensidade_verde)
      isYellow=true;
      count++;
    endif
    if(X < size(imB,1))
      tambaixo ++;
      X++;
    endif
  until(imB(X,Y) == 0 || X == size(imB,1))
  
  largura = tamesq+tamdir;
  altura = tambaixo+tamdcima;

  if(count >= tamdcima*0.4)
     maracuja = true;
     chave=true;
  else
     maracuja = false;
     chave=false;
  endif  
  
  if(chave)
    #Se a altura e largura tiverem valores proximos entao possue um formato quadrado
    #é um maracuja
    if(altura-largura < 150 && isYellow)
      maracuja = true;
    else if(largura-altura <150 && isYellow)
      maracuja = true;
    else
      maracuja = false;
    endif
  endif
  
end