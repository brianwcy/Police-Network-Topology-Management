function deg=call_deg(ni,nf,lmax,n)
mat_int=zeros(n,lmax);l=1;
    for jj=1:length(ni)
            mat_int(ni(jj),l)=1;
            mat_int(nf(jj),l)=1;
            l=l+1;
    end
    deg=sum(mat_int');
    deg(~deg) = inf;
end