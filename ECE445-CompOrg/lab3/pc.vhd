library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pc is
	port(
		CLK : in std_logic;
		RST : in std_logic;
		EN:   in std_logic;
		NextAddr : in std_logic_vector(31 downto 0);
		CurrAddr : out std_logic_vector(31 downto 0));
	end pc;

architecture Behavioral of pc is	
	signal reg : std_logic_vector(31 downto 0) := x"00000000";
begin 
	process(CLK)
	begin	
		if rising_edge(CLK) then
			if RST = '1' then	
				reg <= x"00000000";
			elsif EN = '1' then	
				reg <= NextAddr;
			end if;
		end if;
	end process;
		
		CurrAddr <= reg;
end Behavioral;