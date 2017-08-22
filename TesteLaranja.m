function laranja = TesteLaranja(posicao, imB, Nim)
  isGreen=false;
  intensidade_vermelho=70;
  intensidade_verde=170;
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
    if(Nim(X,Y,1)<= intensidade_vermelho && Nim(X,Y,2)>=intensidade_verde)
      isGreen=true;
    endif
    tamesq ++;
    Y++;
  until(imB(X,Y) == 0)
  #Reseta a posição para proximo teste
  Y = uint16(posicao(1));
  #percorre pixel do centro da massa do objeto ate chegar no limite dela do outro lado
  #na direção horizontal esq/dir
  do
    if(Nim(X,Y,1)<= intensidade_vermelho && Nim(X,Y,2)>=intensidade_verde)
      isGreen=true;
    endif
    tamdir ++;
    Y--;
  until(imB(X,Y) == 0)
  #Reseta
  Y = uint16(posicao(1));
  #percorre pixel do centro da massa do objeto ate chegar no limite dela
  #na direção vertical cima/baixo
  do
    if(Nim(X,Y,1)<= intensidade_vermelho && Nim(X,Y,2)>=intensidade_verde)
      isGreen=true;
    endif
    tamdcima ++;
    X--;
  until(imB(X,Y) == 0)
  #Reseta posição
  X = uint16(posicao(2));
  #percorre pixel do centro da massa do objeto ate chegar no limite dela
  #na direção vertical cima/baixo  
  do
    if(Nim(X,Y,1)<= intensidade_vermelho && Nim(X,Y,2)>=intensidade_verde)
      isGreen=true;
    endif
    tambaixo ++;
    X++;
  until(imB(X,Y) == 0)
  
  largura = tamesq+tamdir;
  altura = tambaixo+tamdcima;
  #Se a altura e largura tiverem valores proximos entao possue um formato quadrado
  #é uma Laranja
  if(altura-largura < 150 && isGreen)
    laranja = true;
  else if(largura-altura <150 && isGreen)
    laranja = true;
  else
    laranja = false;
  endif
end