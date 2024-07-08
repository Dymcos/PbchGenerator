function out_seq = payloadGeneration_payloadInitialization(MIB,LSB_SFN,HRF, L_massive)
%payloadGeneration_payloadInitialization Summary of this function goes here
%   Detailed explanation goes here
    arguments
    MIB (1,24)
    LSB_SFN (1,4) % 4 LSB of SFN in order 4th to 1st LSB
    HRF (1,1)
    L_massive (1,3) % depends on Lmax_
    end

    out_seq = [MIB LSB_SFN HRF L_massive];
end