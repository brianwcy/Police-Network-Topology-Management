function fit = fitness(serial,wcom,uav_islink)
fit=0;

    [ni1,nf1]=prufer_decod(serial);
    
    [len_ni1,~]=size(ni1);
    for i=1:len_ni1

            fit=fit+wcom(ni1(i),nf1(i));

 
    end

end

