function posicaoMassas = encontrarCentros(imB)
  
  #encontra os centro de massa
  prop = regionprops(imB,'Centroid');
  #retorna o conjunto de posiçoes de centro de massa
  posicaoMassas = prop;
  
end