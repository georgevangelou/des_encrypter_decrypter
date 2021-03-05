
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.custom_types.all;

entity ControlUnit is
    Port ( clk, rst, newData, newKey, encr_decr : in std_logic;
           rd_wr, busy, dataDone, dataPropagate, keyDone: out std_logic;
		   counterSignal : out integer range 1 to 16;
		   enableDataEncryption, enableKeyGenerator: out std_logic;
           address: out integer range 1 to 16);
end ControlUnit;

architecture MindControl of ControlUnit is
begin
	fsm: process(clk, rst)
			variable state: system_state_type;
			variable counter: integer range 1 to 16;
			variable addressVariable: integer range 1 to max_address;
		begin
			if rst='1' then
				state := IDLE;
				rd_wr <= '0';
				busy <= '0';
				dataDone <= '0';
				dataPropagate <= '0';
				keyDone <= '0';
				addressVariable := 1;
				enableKeyGenerator <= '0';
				enableDataEncryption <= '0';
				counter := 1;
			elsif rising_edge(clk) then					
				if state=IDLE then
					datadone <= '0';
					dataPropagate <= '0';
					keyDone <= '0';
					counter := 1;
					if newKey='1' then
						addressVariable := 1;
						state := GENERATING_KEYS;
						rd_wr <= '0';
						busy <= '1';
						dataDone <= '0';
						enableKeyGenerator <= '1';
						enableDataEncryption <= '0';
					elsif newData='1' then
						if encr_decr='0' then
							addressVariable := 1;
							state := ENCRYPTING;
						elsif encr_decr='1' then
							addressVariable := max_address;
							state := DECRYPTING;
						end if;
						rd_wr <= '0';
						busy <= '1';
						dataDone <= '0';
						enableKeyGenerator <= '0';
						enableDataEncryption <= '1';
					end if;
				elsif state=GENERATING_KEYS then
					dataDone <= '0';
					dataPropagate <= '0';
					if counter=key_generation_cycles then
						counter := 1;
						rd_wr <= '0';
						enableKeyGenerator <= '0';
						keyDone <= '1';
						if newData='1' then
							enableDataEncryption <= '1';
							if encr_decr='0' then
								addressVariable := 1;
								state := ENCRYPTING;
							elsif encr_decr='1' then
								addressVariable := max_address;
								state := DECRYPTING;
							end if;						
						else
							busy <= '0';
							state := IDLE;
						end if;
					else
						keyDone <= '0';
						rd_wr <= '1';
						addressVariable := counter;
						counter := counter + 1;						
					end if;
				elsif state=ENCRYPTING then
					keyDone <= '0';
					rd_wr <= '0';
					if counter=data_encryption_cycles then
						dataDone <= '1';
						dataPropagate <= '0';
						addressVariable := 1;
						counter := 1;
						if newKey='1' then
							state := GENERATING_KEYS;
							rd_wr <= '0';
							enableKeyGenerator <= '1';
							enableDataEncryption <= '0';
						elsif newData='1' then
							if encr_decr='0' then
								addressVariable := 1;
								state := ENCRYPTING;
							elsif encr_decr='1' then
								addressVariable := max_address;
								state := DECRYPTING;
							end if;
							rd_wr <= '0';
							enableKeyGenerator <= '0';
							enableDataEncryption <= '1';
						else 
							state := IDLE;
							busy <= '0';
							rd_wr <= '0';
							enableKeyGenerator <= '0';
							enableDataEncryption <= '0';
						end if;
					elsif counter=data_encryption_cycles-1 then
						dataDone <= '0';
						dataPropagate <= '1';
						counter := counter + 1;	
						addressVariable := 1;	
					else
						dataDone <= '0';
						dataPropagate <= '0';
						counter := counter + 1;	
						addressVariable := addressVariable + 1;						
					end if;
				elsif state=DECRYPTING then
					keyDone <= '0';
					rd_wr <= '0';
					if counter=data_encryption_cycles then
						dataDone <= '1';
						dataPropagate <= '0';
						addressVariable := 1;
						counter := 1;
						if newKey='1' then
							state := GENERATING_KEYS;
							rd_wr <= '0';
							enableKeyGenerator <= '1';
							enableDataEncryption <= '0';
						elsif newData='1' then
							if encr_decr='0' then
								addressVariable := 1;
								state := ENCRYPTING;
							elsif encr_decr='1' then
								addressVariable := max_address;
								state := DECRYPTING;
							end if;
							rd_wr <= '0';
							enableKeyGenerator <= '0';
							enableDataEncryption <= '1';
						else 
							state := IDLE;
							busy <= '0';
							rd_wr <= '0';
							enableKeyGenerator <= '0';
							enableDataEncryption <= '0';
						end if;
					elsif counter=data_encryption_cycles-1 then
						dataDone <= '0';
						dataPropagate <= '1';
						counter := counter + 1;	
						addressVariable := max_address;	
					else
						dataDone <= '0';
						dataPropagate <= '0';
						counter := counter + 1;	
						addressVariable := addressVariable - 1;						
					end if;
				end if;
			end if;
			address <= addressVariable;
			counterSignal <= counter;
		end process;
end MindControl;
