library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity mem_instruct is 
    generic (
        N : integer := 4
    );
    port (
        clock : in std_logic;
        reset : in std_logic;
        SEL_FCT : out std_logic_vector (N-1 downto 0);
        SEL_ROUTE : out std_logic_vector (N-1 downto 0);
        SEL_OUT : out std_logic_vector (1 downto 0);
        programme : in std_logic_vector (1280-1 downto 0)
    );
end mem_instruct;

architecture mem_instruct_Arch of mem_instruct is
    begin
        type a_programme is array (0 to 3, 0 to 319)
        programme <=
        InstructProc : process (clock, reset)
        begin
            InstructLoop : for k in 0 to 319 loop
                if reset = '1' then
                    programme <= (others => '0');
                elsif rising_edge(clock) then
                    SEL_ROUTE <= programme(1279-k*4 downto 1275-k*4);
                end if;
            
            end loop InstructLoop; -- <name>
        end process;
    end mem_instruct_Arch;
