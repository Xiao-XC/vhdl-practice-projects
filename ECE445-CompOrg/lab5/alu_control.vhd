library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu_control is
    port (Funct : in std_logic_vector(5 downto 0);
          ALUOp : in std_logic_vector(2 downto 0);
          ALUCntl : out std_logic_vector(3 downto 0));
end alu_control;
architecture Behavioral of alu_control is begin
    process(Funct, ALUOp) begin
        ALUCntl <= "1111";
        case ALUOp is
            when "000" =>
                case Funct is
                    when "100100" => ALUCntl <= "0000";
                    when "100101" => ALUCntl <= "0001";
                    when "100110" => ALUCntl <= "0010";
                    when "100111" => ALUCntl <= "0011";
                    when "100000" | "100001" => ALUCntl <= "0100";
                    when "100010" | "100011" => ALUCntl <= "0101";
                    when "000000" => ALUCntl <= "0110";
                    when "000010" => ALUCntl <= "0111";
                    when "101010" => ALUCntl <= "1000";
                    when "101011" => ALUCntl <= "1001";
                    when others => null;
                end case;
            when "001" => ALUCntl <= "0100";
            when "010" => ALUCntl <= "0101";
            when "011" => ALUCntl <= "0000";
            when "100" => ALUCntl <= "0001";
            when "101" => ALUCntl <= "1000";
            when "110" => ALUCntl <= "1001";
            when others => null;
        end case;
    end process;
end Behavioral;
