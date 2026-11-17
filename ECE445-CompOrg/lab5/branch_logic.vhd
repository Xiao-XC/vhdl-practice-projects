library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity branch_logic is
    port (Branch : in std_logic_vector(1 downto 0);
          Zero : in std_logic; BranchOut : out std_logic);
end branch_logic;
architecture Behavioral of branch_logic is begin
    BranchOut <= '1' when (Branch="01" and Zero='1') or (Branch="10" and Zero='0') else '0';
end Behavioral;
