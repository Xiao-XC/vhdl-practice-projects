library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_lab5 is end tb_lab5;
architecture Behavioral of tb_lab5 is
    signal CLK : std_logic := '0';
    signal RST : std_logic := '1';
    signal EN : std_logic := '1';
    signal PCOut : std_logic_vector(4 downto 0);
    signal Dout : std_logic_vector(31 downto 0);
    signal Zero, Overflow, Carryout : std_logic;
begin
    -- Match this entity name and port map to YOUR generated wrapper.
    DUT : entity work.design_1_wrapper
        port map(CLK=>CLK, RST=>RST, EN=>EN, PCOut=>PCOut,
                 Dout=>Dout, Zero=>Zero, Overflow=>Overflow, Carryout=>Carryout);
    CLK <= not CLK after 10 ns;
    EN <= '1';
    process begin
        RST<='1'; wait for 20 ns;
        RST<='0'; wait for 600 ns;
        wait;
    end process;
end Behavioral;
