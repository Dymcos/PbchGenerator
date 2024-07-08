function out_seq = payloadGeneration_interleaving(in_seq)
%payloadGeneration_interleaving process of interleaving after
    % MIB extracting [7.1.1, TS 38.212]
    
    arguments
        in_seq (1,:) % sequence of bits
    end

    % initializing
    A = length(in_seq);
    A_ = A-8;
    INTERLEAVING_PATTERN = [16 23 18 17 8 30 10 6 24 7 0 5 3 2 1 4 ...
    9 11 12 13 14 15 19 20 21 22 25 26 27 28 29 31]; %TS 38.212 table 7.1.1-1
    jSFN = 0;
    jHRF = 10;
    jSSB = 11;
    jOTHER = 14;
    out_seq = zeros(1,32);
    
    % main procedure
    
    for i=1:A
        if (i >= 2 && i <= 7)||(i >= A_+1 && i <= A_+4) %SFN bits
            out_seq(INTERLEAVING_PATTERN(jSFN+1)+1)=a(i);
            jSFN = jSFN+1;
        elseif i == A_+5 %HRF
            out_seq(INTERLEAVING_PATTERN(jHRF+1)+1)=a(i);
        elseif i >= A_+6 && i<=A+8 % L_massive
            out_seq(INTERLEAVING_PATTERN(jSSB+1)+1)=a(i);
            jSSB = jSSB+1;
        else
            out_seq(INTERLEAVING_PATTERN(jOTHER+1)+1)=a(i);
            jOTHER = jOTHER+1;
        end
    end
end