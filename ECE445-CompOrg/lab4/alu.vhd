library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
    Port(A                       : in std_logic_vector(31 downto 0);
         B                       : in std_logic_vector(31 downto 0);
         Shamt                   : in std_logic_vector(4 downto 0);
         ALUCntl                 : in std_logic_vector(3 downto 0);
         Carryin                 : in std_logic;
         Zero, Overflow, Carryout : out std_logic;
         ALUout                  : out std_logic_vector(31 downto 0));
end alu;

architecture Behavioral of alu is

signal ALUresult : std_logic_vector(31 downto 0);
signal temp_C : std_logic_vector(32 downto 0) := (others => '0');
signal temp_A, temp_B : std_logic_vector(32 downto 0);

-- Small helper signals
signal temp_sum : std_logic_vector(32 downto 0);
signal SLT_result  : std_logic_vector(31 downto 0);
signal SLTU_result : std_logic_vector(31 downto 0);

begin

----ALU Function Selection----------------------------
    with ALUCntl select
        ALUresult <=
            A and B                                             when "0000",
            A or B                                              when "0001",
            A xor B                                             when "0010",
            not (A or B)                                        when "0011",
            temp_sum(31 downto 0)                               when "0100",
            std_logic_vector(unsigned(A) - unsigned(B))          when "0101",
            std_logic_vector(
                shift_left(unsigned(B), to_integer(unsigned(Shamt)))
            )                                                   when "0110",
            std_logic_vector(
                shift_right(unsigned(B), to_integer(unsigned(Shamt)))
            )                                                   when "0111",
            SLT_result                                          when "1000",
            SLTU_result                                         when "1001",
            A                                                   when others;

    ALUout <= ALUresult;
-------------------------------------------------------

----Addition Operations--------------------------------
    temp_A <= '0' & A;
    temp_B <= '0' & B;

    temp_C <= (32 downto 1 => '0') & Carryin;

    temp_sum <= std_logic_vector(
                    unsigned(temp_A) +
                    unsigned(temp_B) +
                    unsigned(temp_C)
                );
------------------------------------------------------

----Carryout, Overflow, and Zero Flag-----------------

    Carryout <= temp_sum(32) when ALUCntl = "0100" else '0';


    Overflow <= '1'
        when (
            ALUCntl = "0100"
            and A(31) = B(31)
            and ALUresult(31) /= A(31)
        )
        or (
            ALUCntl = "0101"
            and A(31) /= B(31)
            and ALUresult(31) /= A(31)
        )
        else '0';


    Zero <= '1' when ALUresult = x"00000000" else '0';

------------------------------------------------------

----Set On Less Than Operation------------------------

    SLT_result <= x"00000001"
        when signed(A) < signed(B)
        else x"00000000";

    SLTU_result <= x"00000001"
        when unsigned(A) < unsigned(B)
        else x"00000000";

------------------------------------------------------

----Shift Operations----------------------------------
    -- Shift operations are implemented in the
    -- ALU function-selection block above.
    -- Both shifts operate on input B as required.
------------------------------------------------------

end Behavioral;