library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.custom_types.all;

entity DesUnit is
Port ( 	clk, rst, enable, newData, newKey, encr_decr: in std_logic;
		dataDone, keyDone, busy : out std_logic;
		dataIn  :   in data_text_type;
		dataOut :  out data_text_type;
		mainKey :   in main_key_type);
end DesUnit;

architecture Behavioral of DesUnit is
	signal newSemiKey, existSemiKey : round_keys_type;
	signal enableDataEncryption, enableKeyGenerator, rd_wr: std_logic;
	signal dataPropagate, gatedClk : std_logic;
	signal counter : integer range 1 to 30;
	signal address : integer range 1 to max_address;

begin
	gatedClk <= clk AND enable;

	data_encryptor: entity work.DataEncryptionUnit(DES1) port map(dataIn=>dataIn, currentKey=>existSemiKey, dataOut=>dataOut, counter=>counter, clk=>gatedClk, 
																rst=>rst, enable=>enableDataEncryption, dataPropagate=>dataPropagate);
	
	key_generator: entity work.KeyGeneratorUnit(Behavioral) port map(clk=>gatedClk, enable=>enableKeyGenerator, rst=>rst, counter=>counter, keyIn=>mainKey, 
																	keyOut=>newSemiKey);
	
	key_memory: entity work.KeyMemory(Behavioral) port map(rd_wr=>rd_wr, clk=>gatedClk, rst=>rst, address=>address, keyIn=>newSemiKey, keyOut=>existSemiKey);
	
	controller: entity work.ControlUnit(MindControl) port map(clk=>gatedClk, rst=>rst, newData=>newData, newKey=>newKey, rd_wr=>rd_wr, busy=>busy, dataDone=>dataDone, keyDone=>keyDone, 
											encr_decr=>encr_decr, dataPropagate=>dataPropagate, counterSignal=>counter, enableDataEncryption=>enableDataEncryption, enableKeyGenerator=>enableKeyGenerator, address=>address);

end Behavioral;

