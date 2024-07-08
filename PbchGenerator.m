classdef PbchGenerator
    %PbchGenerator Procedure of PBCH bit string generation
    %   [TS 38.212, 7.1]

    methods (Static)
        
        function bitSequence = PbchGenerator.generatePbch(MIB,LSB_SFN,HRF, L_massive, NCellId, Lmax_)
            arguments
                MIB (1,24) % MIB binary sequence (MSB to LSB)
                LSB_SFN (1,4) % 4 LSB of SFN in order 4th to 1st LSB's
                HRF (1,1) % half frame bit
                L_massive (1,3) % bits 29 to 32 (that depends on Lmax_)
                NCellId (1,1) % cell identificator
                Lmax_ (1,1) % maximum number of candidate SS/PBCH blocks in half frame [4.1, TS 38.213]

            end
            bitSequence = PbchGenerator.payloadGeneration(MIB,LSB_SFN,HRF, L_massive);
            bitSequence = scrambling(bitSequence,NCellId,Lmax_);
            bitSequence = PbchGenerator.crcAttachment(bitSequence);
            bitSequence = PbchGenerator.channelCoding(bitSequence);
            bitSequence = PbchGenerator.rateMatching(bitSequence);       
        end
    
        function out_seq = payloadGeneration()
            out_seq = payloadGeneration_payloadInitialization();
            out_seq = payloadGeneration_interleaving(out_seq);
        end
    
        function out_seq = crcAttachment(in_seq)
            
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