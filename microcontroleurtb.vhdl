library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity microcontroleurtb is
end microcontroleurtb;

architecture microcontroleurtb_arch of microcontroleurtb is
    signal clk, reset, SR_OUT_L, SR_OUT_R : std_logic;
    signal A_IN : std_logic_vector (3 downto 0) := "1110";
    signal B_IN : std_logic_vector (3 downto 0) := "0110";
    signal RES_OUT : std_logic_vector (7 downto 0);
component microcontroleur is
    port (
        clk, reset : in std_logic;
        A_IN, B_IN: in std_logic_vector (3 downto 0);
        SR_OUT_L, SR_OUT_R : out std_logic;
        RES_OUT : out std_logic_vector (7 downto 0)
    );
end component;
begin
    microcontroleur_ut : microcontroleur port map (
        clk => clk,
        reset => reset,
        A_IN => A_IN,
        B_IN => B_IN,
        SR_OUT_L => SR_OUT_L,
        SR_OUT_R => SR_OUT_R,
        RES_OUT => RES_OUT
    );
    clk_process : process
    begin
        clk <= '0'; wait for 10 ns;
        clk <= '1'; wait for 10 ns;
    end process;
    reset_process : process
    begin
        reset <= '0'; wait for 5000 ns;
        reset <= '1'; wait;
    end process;
end microcontroleurtb_arch;