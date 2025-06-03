library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mem_instructtb is
end mem_instructtb;

architecture mem_instructtb_arch of mem_instructtb is
    signal clk, reset : std_logic;
    signal SEL_FCT, SEL_ROUTE : std_logic_vector (3 downto 0);
    signal SEL_OUT : std_logic_vector (1 downto 0);
component mem_instruct is
    port (
        clk : in std_logic;
        reset : in std_logic;
        SEL_FCT : out std_logic_vector (3 downto 0);
        SEL_ROUTE : out std_logic_vector (3 downto 0);
        SEL_OUT : out std_logic_vector (1 downto 0)
    );
end component;
begin
    mem_instruct_ut : mem_instruct port map (
        clk => clk,
        reset => reset,
        SEL_FCT => SEL_FCT,
        SEL_OUT => SEL_OUT,
        SEL_ROUTE => SEL_ROUTE
    );
    clkProcess : process
    begin
        clk <= '0'; wait for 10 ns;
        clk <= '1'; wait for 10 ns;
    end process;
    resetProcess : process
    begin
        reset <= '0'; wait for 500 ns;
        reset <= '1'; wait;
    end process;

end mem_instructtb_arch;