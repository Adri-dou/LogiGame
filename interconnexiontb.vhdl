library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity interconnexiontb is
end interconnexiontb;

architecture interconnexiontb_arch of interconnexiontb is
    signal clk, reset, SR_OUT_L, SR_OUT_R : std_logic;
    signal SR_IN_L, SR_IN_R : std_logic := '0';
    signal A_IN : std_logic_vector (3 downto 0) := "1100";
    signal B_IN : std_logic_vector (3 downto 0) := "0111";
    signal SEL_FCT, SEL_ROUTE : std_logic_vector (3 downto 0) := "0000";
    signal SEL_OUT : std_logic_vector (1 downto 0) := "00";
    signal RES_OUT : std_logic_vector (7 downto 0);
component interconnexion is
    port (
        SR_IN_L, SR_IN_R, clk, reset : in std_logic;
        A_IN, B_IN, SEL_FCT, SEL_ROUTE : in std_logic_vector (3 downto 0);
        SEL_OUT : in std_logic_vector (1 downto 0);
        SR_OUT_L, SR_OUT_R : out std_logic;
        RES_OUT : out std_logic_vector (7 downto 0)
    );
end component;
begin
    interconnexion_ut : interconnexion port map(
        clk => clk,
        reset => reset,
        SR_IN_L => SR_IN_L,
        SR_IN_R => SR_IN_R,
        A_IN => A_IN,
        B_IN => B_IN,
        SEL_FCT => SEL_FCT,
        SEL_OUT => SEL_OUT,
        SEL_ROUTE => SEL_ROUTE,
        SR_OUT_L => SR_OUT_L,
        SR_OUT_R => SR_OUT_R,
        RES_OUT => RES_OUT
    );
    clkProcess : process
    begin
        clk <= '0'; wait for 10 ns;
        clk <= '1'; wait for 10 ns;
    end process;
    resetProcess : process
    begin
        reset <= '0'; wait for 700 ns;
        reset <= '1'; wait;
    end process;
    simulationProcess : process (clk)
    begin
        if rising_edge(clk) then
            SEL_FCT <= std_logic_vector(unsigned(SEL_FCT) + 1);
            SEL_ROUTE <= std_logic_vector(unsigned(SEL_ROUTE) + 1);
            SEL_OUT <= std_logic_vector(unsigned(SEL_OUT) + 1);
        end if;
    end process;
end interconnexiontb_arch;