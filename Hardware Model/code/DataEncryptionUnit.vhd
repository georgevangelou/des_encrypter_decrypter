
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.custom_types.all;


entity DataEncryptionUnit is
    Port ( dataIn : in data_text_type;
           currentKey : in round_keys_type;
           dataOut : out data_text_type;
           counter : in integer range 1 to data_encryption_cycles;
           clk, rst, enable, dataPropagate : in std_logic);
end DataEncryptionUnit;

architecture DES1 of DataEncryptionUnit is
	signal dataInPermuted, dataOutPermuted, dataOutPermutedRev, dataOutTemp: data_text_type;
	signal dataLeft, dataRight, dataRightSigmad, dataRightPied: std_logic_vector(1 to 32);
	signal dataRightEpsiloned, dataRightXored: round_keys_type;
	
begin
	text_permutation_initial: entity work.Permutator(TextPermutator1) generic map(n=>64, m=>64) port map(data=>dataIn,  dataPermuted=>dataInPermuted);
	
	epsilon_permutation: 	entity work.Permutator(EpsilonPermutator) generic map(n=>32, m=>48) port map(data=>dataRight, dataPermuted=>dataRightEpsiloned);
	R_xor_K:				dataRightXored <= dataRightEpsiloned XOR currentKey;
	sigma_permutation: 		for i in 1 to 8 generate 
			sigma_permutation_i: entity work.Permutator(SigmaPermutator) generic map(n=>6, m=>4) port map(data=>dataRightXored(1+6*(i-1) to 6*i), dataPermuted=>dataRightSigmad(1+4*(i-1) to 4*i), p=>i); 
		end generate sigma_permutation;
	pi_permutation: 		entity work.Permutator(PiPermutator) generic map(n=>32, m=>32) port map(data=>dataRightSigmad, dataPermuted=>dataRightPied);
	right_conc_L_xor_F:		dataOutPermuted <= dataRight & (dataLeft XOR dataRightPied);
	
	dataOutPermutedRev <= dataOutPermuted(33 to 64) & dataOutPermuted(1 to 32);
	text_permutation_final:	entity work.Permutator(TextPermutator2)	generic map(n=>64, m=>64) port map(data=>dataOutPermutedRev, dataPermuted=>dataOutTemp);
	
	staging: process(clk, rst)
			variable wholeText: data_text_type;
		begin
			if rst='1' then
				wholeText := (others => '0');
				dataOut <= (others => '0');
			elsif rising_edge(clk) and enable='1' then
				if counter=1 then 
					wholeText := dataInPermuted;
				else 
					wholeText := dataOutPermuted; 
				end if;
				if dataPropagate='1' then
					dataOut <= dataOutTemp;
				end if;
			end if;
			dataLeft  <= wholeText( 1 to 32);
		    dataRight <= wholeText(33 to 64);
		end process;
				
end DES1;
