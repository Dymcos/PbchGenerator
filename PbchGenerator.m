classdef PbchGenerator
    %PbchGenerator Procedure of PBCH bit string generation
    %   [TS 38.212, 7.1]

    methods (Static)
        
        function bitSequence = generatePbch(MIB,SFN,HRF, SSB_Bits, NCellId, Lmax_)
            arguments
                MIB (1,24) % MIB binary sequence (MSB to LSB)
                SFN (1,1) % system frame number positive integer (0...1023)
                HRF (1,1) % half frame bit
                SSB_Bits (1,3) % [<MSB of Kssb> 0 0] if Lmax_ = 4|8 
                % or [<6th bit> <5th bit> <4th bit>] of candidate SS/PBCH block index if Lmax_ = 64
                NCellId (1,1) % cell identificator (0...1007)
                Lmax_ (1,1) % = 4|8|64 maximum number of candidate SS/PBCH blocks in half frame [4.1, TS 38.213]

            end
            bitSequence = PbchGenerator.payloadGeneration(MIB,SFN,HRF, SSB_Bits);
            bitSequence = PbchGenerator.scrambling(bitSequence,NCellId,Lmax_);
            bitSequence = PbchGenerator.crcAttachment(bitSequence);
            bitSequence = PbchGenerator.channelCoding(bitSequence);
            bitSequence = PbchGenerator.rateMatching(bitSequence);       
        end
    
        function out_seq = payloadGeneration(MIB,SFN,HRF, SSB_Bits)
            out_seq = payloadGeneration_payloadInitialization(MIB,SFN,HRF, SSB_Bits);
            out_seq = payloadGeneration_interleaving(out_seq);
        end

        function out_seq = scrambling(in_seq,NCellId,Lmax_)
            out_seq = scrambling(in_seq,NCellId,Lmax_);
        end

        function out_seq = crcAttachment(in_seq)
            out_seq = AttachParityBits(in_seq,'crc24c');
        end

        function out_seq = channelCoding(in_seq)
            in_seq = channelCoding_interleaving(in_seq);
            out_seq = channelCoding_polarCoding(in_seq);
        end

        function out_seq = rateMatching(in_seq)
            in_seq = rateMatching_subBlockInterleaving(in_seq);
            out_seq = rateMatching_bitSelection(in_seq);
        end

    end
end