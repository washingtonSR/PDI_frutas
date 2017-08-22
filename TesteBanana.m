function banana = TesteBanana(posicao, imB, Nim)
  isYellow=false;
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
    endif
    if(X < size(imB,1))
      tambaixo ++;
      X++;
    endif
  until(imB(X,Y) == 0 || X == size(imB,1))
  
  largura = tamesq+tamdir;
  altura = tambaixo+tamdcima;
  
  tamDiagEsqInf = 0;
  tamDiagDirSup = 0;
  tamDiagEsqSup = 0;
  tamDiagDirInf = 0;
  
  X = uint16(posicao(2));
  Y = uint16(posicao(1));
  #Percorre na diagonal esquerda inferior
  do
    if(Y < size(imB,2) && X < size(imB,1))
      Y++;
      X++;
    endif
    tamDiagEsqInf ++;
  until(imB(X,Y)==0 || (X == size(imB,1) || Y == size(imB,2)))
  
  X = uint16(posicao(2));
  Y = uint16(posicao(1));
  #Percorre na diagonal direita superior
  do
    Y--;
    X--;
    tamDiagDirSup ++;
  until(imB(X,Y)==0 || (X == 1 || Y == 1))
  
  X = uint16(posicao(2));
  Y = uint16(posicao(1));
  #Percorre na diagonal esquerda superior
  do
    if(Y < size(imB,2) && X>1)
    Y++;
    X--;
    endif
    tamDiagEsqSup ++;
  until(imB(X,Y)==0 || (X == 1 || Y == size(imB,2)))
  
  X = uint16(posicao(2));
  Y = uint16(posicao(1));
  #Percorre na diagonal direita inferior
  do
    if(X < size(imB,1) && Y > 1)
      Y--;
      X++;
    endif
    tamDiagDirInf ++;
  until(imB(X,Y)==0 || (X == size(imB,1) || Y == 1))
  
  larguraDiag = tamDiagEsqInf + tamDiagDirSup;
  alturaDiag = tamDiagEsqSup + tamDiagDirInf;
  
  if(larguraDiag > largura)
    largura = larguraDiag;
    altura = alturaDiag;
  endif
  if(alturaDiag > altura+altura*0.1)
    altura = alturaDiag;
    largura = larguraDiag;
  endif
  
  #Se a altura for menor que metade da largura OU largura for menor que metade da altura
  #é uma banana "em pé" ou "deitado"
  if(altura <= largura / 2 && isYellow)
    banana = true;
  else if(largura <= altura/2 && isYellow)
    banana = true;
  else
    banana = false;
   endif
end