function [low_filter, high_filter] = butterworth(M, N)


    low_filter =zeros(M,N);

    d0=1000;				%Cutoff Frequency
    n=1; 				%Order of butterworth filter

        for i=1:M
            for j=1:N
                dist=(i-M/2)^2 + (j-N/2)^2;
                low_filter(i,j)= double(( 1 + (dist/d0)^(2*n)))^(-1);

            end
        end
       high_filter = 1 - low_filter; 
        
    d0=150;				%Cutoff Frequency
    n=1; 				%Order of butterworth filter

        for i=1:M
            for j=1:N
                dist=(i-M/2)^2 + (j-N/2)^2;
                low_filter(i,j)= double(( 1 + (dist/d0)^(2*n)))^(-1);

            end
        end    
        
    
%     low_filter = fspecial('gaussian',[3 3],1.9);
%     high_filter = 1 - low_filter;
    

end
