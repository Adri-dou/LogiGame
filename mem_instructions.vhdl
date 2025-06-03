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
        variable programme : programme_matrix;
        variable index : std_logic_vector (6 downto 0);
    begin
        if reset = '1' then
            programme <= (others => '0');
        elsif rising_edge(clk) then
            if to
        end if;
end mem_instruct_Arch;