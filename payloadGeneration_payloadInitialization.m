function out_seq = payloadGeneration_payloadInitialization(MIB,SFN,HRF, SSB_Bits)
%payloadGeneration_payloadInitialization Summary of this function goes here
%   Detailed explanation goes here
    arguments
    MIB (1,24)
    SFN (1,1) % system frame number positive integer 
    HRF (1,1) % half frame bit
    SSB_Bits (1,3) % [<MSB of Kssb> 0 0] if Lmax_ =4|8 
    % or [<6th bit> <5th bit> <4th bit>] of candidate SS/PBCH block index if Lmax_ = 64
    end
    binSFN = decimalToBinaryVector(SFN);
    out_seq = [MIB binSFN((end-3):end) HRF SSB_Bits];
end