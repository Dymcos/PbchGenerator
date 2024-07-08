function out_seq = rateMatching_subBlockInterleaving(in_seq)
%rateMatching_subBlockInterleaving Procedure of sub-block interleaving
%   for rate matching of PBCH [TS 38.212, 5.4.1.1]
    arguments
        in_seq (1,:) % input sequence of bits
    end
    N = 512;
    J = zeros(1,N);
    P = [0 1 2 4 3 5 6 7 8 16 9 17 10 18 11 19 12 20 13 21 14 22 15 ...
          23 24 25 26 28 27 29 30 31]; % interleaving pattern
    i = floor(32*(0:(N-1))/N);
    J(1:N)=P(i+1)*N/32+mod(0:(N-1), N/32);
    out_seq(1:N) = in_seq(J(1:N)+1); % main procedure
end