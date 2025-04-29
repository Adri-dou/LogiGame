-- filepath: c:\Users\adido\Documents\Cours\EFREI\S6\VHDL\VHDL2\LogiGame\testual.vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testUAL is
end testUAL;

architecture Behavioral of testUAL is
    signal A        : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal B        : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal SR_IN_L  : STD_LOGIC := '0';
    signal SR_IN_R  : STD_LOGIC := '0';
    signal SEL_FCT  : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal S        : STD_LOGIC_VECTOR(7 downto 0);
    signal SR_OUT_L : STD_LOGIC;
    signal SR_OUT_R : STD_LOGIC;
begin

    uut: entity work.UAL
        port map (
            A        => A,
            B        => B,
            SR_IN_L  => SR_IN_L,
            SR_IN_R  => SR_IN_R,
            SEL_FCT  => SEL_FCT,
            S        => S,
            SR_OUT_L => SR_OUT_L,
            SR_OUT_R => SR_OUT_R
        );

    stim_proc: process
    begin
       
        -- NOP
        SEL_FCT <= "0000"; A <= "0001"; B <= "0010"; wait for 10 ns;
        report "NOP: S="  & " SR_OUT_L=" & std_logic'image(SR_OUT_L) & " SR_OUT_R=" & std_logic'image(SR_OUT_R);
        -- S = A
        SEL_FCT <= "0001"; A <= "1010"; wait for 10 ns;
        report "S=A: S=" & " SR_OUT_L=" & std_logic'image(SR_OUT_L) & " SR_OUT_R=" & std_logic'image(SR_OUT_R);
        -- S = B
        SEL_FCT <= "0010"; B <= "0101"; wait for 10 ns;
        report "S=B: S="  & " SR_OUT_L=" & std_logic'image(SR_OUT_L) & " SR_OUT_R=" & std_logic'image(SR_OUT_R);
        -- S = NOT A
        SEL_FCT <= "0011"; A <= "1100"; wait for 10 ns;
        report "S=NOT A: S="  & " SR_OUT_L=" & std_logic'image(SR_OUT_L) & " SR_OUT_R=" & std_logic'image(SR_OUT_R);
        -- S = NOT B
        SEL_FCT <= "0100"; B <= "0011"; wait for 10 ns;
        report "S=NOT B: S=" & " SR_OUT_L=" & std_logic'image(SR_OUT_L) & " SR_OUT_R=" & std_logic'image(SR_OUT_R);
        -- S = A AND B
        SEL_FCT <= "0101"; A <= "1100"; B <= "1010"; wait for 10 ns;
        report "S=A AND B: S=" & " SR_OUT_L=" & std_logic'image(SR_OUT_L) & " SR_OUT_R=" & std_logic'image(SR_OUT_R);
        -- S = A OR B
        SEL_FCT <= "0110"; A <= "1100"; B <= "1010"; wait for 10 ns;
        report "S=A OR B: S=" & " SR_OUT_L=" & std_logic'image(SR_OUT_L) & " SR_OUT_R=" & std_logic'image(SR_OUT_R);
        -- S = A XOR B
        SEL_FCT <= "0111"; A <= "1100"; B <= "1010"; wait for 10 ns;
        report "S=A XOR B: S=" & " SR_OUT_L=" & std_logic'image(SR_OUT_L) & " SR_OUT_R=" & std_logic'image(SR_OUT_R);
        -- Décalage droit A avec SR_IN_L
        SEL_FCT <= "1000"; A <= "1011"; SR_IN_L <= '1'; wait for 10 ns;
        report "SRL A: S=" & " SR_OUT_L=" & std_logic'image(SR_OUT_L) & " SR_OUT_R=" & std_logic'image(SR_OUT_R);
        -- Décalage gauche A avec SR_IN_R
        SEL_FCT <= "1001"; A <= "1011"; SR_IN_R <= '0'; wait for 10 ns;
        report "SRR A: S=" & " SR_OUT_L=" & std_logic'image(SR_OUT_L) & " SR_OUT_R=" & std_logic'image(SR_OUT_R);
        -- Décalage droit B avec SR_IN_L
        SEL_FCT <= "1010"; B <= "0110"; SR_IN_L <= '0'; wait for 10 ns;
        report "SRL B: S=" & " SR_OUT_L=" & std_logic'image(SR_OUT_L) & " SR_OUT_R=" & std_logic'image(SR_OUT_R);
        -- Décalage gauche B avec SR_IN_R
        SEL_FCT <= "1011"; B <= "0110"; SR_IN_R <= '1'; wait for 10 ns;
        report "SRR B: S=" & " SR_OUT_L=" & std_logic'image(SR_OUT_L) & " SR_OUT_R=" & std_logic'image(SR_OUT_R);
        -- Addition avec retenue entrante
        SEL_FCT <= "1100"; A <= "0111"; B <= "0001"; SR_IN_R <= '1'; wait for 10 ns;
        report "ADD with carry: S=" & " SR_OUT_L=" & std_logic'image(SR_OUT_L) & " SR_OUT_R=" & std_logic'image(SR_OUT_R);
        -- Addition sans retenue
        SEL_FCT <= "1101"; A <= "0111"; B <= "0001"; wait for 10 ns;
        report "ADD: S=" & " SR_OUT_L=" & std_logic'image(SR_OUT_L) & " SR_OUT_R=" & std_logic'image(SR_OUT_R);
        -- Soustraction
        SEL_FCT <= "1110"; A <= "1000"; B <= "0011"; wait for 10 ns;
        report "SUB: S=" & " SR_OUT_L=" & std_logic'image(SR_OUT_L) & " SR_OUT_R=" & std_logic'image(SR_OUT_R);
        -- Multiplication
        SEL_FCT <= "1111"; A <= "0011"; B <= "0100"; wait for 10 ns;
        report "MUL: S=" & " SR_OUT_L=" & std_logic'image(SR_OUT_L) & " SR_OUT_R=" & std_logic'image(SR_OUT_R);

        wait;
    end process;

end Behavioral;