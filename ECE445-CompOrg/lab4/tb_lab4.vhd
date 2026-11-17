library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_lab4 is
end tb_lab4;

architecture Behavioral of tb_lab4 is
    signal CLK      : std_logic := '0';
    signal RST      : std_logic := '1';
    signal EN       : std_logic := '1';
    signal PCOut    : std_logic_vector(4 downto 0);
    signal Dout     : std_logic_vector(31 downto 0);
    signal Zero     : std_logic;
    signal Overflow : std_logic;
begin
    -- Replace the entity name and LEFT-side port names below if your
    -- generated block-design wrapper uses different names.
    -- Instantiate the datapath wrapper, not TopLevel_Lab4.
    DUT : entity work.design_1_wrapper
        port map (
            CLK      => CLK,
            RST      => RST,
            EN       => EN,
            PCOut    => PCOut,
            Dout     => Dout,
            Zero     => Zero,
            Overflow => Overflow
        );

    -- 20 ns period: 10 ns low, 10 ns high.
    CLK <= not CLK after 10 ns;

    -- Enable remains high throughout the simulation.
    EN <= '1';

    -- Repeats automatically: reset for one cycle, then run for 20 cycles.
    reset_process : process
    begin
        RST <= '1';
        wait for 20 ns;
        RST <= '0';
        wait for 400 ns;
    end process;
end Behavioral;
