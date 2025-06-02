library IEEE;
use IEEE.std_logic_1164.all;

entity memSELout is
    generic (
        N : integer := 2
    );
    port (
        E : in std_logic_vector (N-1 downto 0);
        S : out STD_LOGIC_VECTOR (N-1 downto 0);
        clk : in std_logic;
        reset : in std_logic
    );
end memSELout;

architecture memSELout_arch of memSELout is
    begin
    bufProcess : process(clk, reset)
        begin
        if reset = '1' then
            S <= (others => '0');
        elsif rising_edge(clk) then
            S <= E;
        end if;
    end process;
end memSELout_arch;