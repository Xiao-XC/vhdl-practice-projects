library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity branch_adder is
    port (PCPlus4, Extended : in std_logic_vector(31 downto 0);
          BranchAddr : out std_logic_vector(31 downto 0));
end branch_adder;
architecture Behavioral of branch_adder is begin
    BranchAddr <= std_logic_vector(unsigned(PCPlus4) + shift_left(unsigned(Extended),2));
end Behavioral;
