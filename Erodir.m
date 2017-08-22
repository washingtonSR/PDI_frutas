function bim_erod = Erodir(Bim)
  bim_erod=Bim; 
  filtro = [1,1,1;...
          1,1,1;...
          1,1,1];
  for a=0:2
    for i=2:size(Bim,1)-1
      for j=2:size(Bim,2)-1
      
        if(Bim(i,j) == 1)
           
        imerosao  = [Bim(i-1,j-1),Bim(i-1,j),Bim(i-1,j+1);...
                      Bim(i,j-1),Bim(i,j),Bim(i,j+1);...
                      Bim(i+1,j-1),Bim(i+1,j),Bim(i+1,j+1)]; 
                    
          if((sum(sum(imerosao==filtro)))!=9)         
              bim_erod(i,j)=0;
          endif
        endif
      endfor
    endfor
  endfor
end