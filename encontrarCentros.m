function posicaoMassas = encontrarCentros(imB)
  
  #encontra os centro de massa
  prop = regionprops(imB,'Centroid');
  #retorna o conjunto de posi�oes de centro de massa
  posicaoMassas = prop;
  
end