library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.custom_types.all;

entity Permutator is
generic (n: integer := 64;
         m: integer := 56);
Port (  data : in STD_LOGIC_VECTOR (1 to n);
		p: in integer range 1 to 8 := 1;
		dataPermuted : out STD_LOGIC_VECTOR (1 to m));
end Permutator;

architecture KeyPermutator1 of Permutator is
begin
    dataPermuted <= data(57)&data(49)&data(41)&data(33)&data(25)&data(17)&data(9)&data(1)&data(58)&data(50)&data(42)&data(34)&data(26)&data(18)&
		data(10)&data(2)&data(59)&data(51)&data(43)&data(35)&data(27)&data(19)&data(11)&data(3)&data(60)&data(52)&data(44)&data(36)&
		data(63)&data(55)&data(47)&data(39)&data(31)&data(23)&data(15)&data(7)&data(62)&data(54)&data(46)&data(38)&data(30)&data(22)&
		data(14)&data(6)&data(61)&data(53)&data(45)&data(37)&data(29)&data(21)&data(13)&data(5)&data(28)&data(20)&data(12)&data(4);
end KeyPermutator1;

architecture KeyPermutator2 of Permutator is
begin
    dataPermuted <= data(14)&data(17)&data(11)&data(24)&data(1)&data(5)&data(3)&data(28)&data(15)&data(6)&data(21)&data(10)&data(23)&
					data(19)&data(12)&data(4)&data(26)&data(8)&data(16)&data(7)&data(27)&data(20)&data(13)&data(2)&data(41)&
					data(52)&data(31)&data(37)&data(47)&data(55)&data(30)&data(40)&data(51)&data(45)&data(33)&data(48)&data(44)&
					data(49)&data(39)&data(56)&data(34)&data(53)&data(46)&data(42)&data(50)&data(36)&data(29)&data(32);
end KeyPermutator2;

architecture TextPermutator1 of Permutator is
begin
    dataPermuted <= data(58)&data(50)&data(42)&data(34)&data(26)&data(18)&data(10)&data(2)&data(60)&data(52)&data(44)&data(36)&
					data(28)&data(20)&data(12)&data(4)&data(62)&data(54)&data(46)&data(38)&data(30)&data(22)&data(14)&data(6)&data(64)&
					data(56)&data(48)&data(40)&data(32)&data(24)&data(16)&data(8)&data(57)&data(49)&data(41)&data(33)&data(25)&data(17)&
						data(9)&data(1)&data(59)&data(51)&data(43)&data(35)&data(27)&data(19)&data(11)&data(3)&data(61)&data(53)&data(45)&
						data(37)&data(29)&data(21)&data(13)&data(5)&data(63)&data(55)&data(47)&data(39)&data(31)&data(23)&data(15)&data(7);
end TextPermutator1;


architecture TextPermutator2 of Permutator is
begin
    dataPermuted <= data(40)&data(8)&data(48)&data(16)&data(56)&data(24)&data(64)&data(32)&data(39)&data(7)&data(47)&data(15)&data(55)&
					data(23)&data(63)&data(31)&data(38)&data(6)&data(46)&data(14)&data(54)&data(22)&data(62)&data(30)&data(37)&data(5)&data(45)&
					data(13)&data(53)&data(21)&data(61)&data(29)&data(36)&data(4)&data(44)&data(12)&data(52)&data(20)&data(60)&data(28)&data(35)&
					data(3)&data(43)&data(11)&data(51)&data(19)&data(59)&data(27)&data(34)&data(2)&data(42)&data(10)&data(50)&data(18)&data(58)&
					data(26)&data(33)&data(1)&data(41)&data(9)&data(49)&data(17)&data(57)&data(25);
end TextPermutator2;

architecture EpsilonPermutator of Permutator is
begin
    dataPermuted <= data(32)&data(1)&data(2)&data(3)&data(4)&data(5)&data(4)&data(5)&data(6)&data(7)&data(8)&data(9)&data(8)&data(9)&data(10)&
				data(11)&data(12)&data(13)&data(12)&data(13)&data(14)&data(15)&data(16)&data(17)&data(16)&data(17)&data(18)&data(19)&data(20)&data(21)&
				data(20)&data(21)&data(22)&data(23)&data(24)&data(25)&data(24)&data(25)&data(26)&data(27)&data(28)&data(29)&data(28)&data(29)&
				data(30)&data(31)&data(32)&data(1);   
end EpsilonPermutator;

architecture SigmaPermutator of Permutator is
	signal i: integer range 0 to  3;
	signal j: integer range 0 to 15;
	signal Sigma, Sigma1,Sigma2,Sigma3,Sigma4,Sigma5,Sigma6,Sigma7,Sigma8: sigma_type;
	signal t1: std_logic_vector(1 to 2);
	signal S1: std_logic_vector(1 to 4);
begin
	Sigma1 <= (0=>(0=>14,1=>4,2=>13,3=>1,4=>2,5=>15,6=>11,7=>8,8=>3,9=>10,10=>6,11=>12,12=>5,13=>9,14=>0,15=>7), 1=>(0=>0,1=>15,2=>7,3=>4,4=>14,5=>2,6=>13,7=>1,8=>10,9=>6,10=>12,11=>11,12=>9,13=>5,14=>3,15=>8), 2=>(0=>4,1=>1,2=>14,3=>8,4=>13,5=>6,6=>2,7=>11,8=>15,9=>12,10=>9,11=>7,12=>3,13=>10,14=>5,15=>0), 3=>(0=>15,1=>12,2=>8,3=>2,4=>4,5=>9,6=>1,7=>7,8=>5,9=>11,10=>3,11=>14,12=>10,13=>0,14=>6,15=>13));
	Sigma2 <= (0=>(0=>15,1=>1,2=>8,3=>14,4=>6,5=>11,6=>3,7=>4,8=>9,9=>7,10=>2,11=>13,12=>12,13=>0,14=>5,15=>10), 1=>(0=>3,1=>13,2=>4,3=>7,4=>15,5=>2,6=>8,7=>14,8=>12,9=>0,10=>1,11=>10,12=>6,13=>9,14=>11,15=>5), 2=>(0=>0,1=>14,2=>7,3=>11,4=>10,5=>4,6=>13,7=>1,8=>5,9=>8,10=>12,11=>6,12=>9,13=>3,14=>2,15=>15), 3=>(0=>13,1=>8,2=>10,3=>1,4=>3,5=>15,6=>4,7=>2,8=>11,9=>6,10=>7,11=>12,12=>0,13=>5,14=>14,15=>9)  );
	Sigma3 <= (0=>(0=>10,1=>0,2=>9,3=>14,4=>6,5=>3,6=>15,7=>5,8=>1,9=>13,10=>12,11=>7,12=>11,13=>4,14=>2,15=>8), 1=>(0=>13,1=>7,2=>0,3=>9,4=>3,5=>4,6=>6,7=>10,8=>2,9=>8,10=>5,11=>14,12=>12,13=>11,14=>15,15=>1), 2=>(0=>13,1=>6,2=>4,3=>9,4=>8,5=>15,6=>3,7=>0,8=>11,9=>1,10=>2,11=>12,12=>5,13=>10,14=>14,15=>7), 3=>(0=>1,1=>10,2=>13,3=>0,4=>6,5=>9,6=>8,7=>7,8=>4,9=>15,10=>14,11=>3,12=>11,13=>5,14=>2,15=>12)  );
	Sigma4 <= (0=>(0=>7,1=>13,2=>14,3=>3,4=>0,5=>6,6=>9,7=>10,8=>1,9=>2,10=>8,11=>5,12=>11,13=>12,14=>4,15=>15), 1=>(0=>13,1=>8,2=>11,3=>5,4=>6,5=>15,6=>0,7=>3,8=>4,9=>7,10=>2,11=>12,12=>1,13=>10,14=>14,15=>9), 2=>(0=>10,1=>6,2=>9,3=>0,4=>12,5=>11,6=>7,7=>13,8=>15,9=>1,10=>3,11=>14,12=>5,13=>2,14=>8,15=>4), 3=>(0=>3,1=>15,2=>0,3=>6,4=>10,5=>1,6=>13,7=>8,8=>9,9=>4,10=>5,11=>11,12=>12,13=>7,14=>2,15=>14)  );
	Sigma5 <= (0=>(0=>2,1=>12,2=>4,3=>1,4=>7,5=>10,6=>11,7=>6,8=>8,9=>5,10=>3,11=>15,12=>13,13=>0,14=>14,15=>9), 1=>(0=>14,1=>11,2=>2,3=>12,4=>4,5=>7,6=>13,7=>1,8=>5,9=>0,10=>15,11=>10,12=>3,13=>9,14=>8,15=>6), 2=>(0=>4,1=>2,2=>1,3=>11,4=>10,5=>13,6=>7,7=>8,8=>15,9=>9,10=>12,11=>5,12=>6,13=>3,14=>0,15=>14), 3=>(0=>11,1=>8,2=>12,3=>7,4=>1,5=>14,6=>2,7=>13,8=>6,9=>15,10=>0,11=>9,12=>10,13=>4,14=>5,15=>3)  );
	Sigma6 <= (0=>(0=>12,1=>1,2=>10,3=>15,4=>9,5=>2,6=>6,7=>8,8=>0,9=>13,10=>3,11=>4,12=>14,13=>7,14=>5,15=>11), 1=>(0=>10,1=>15,2=>4,3=>2,4=>7,5=>12,6=>9,7=>5,8=>6,9=>1,10=>13,11=>14,12=>0,13=>11,14=>3,15=>8), 2=>(0=>9,1=>14,2=>15,3=>5,4=>2,5=>8,6=>12,7=>3,8=>7,9=>0,10=>4,11=>10,12=>1,13=>13,14=>11,15=>6), 3=>(0=>4,1=>3,2=>2,3=>12,4=>9,5=>5,6=>15,7=>10,8=>11,9=>14,10=>1,11=>7,12=>6,13=>0,14=>8,15=>13)  );
	Sigma7 <= (0=>(0=>4,1=>11,2=>2,3=>14,4=>15,5=>0,6=>8,7=>13,8=>3,9=>12,10=>9,11=>7,12=>5,13=>10,14=>6,15=>1), 1=>(0=>13,1=>0,2=>11,3=>7,4=>4,5=>9,6=>1,7=>10,8=>14,9=>3,10=>5,11=>12,12=>2,13=>15,14=>8,15=>6), 2=>(0=>1,1=>4,2=>11,3=>13,4=>12,5=>3,6=>7,7=>14,8=>10,9=>15,10=>6,11=>8,12=>0,13=>5,14=>9,15=>2), 3=>(0=>6,1=>11,2=>13,3=>8,4=>1,5=>4,6=>10,7=>7,8=>9,9=>5,10=>0,11=>15,12=>14,13=>2,14=>3,15=>12)  );
	Sigma8 <= (0=>(0=>13,1=>2,2=>8,3=>4,4=>6,5=>15,6=>11,7=>1,8=>10,9=>9,10=>3,11=>14,12=>5,13=>0,14=>12,15=>7), 1=>(0=>1,1=>15,2=>13,3=>8,4=>10,5=>3,6=>7,7=>4,8=>12,9=>5,10=>6,11=>11,12=>0,13=>14,14=>9,15=>2), 2=>(0=>7,1=>11,2=>4,3=>1,4=>9,5=>12,6=>14,7=>2,8=>0,9=>6,10=>10,11=>13,12=>15,13=>3,14=>5,15=>8), 3=>(0=>2,1=>1,2=>14,3=>7,4=>4,5=>10,6=>8,7=>13,8=>15,9=>12,10=>9,11=>0,12=>3,13=>5,14=>6,15=>11)  );
	t1 <= data(1)&data(6);
	i <= to_integer(unsigned(t1));
	j <= to_integer(unsigned(data(2 to 5)));
	
	Sigma <=Sigma1 when p=1 else
			Sigma2 when p=2 else
			Sigma3 when p=3 else
			Sigma4 when p=4 else
			Sigma5 when p=5 else
			Sigma6 when p=6 else
			Sigma7 when p=7 else
			Sigma8 when p=8;
	dataPermuted <= std_logic_vector(to_unsigned(Sigma(i,j), m));
	
end SigmaPermutator;

architecture PiPermutator of Permutator is
begin
    dataPermuted <= data(16)&data(7)&data(20)&data(21)&data(29)&data(12)&data(28)&data(17)&data(1)&data(15)&data(23)&data(26)&data(5)&data(18)&data(31)&
					data(10)&data(2)&data(8)&data(24)&data(14)&data(32)&data(27)&data(3)&data(9)&data(19)&data(13)&data(30)&data(6)&data(22)&data(11)&data(4)&data(25); 
end PiPermutator;


