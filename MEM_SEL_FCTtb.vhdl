library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity memSELfcttb is
    generic (
        N : integer := 4
    );
end memSELfcttb;

architecture memSELfcttb_arch of memSELfcttb is
signal E1 : STD_LOGIC_VECTOR (N-1 downto 0) := (others => '0');
signal S1 : STD_LOGIC_VECTOR (N-1 downto 0);
signal clk, reset : std_logic;
component memSELfct is
    port (
        E : in std_logic_vector(N-1 downto 0);
        S : out std_logic_vector(N-1 downto 0);
        clk, reset : in std_logic
    );
end component;
begin
    clkProcess : process
    begin
        clk <= '0'; wait for 10 ns;
        clk <= '1'; wait for 10 ns;
    end process;
    E1Process : process(clk)
    begin
        if rising_edge(clk) then
            E1 <= STD_LOGIC_VECTOR(unsigned(E1) + 1);
        end if;
    end process;
    resetProcess : process
    begin
        reset <= '1'; wait for 40 ns;
        reset <= '0'; wait;
    end process;
    uut : memSELfct port map (
        E => E1,
        S => S1,
        clk => clk,
        reset => reset
    );   
end memSELfcttb_arch;