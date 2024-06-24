function [ni,nf]=prufer_decod(S)
n=length(S);
I=1:n+2;ni=zeros(n+1,1);nf=zeros(n+1,1);l=0;
while length(I)>2
for ii=1:length(I)
    if ~ismember(S,I(ii))
        l=l+1;
        ni(l)=I(ii);nf(l)=S(1); I(ii)=[];S(1)=[];
        break;
    end
end
end
ni(end)=I(1);nf(end)=I(2);
end