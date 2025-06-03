library IEEE;
use IEEE.std_logic_1164.all;

entity memCache is
    generic (
        N : integer := 8
    );
    port (
        E : in std_logic_vector (N-1 downto 0);
        S : out STD_LOGIC_VECTOR (N-1 downto 0);
        clk : in std_logic;
        reset : in std_logic
    );
end memCache;

architecture memCache_arch of memCache is
begin
    bufProcess : process(clk, reset)
    begin
        if reset = '1' then
            S <= (others => '0');
        elsif rising_edge(clk) then
            S <= E;
        end if;
    end process;
end memCache_arch;