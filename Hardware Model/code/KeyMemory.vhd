library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.custom_types.all;

entity KeyMemory is
    Port ( rd_wr,clk,rst : in STD_LOGIC;
		address : in integer range 1 to 16;
		keyIn : in round_keys_type;
           keyOut : out round_keys_type);
end KeyMemory;


architecture Behavioral of KeyMemory is
begin
	register_file: process(clk, rst)
			variable stored: stored_keys_type;
		begin
			if rst='1' then
				stored := (others => (others => '0'));
				keyOut <= (others => '0');
			elsif rising_edge(clk) then
				if rd_wr='0' then	
					keyOut <= stored(address);
				else 
					stored(address) := keyIn;
				end if;
			end if;
		end process;	
end Behavioral;
