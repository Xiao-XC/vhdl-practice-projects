library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_control is
    Port (
        Funct   : in  std_logic_vector(5 downto 0);
        ALUCntl : out std_logic_vector(3 downto 0)
    );
end alu_control;

architecture Behavioral of alu_control is
begin
    with Funct select
        ALUCntl <=
            "0000" when "100100", -- and
            "0001" when "100101", -- or
            "0010" when "100110", -- xor
            "0011" when "100111", -- nor
            "0100" when "100000", -- add
            "0100" when "100001", -- addu
            "0101" when "100010", -- sub
            "0101" when "100011", -- subu
            "0110" when "000000", -- sll
            "0111" when "000010", -- srl
            "1000" when "101010", -- slt
            "1001" when "101011", -- sltu
            "1111" when others;
end Behavioral;