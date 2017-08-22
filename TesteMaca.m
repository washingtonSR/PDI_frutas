function maca = TesteMaca(posicao, imB, Nim)
  isRed=false;
  tamesq = 0;
  tamdir = 0;
  tamdcima = 0;
  tambaixo = 0;
  Y = uint16(posicao(1));
  X = uint16(posicao(2));
  
  #percorre pixel do centro da massa do objeto ate chegar no limite dela
  #na direção horizontal esq/dir 
  do
    if(Nim(X,Y,1)>=150 && Nim(X,Y,2)<=100)
      isRed=true;
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
    if(Nim(X,Y,1)>=150 && Nim(X,Y,2)<=100)
      isRed=true;
    endif
    tamdir ++;
    Y--;
  until(imB(X,Y) == 0 || Y == 1)
  #Reseta
  Y = uint16(posicao(1));
  #percorre pixel do centro da massa do objeto ate chegar no limite dela
  #na direção vertical cima/baixo
  do
    if(Nim(X,Y,1)>=150 && Nim(X,Y,2)<=100)
      isRed=true;
    endif
    tamdcima ++;
    X--;
  until(imB(X,Y) == 0 || X == 1)
  #Reseta posição
  X = uint16(posicao(2));
  #percorre pixel do centro da massa do objeto ate chegar no limite dela
  #na direção vertical cima/baixo  
  do
    if(Nim(X,Y,1)>=150 && Nim(X,Y,2)<=100)
      isRed=true;
    endif
    if(X < size(imB,1))
      tambaixo ++;
      X++;
    endif
  until(imB(X,Y) == 0 || X == size(imB,1))
  
  largura = tamesq+tamdir;
  altura = tambaixo+tamdcima;
  #Se a altura e largura tiverem valores proximos entao possue um formato quadrado
  #é uma maçã
  if(altura-largura < 150 && isRed)
    maca = true;
  else if(largura-altura <150 && isRed)
    maca = true;
  else
    maca = false;
  endif
end