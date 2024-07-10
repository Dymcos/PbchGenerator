function out_seq = channelCoding_polarCoding(in_seq)
%channelCoding_polarCoding Procedure of polar coding the sequence with
%attached CRC [TS 38.212, 5.3.1.2]
    arguments
        in_seq (1,:)
    end

    K = 56;
    N = 512;

    Q_0_Nmax = matfile("PbchGenerator\ReliabilityAndPolarCodingSeqIndexes.mat").ReliabilityAndPolarSeqIndexes.';
    j = 1;
    for i = 1:1024
        if Q_0_Nmax(i)<N
            Q_0_N(j) = Q_0_Nmax(i);
            j=j+1;
            if j > N
                break
            end
        end
    end
    
    Q_I_N = Q_0_N((end-K+1):end);

    G_2 = ones(2, 2);
    G_2(1, 2) = 0;
    G_N = G_2;
    for i=1:8
        G_N = kron(G_2, G_N);
    end
    
    k = 0;
    for n = 0:(N-1)
        if ismember(n,Q_I_N)
            u(n+1) = in_seq(k+1);
            k = k+1;
        else
            u(n+1) = 0;
        end
    end

    out_seq = mod(u*G_N,2);
end