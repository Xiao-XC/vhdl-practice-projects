library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control is
    port (Opcode : in std_logic_vector(5 downto 0);
          RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite : out std_logic;
          Branch : out std_logic_vector(1 downto 0);
          ALUOp : out std_logic_vector(2 downto 0));
end control;
architecture Behavioral of control is begin
    process(Opcode) begin
        RegDst<='0'; ALUSrc<='0'; MemtoReg<='0'; RegWrite<='0';
        MemRead<='0'; MemWrite<='0'; Branch<="00"; ALUOp<="111";
        case Opcode is
            when "000000" => RegDst<='1'; RegWrite<='1'; ALUOp<="000";
            when "100011" => ALUSrc<='1'; MemtoReg<='1'; RegWrite<='1'; MemRead<='1'; ALUOp<="001";
            when "101011" => ALUSrc<='1'; MemWrite<='1'; ALUOp<="001";
            when "000100" => Branch<="01"; ALUOp<="010";
            when "000101" => Branch<="10"; ALUOp<="010";
            when "001000" | "001001" => ALUSrc<='1'; RegWrite<='1'; ALUOp<="001";
            when "001100" => ALUSrc<='1'; RegWrite<='1'; ALUOp<="011";
            when "001101" => ALUSrc<='1'; RegWrite<='1'; ALUOp<="100";
            when "001010" => ALUSrc<='1'; RegWrite<='1'; ALUOp<="101";
            when "001011" => ALUSrc<='1'; RegWrite<='1'; ALUOp<="110";
            when others => null;
        end case;
    end process;
end Behavioral;
