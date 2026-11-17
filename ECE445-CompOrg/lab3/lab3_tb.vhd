library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lab3_tb is
end lab3_tb;

architecture Behavioral of lab3_tb is

    signal CLK : std_logic := '0';
    signal RST : std_logic := '0';
    signal EN : std_logic := '1';

    signal OPCODE : std_logic_vector(5 downto 0);
    signal RS : std_logic_vector(4 downto 0);
    signal RT : std_logic_vector(4 downto 0);
    signal RD : std_logic_vector(4 downto 0);
    signal SHAMT : std_logic_vector(4 downto 0);
    signal FUNCT : std_logic_vector(5 downto 0);
    signal PCOUT : std_logic_vector(4 downto 0);

begin
    UUT : entity work.Lab3_wrapper
        port map (
            clk => CLK,
            en => EN,
            rst => RST,
            opcode => OPCODE,
            rs => RS,
            rt => RT,
            rd => RD,
            shamt => SHAMT,
            funct => FUNCT,
            pcout => PCOUT
        );

    CLK <= not CLK after 10 ns;
    reset_process : process
    begin
        RST <= '1';
        wait for 20 ns;
        RST <= '0';
        wait for 400 ns;
        RST <= '1';
        wait for 20 ns;
        RST <= '0';
        wait for 400 ns;
        RST <= '1';
        wait for 20 ns;
        RST <= '0';
        wait for 400 ns;

        wait;
    end process;

end Behavioral;