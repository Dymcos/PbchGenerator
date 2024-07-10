function out_seq = payloadGeneration_interleaving(in_seq)
%payloadGeneration_interleaving process of interleaving after
    % payload creation [7.1.1, TS 38.212]
    
    arguments
        in_seq (1,:) % sequence of bits
    end

    % initializing
    A = length(in_seq);
    A_ = A-8;
    G = [16 23 18 17 8 30 10 6 24 7 0 5 3 2 1 4 ...
    9 11 12 13 14 15 19 20 21 22 25 26 27 28 29 31]; %TS 38.212 table 7.1.1-1
    jSFN = 0;
    jHRF = 10;
    jSSB = 11;
    jOTHER = 14;
    out_seq = zeros(1,32);
    
    % main procedure
    
    for i=1:A
        if (i >= 2 && i <= 7)||(i >= A_+1 && i <= A_+4) %SFN bits
            out_seq(G(jSFN+1)+1)=in_seq(i);
            jSFN = jSFN+1;
        elseif i == A_+5 %HRF
            out_seq(G(jHRF+1)+1)=in_seq(i);
        elseif i >= A_+6 && i<=A+8 % L_massive
            out_seq(G(jSSB+1)+1)=in_seq(i);
            jSSB = jSSB+1;
        else
            out_seq(G(jOTHER+1)+1)=in_seq(i);
            jOTHER = jOTHER+1;
        end
    end
end