library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux2to1_5b is
    port (D0, D1 : in std_logic_vector(4 downto 0);
          Sel : in std_logic; Y : out std_logic_vector(4 downto 0));
end mux2to1_5b;
architecture Behavioral of mux2to1_5b is begin
    Y <= D0 when Sel='0' else D1;
end Behavioral;
