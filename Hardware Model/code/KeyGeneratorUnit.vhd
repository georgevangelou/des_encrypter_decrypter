library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.custom_types.all;

entity KeyGeneratorUnit is
    Port ( 	clk, enable, rst: in std_logic;
		counter : in integer range 1 to 16;
			keyIn : in main_key_type;
			keyOut : out round_keys_type);
end KeyGeneratorUnit;

architecture Behavioral of KeyGeneratorUnit is
    signal keyInPermuted, keyCur: STD_LOGIC_VECTOR (1 to 56);
begin    
    key_permutation_1: entity work.Permutator(KeyPermutator1) generic map(n=>64, m=>56) port map(data=>keyIn,  dataPermuted=>keyInPermuted);
    key_permutation_2: entity work.Permutator(KeyPermutator2) generic map(n=>56, m=>48) port map(data=>keyCur, dataPermuted=>keyOut);
    
	rotations: process (clk, enable, rst)
			variable keyCurVar: std_logic_vector (1 to 56);
			variable keyLeftHalf, keyRightHalf: std_logic_vector (1 to 28);
		begin
			if rst='1' then
				keyCurVar := (others => '0');
				keyLeftHalf := (others => '0');
				keyRightHalf := (others => '0');
			elsif rising_edge(clk) and enable='1' then
				if counter=1 then 
					keyCurVar := keyInPermuted;
				end if;
				if counter=1 or counter=2 or counter=9 or counter=16 then
					keyLeftHalf  := keyCurVar( 2 to 28)&keyCurVar( 1); 
					keyRightHalf := keyCurVar(30 to 56)&keyCurVar(29); 
				else
					keyLeftHalf  := keyCurVar( 3 to 28)&keyCurVar( 1 to  2);
					keyRightHalf := keyCurVar(31 to 56)&keyCurVar(29 to 30);
				end if;
			end if;
			keyCurVar := keyLeftHalf & keyRightHalf;
			keyCur <= keyCurVar;
		end process;
end Behavioral;
