function [res,br]=find_inc(ni,nf,vert)
lmax=length(ni);

    for ii=1:lmax
            if ni(ii)==vert
                 res=nf(ii);br=ii;break;
            end
            if nf(ii)==vert
                 res=ni(ii);br=ii;break;
            end  
    end
end