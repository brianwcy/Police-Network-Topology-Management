function sequence=prufer_encod(ni,nf)
n=max(max(ni),max(nf));
lmax=length(ni);
sequence=zeros(n-2,1);
   for ii=1:n-2 
       deg=call_deg(ni,nf,lmax,n);
       deg_t=find(deg==1);
       vert=deg_t(1);
       [sequence(ii),br]=find_inc(ni,nf,vert); 
       ni(br)=[]; nf(br)=[];
   end
end