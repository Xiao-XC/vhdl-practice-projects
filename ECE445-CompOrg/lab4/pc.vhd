library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
    port (CLK, RST, EN : in std_logic; NextAddr : in std_logic_vector(31 downto 0);
          CurrAddr : out std_logic_vector(31 downto 0));
end pc;
architecture rtl of pc is
    signal address : std_logic_vector(31 downto 0) := (others => '0');
begin
    process(CLK) begin
        if rising_edge(CLK) then
            if RST = '1' then address <= (others => '0');
            elsif EN = '1' then address <= NextAddr; end if;
        end if;
    end process;
    CurrAddr <= address;
end rtl;
