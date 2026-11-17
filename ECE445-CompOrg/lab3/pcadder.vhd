library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;

entity pcadder is 
	port(
		CurrAddr : in std_logic_vector(31 downto 0);
		NextAddr : out std_logic_vector(31 downto 0));
end pcadder;

architecture Behavioral of pcadder is	

begin	
	NextAddr <= std_logic_vector(unsigned(CurrAddr)+4);
end Behavioral;