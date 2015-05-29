function Qualite=PNSR_grayscale(ImRef,ImDis)
ImRef=double(ImRef);
ImDis=double(ImDis);
if (mean2((ImRef-ImDis).^2)~=0)
    x=max(max(ImRef))^2;
    Qualite=10*log10(x/mean2((ImRef-ImDis).^2));
else 
    
    Qualite=0;
end;

return
