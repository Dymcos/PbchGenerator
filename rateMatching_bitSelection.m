function out_seq = rateMatching_bitSelection(in_seq)
%rateMatching_bitSelection Procedure of bit selection for rate
%   matching of PBCH Generator module [TS 38.212 5.4.1.2]
    arguments
        in_seq (1,:); % input sequence
    end
    N = length(in_seq); % length of input sequence    
    E = 864; % lenght of output sequence [TS 38.212, 7.1.5]
    K = 56; % length of output sequence of polar coder
    if E >= N
        out_seq(1:E) = in_seq(mod(0:(E-1),N)+1);
        return
    elseif (K/E) <= (7/16)
        out_seq(1:E) = in_seq(1:E+N-E);
        return
    end
    out_seq(1:E) = in_seq(1:E);
end