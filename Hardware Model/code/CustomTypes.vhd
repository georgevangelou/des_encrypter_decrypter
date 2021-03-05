library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


package custom_types is
	constant data_encryption_cycles : integer := 17;
	constant key_generation_cycles : integer := 17;
	constant max_address : integer := 16;
	subtype data_text_type is std_logic_vector(1 to 64);
	subtype main_key_type is std_logic_vector(1 to 64);
    subtype round_keys_type is std_logic_vector(1 to 48);
	type stored_keys_type is array (1 to 16) of round_keys_type;
	type system_state_type is (IDLE, GENERATING_KEYS, ENCRYPTING, DECRYPTING);
	type sigma_type is array(0 to 3, 0 to 15) of integer range 0 to 15;

end package;
