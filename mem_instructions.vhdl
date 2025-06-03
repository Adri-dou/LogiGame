library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mem_instruct is 
    generic (
        N : integer := 4
    );
    port (
        clk : in std_logic;
        reset : in std_logic;
        SEL_FCT : out std_logic_vector (N-1 downto 0);
        SEL_ROUTE : out std_logic_vector (N-1 downto 0);
        SEL_OUT : out std_logic_vector (1 downto 0)
    );
end mem_instruct;

architecture mem_instruct_Arch of mem_instruct is
    type programme_matrix is array (0 to 127) of std_logic_vector (9 downto 0);
begin
    memInstructionProcess : process (clk, reset)
        variable programme : programme_matrix := (
            0 => "0000000000",
            1 => "0000011100",
            2 => "1111000011",
            3 => "1101110000",
            4 => "0111000000",
            5 => "0011000011",
            6 => "0000011100",
            7 => "1001010100",
            8 => "1001010100",
            9 => "1011110000",
            10 => "1011110000",
            11 => "1011110000",
            12 => "1000010100",
            13 => "1011110000",
            14 => "1000111000",
            15 => "0000011100",
            16 => "0000000100",
            17 => "1010110000",
            18 => "1001010100",
            19 => "1010110000",
            20 => "1001111100",
            21 => "0000000100",
            22 => "0000101000",
            23 => "0101111000",
            24 => "0000000100",
            25 => "0000100000",
            26 => "1011110000",
            27 => "1011110000",
            28 => "1011110000",
            29 => "1011110000",
            30 => "1000010100",
            31 => "0000100000",
            32 => "0110000011",
            others => "0000000000"
        );
        variable index : std_logic_vector (6 downto 0) := "0000000";
    begin
        if reset = '1' then
            programme := (others => (others => '0'));
        elsif rising_edge(clk) then
            SEL_FCT <= programme(to_integer(unsigned(index)))(9 downto 6);
            SEL_ROUTE <= programme(to_integer(unsigned(index)))(5 downto 2);
            SEL_OUT <= programme(to_integer(unsigned(index)))(1 downto 0);
        end if;
        if falling_edge(clk) then
            index := std_logic_vector(unsigned(index) + to_unsigned(1, index'length));
        end if;
    end process;
end mem_instruct_Arch;