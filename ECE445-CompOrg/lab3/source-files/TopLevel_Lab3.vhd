----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/21/2023 03:23:39 PM
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopLevel_Lab3 is
    Port ( CLK     : in  std_logic;
           BTN     : in  std_logic_vector(4 downto 0);
		   SW      : in  std_logic_vector(2 downto 0);
	       LED     : out std_logic_vector(15 downto 0);
	       SSEG_CA : out std_logic_vector(7 downto 0);
           SSEG_AN : out std_logic_vector(3 downto 0));
end TopLevel_Lab3;

architecture Behavioral of TopLevel_Lab3 is
    signal MCtr: unsigned (20 downto 0);
    
    -- buttons
    signal BTNL : std_logic;
    
    -- digit ROM
    type sseg_digits is array(0 to 10) of std_logic_vector(7 downto 0);
    constant digit_table: sseg_digits :=(
        "11111111",  -- 
        "11000000",  -- o 
        "10001100",  -- p 
        "10101111",  -- r
        "10010010",  -- s
        "11000001",  -- U
        "10001111",  -- t
        "10100001",  -- d 
        "10001001",  -- H
        "10001110",  -- F
        "11000110"   -- C
    );
    
    -- SSEG RAM
    type SSEG_MEM is array(0 to 1) of std_logic_vector(7 downto 0);
    signal SSEGmem : SSEG_MEM;
    
    -- LED output
    signal LEDout : std_logic_vector(31 downto 0);
    
    -- TopLevel Wrapper signals
    signal rst    : std_logic;
    signal en     : std_logic;
    signal opcode : std_logic_vector(5 downto 0);
    signal rs     : std_logic_vector(4 downto 0);
    signal rt     : std_logic_vector(4 downto 0);
    signal rd     : std_logic_vector(4 downto 0);
    signal shamt  : std_logic_vector(4 downto 0);
    signal funct  : std_logic_vector(5 downto 0);
    signal pcout  : std_logic_vector(4 downto 0);  

begin
    Lab3_wrapper_inst : entity work.Lab3_wrapper 
        port map(
            clk     => clk,
            en      => en,
            funct   => funct,
            opcode  => opcode,
            pcout   => pcout,
            rd      => rd,
            rs      => rs,
            rst     => rst,
            rt      => rt,
            shamt   => shamt
        );
    
    BTNL <= BTN(1);
    
    -- write to SSEG display
    process(CLK, SW)
    begin
        if(rising_edge(CLK)) then
            case(SW) is
                when "000" => -- PC
                    SSEGmem(0) <= digit_table(2); 
                    SSEGmem(1) <= digit_table(10);
                when "001" => -- OP
                    SSEGmem(0) <= digit_table(1); 
                    SSEGmem(1) <= digit_table(2);
                when "010" => -- rS
                    SSEGmem(0) <= digit_table(3); 
                    SSEGmem(1) <= digit_table(4);
                when "011" => -- rt
                    SSEGmem(0) <= digit_table(3); 
                    SSEGmem(1) <= digit_table(6);
                when "100" => -- rd
                    SSEGmem(0) <= digit_table(3); 
                    SSEGmem(1) <= digit_table(7);
                when "101" => -- SH
                    SSEGmem(0) <= digit_table(4); 
                    SSEGmem(1) <= digit_table(8);    
                when "110" => -- FU
                    SSEGmem(0) <= digit_table(9); 
                    SSEGmem(1) <= digit_table(5);               
                when others =>
                    SSEGmem(0) <= digit_table(0); 
                    SSEGmem(1) <= digit_table(0);
            end case;
            --increments the master counter for the sseg display
            MCtr <= MCtr + 1;
        end if;
    end process;
    
    -- output of LEDs
    with SW select
        LEDout <= x"000000" & "000" & pcout when "000",
                  x"000000" & "00" & opcode when "001",
                  x"000000" & "000" & rs    when "010",
                  x"000000" & "000" & rt    when "011",
                  x"000000" & "000" & rd    when "100",
                  x"000000" & "000" & shamt when "101",
                  x"000000" & "00" & funct  when "110",
                  opcode & rs & rt & rd & shamt & funct when others;
    
    LED <= LEDout(31 downto 16) when BTNL = '1' else
           LEDout(15 downto 0);
    
    -- output to SSEG display
    process(MCtr(18 downto 17), SSEGmem)
    begin
        case(MCtr(18 downto 17)) is
            when "00" =>
                SSEG_CA <= SSEGmem(0);
                SSEG_AN <= "0111";
            when "01" =>
                SSEG_CA <= SSEGmem(1);
                SSEG_AN <= "1011";
            when others =>
                SSEG_CA <= "11111111";
                SSEG_AN <= "1111";
        end case;
    end process;
    
    Inst_BTN_debounce : entity work.BTN_debounce 
    port map(
        btn => btn,
        clk => clk,
        rst => rst,
        en  => en
    );
    
end Behavioral;
