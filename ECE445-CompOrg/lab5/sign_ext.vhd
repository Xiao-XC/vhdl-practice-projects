library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Logical immediates zero-extend; all other supported immediates sign-extend.
entity sign_ext is
    port (Immediate : in std_logic_vector(15 downto 0);
          Opcode : in std_logic_vector(5 downto 0);
          Extended : out std_logic_vector(31 downto 0));
end sign_ext;
architecture Behavioral of sign_ext is begin
    Extended <= x"0000" & Immediate when Opcode="001100" or Opcode="001101"
                else std_logic_vector(resize(signed(Immediate),32));
end Behavioral;
