pkg load image
close all
clear all
clc
nBananas = 0;
nMaracuja = 0;
nMaca = 0;
nLaranja = 0;
nLimao = 0;

%Esse for percorre as imagens da pasta uma a uma
for(index = 1 : 99)
  diretorio = 'banco_imagens/';
  str01 = '00';
  str02 = num2str(index,'%.2d');
  str03 = '.jpg';
  aux = [str01 str02];
  diretorio = [diretorio aux];
  caminho = [diretorio str03];
  im = imread(caminho);
  %----------------------
  R = im(:,:,1);
  B = im(:,:,3);
  im2 = B-R;  
  
  his = imhist(im2);
  max2 = 0;
  indiceMaior = 0;
  
  for i=2:256
    
    if(his(i)>max2)
    
      max2 = his(i);
      indiceMaior = i;
    endif
  endfor

  max2 = 0;
  indiceMaior = 0;
  for i=2:256
    
    if(his(i)>max2)
    
      max2 = his(i);
      indiceMaior = i;
    endif
  endfor

  min1 = max(his);
  indiceMenor = 0;
  
  for i=2:indiceMaior
    
    if(his(i) < min1)
    
      min1 = his(i);
      indiceMenor = i;
    endif
  endfor

  Bim = ~(im2>indiceMenor);
  Nim = zeros(size(im,1),size(im,2),3, 'uint8');
  Nim = im.*Bim;
 
  
  %----------------------------------
  %bim_erod = Erodir(Bim);           #Adicionar Erosão
  %pos = encontrarCentros(bim_erod);
  %----------------------------------
  pos = encontrarCentros(Bim);
  %Esse for identifica os elementos da imagem e os adiciona a matriz M
  for i=1:size(pos,1)
    coordenadas = uint16(pos(i).Centroid);
    Y = uint16(coordenadas(1));
    X = uint16(coordenadas(2));
    
    %Sai testando uma por uma
    if(TesteBanana(coordenadas, Bim, Nim))
      nBananas ++;
    elseif(TesteMaca(coordenadas, Bim, Nim))
      nMaca ++;
    elseif(TesteMaracuja(coordenadas, Bim, Nim))
      nMaracuja ++;    
    %elseif(TesteLaranja(coordenadas,Bim, Nim))
    %  nLaranja ++;
    %elseif(TesteLimao(coordenadas,Bim, Nim))
    %  nLimao ++; 
    endif
  endfor
  M(index,1)=index;
  M(index,2)=nBananas;
  M(index,3)=nMaca;
  M(index,4)=nMaracuja;
  %M(index,4)=nLaranja;
  %M(index,5)=nLimao;
  
  nBananas=0;
  nMaca=0;
  nMaracuja=0;
  %nLaranja=0;
  %nLimao=0;
endfor
%m
dlmwrite("resultados.txt",M,';',"newline","\n");