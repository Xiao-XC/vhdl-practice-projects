----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/08/2023 01:05:53 AM
-- Design Name: 
-- Module Name: TopLevel - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TopLevel_Lab2 is
  Port ( SW : in std_logic_vector(14 downto 0);
         LED : out std_logic_vector(2 downto 0);
         SSEG_CA : out std_logic_vector(7 downto 0);
         SSEG_AN : out std_logic_vector(3 downto 0) 
       );
end TopLevel_Lab2;

architecture Behavioral of TopLevel_Lab2 is

component alu is
    Port(A : in std_logic_vector(31 downto 0);
         B : in std_logic_vector(31 downto 0);
         Shamt : in std_logic_vector(4 downto 0);
         ALUCntl : in std_logic_vector(3 downto 0);
         Carryin : in std_logic;
         Zero, Overflow, Carryout : out std_logic;
         ALUout : out std_logic_vector(31 downto 0));
end component alu;

signal A, B, ALUout : std_logic_vector(31 downto 0);
signal Shamt : std_logic_vector(4 downto 0);
signal ALUCntl : std_logic_vector(3 downto 0);
signal Carryin, Zero, Overflow, Carryout : std_logic;

type sseg_digits is array (0 to 15) of std_logic_vector(7 downto 0);
constant digit_table: sseg_digits := (
    "11000000",  -- 0
    "11111001",  -- 1 
    "10100100",  -- 2 
    "10110000",  -- 3
    "10011001",  -- 4
    "10010010",  -- 5
    "10000010",  -- 6
    "11111000",  -- 7 
    "10000000",  -- 8
    "10011000",  -- 9 
    "10001000",  -- A
    "10000011",  -- b 
    "11000110",  -- C 
    "10100001",  -- d 
    "10000110",  -- E 
    "10001110"   -- F
);

begin
    
alu_inst: alu port map(
    A => A,
    B => B,
    Shamt => Shamt,
    ALUCntl => ALUCntl,
    Carryin => Carryin,
    Carryout => Carryout,
    Zero => Zero,
    Overflow => Overflow,
    ALUout => ALUout 
);

-- input signal assignments
A       <= x"0000000" & SW(3 downto 0) when SW(3) = '0' else
		   x"FFFFFFF" & SW(3 downto 0);
B       <= x"0000000" & SW(7 downto 4) when SW(3) = '0' else
		   x"FFFFFFF" & SW(7 downto 4);
Carryin <= SW(8);
ALUCntl <= SW(12 downto 9);
Shamt   <= "000" & SW(14 downto 13);

-- output signals driving LED outputs
LED(0) <= Zero;
LED(1) <= Carryout;
LED(2) <= Overflow;

SSEG_AN <= "1110";
SSEG_CA <= digit_table(to_integer(unsigned(ALUout(3 downto 0))));

end Behavioral;
