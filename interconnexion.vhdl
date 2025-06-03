library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity interconnexion is
    port (
        SR_IN_L, SR_IN_R, clk, reset : in std_logic;
        A_IN, B_IN, SEL_FCT, SEL_ROUTE : in std_logic_vector (3 downto 0);
        SEL_OUT : in std_logic_vector (1 downto 0);
        SR_OUT_L, SR_OUT_R : out std_logic;
        RES_OUT : out std_logic_vector (7 downto 0)
    );
end interconnexion;

architecture interconnexion_arch of interconnexion is
    -- signal interne à l'interconnexion
    signal buf_A_IN, buf_B_IN : std_logic_vector (3 downto 0);
    signal buf_A_OUT, buf_B_OUT : std_logic_vector (3 downto 0);
    signal mem_CACHE1_IN, mem_CACHE2_IN : std_logic_vector (7 downto 0);
    signal mem_CACHE1_OUT, mem_CACHE2_OUT : std_logic_vector (7 downto 0);
    signal buf_SR_IN_LR_OUT : std_logic_vector (1 downto 0);
    signal buf_SR_IN_LR_IN : std_logic_vector (1 downto 0) := "00";
    signal S_UAL : std_logic_vector (7 downto 0);
    signal SR_OUT_LR : std_logic_vector (1 downto 0);
-- déclaration des catégories de composants au sein de l'interconnexion
component bufUAL is
    port (
        E : in std_logic_vector (3 downto 0);
        S : out std_logic_vector (3 downto 0);
        clk, reset : in std_logic
    );
end component;
component memCache is
    port (
        E : in std_logic_vector (7 downto 0);
        S : out std_logic_vector (7 downto 0);
        clk, reset : in std_logic
    );
end component;
component memSRin is
    port (
        E : in std_logic_vector (1 downto 0);
        S : out std_logic_vector (1 downto 0);
        clk, reset : in std_logic
    );
end component;
component UAL is
    port (
        A, B, SEL_FCT : in STD_LOGIC_VECTOR(3 downto 0);
        SR_IN_L, SR_IN_R : in STD_LOGIC;
        S : out STD_LOGIC_VECTOR(7 downto 0);
        SR_OUT_L, SR_OUT_R: out STD_LOGIC
    );
end component;
begin
    -- ajout de chaque composant
    UALut : UAL port map (
        A => buf_A_OUT,
        B => buf_B_OUT,
        SEL_FCT => SEL_FCT,
        SR_IN_L => buf_SR_IN_LR_OUT(1),
        SR_IN_R => buf_SR_IN_LR_OUT(0),
        SR_OUT_L => SR_OUT_LR(1),
        SR_OUT_R => SR_OUT_LR(0),
        S => S_UAL
    );
    bufferA : bufUAL port map (
        E => buf_A_IN,
        S => buf_A_OUT,
        clk => clk,
        reset => reset
    );
    bufferB : bufUAL port map (
        E => buf_B_IN,
        S => buf_B_OUT,
        clk => clk,
        reset => reset
    );
    MEM_CACHE1 : memCache port map (
        E => mem_CACHE1_IN,
        S => mem_CACHE1_OUT,
        clk => clk,
        reset => reset
    );
    MEM_CACHE2 : memCache port map (
        E => mem_CACHE2_IN,
        S => mem_CACHE2_OUT,
        clk => clk,
        reset => reset
    );
    buf_SR_IN_LR : memSRin port map (
        E => buf_SR_IN_LR_IN,
        S => buf_SR_IN_LR_OUT,
        clk => clk,
        reset => reset
    );
    -- processus
    trafficGestion : process(clk)
    begin
        if rising_edge(clk) then
            case SEL_ROUTE is
                when "0000" => -- stockage A_IN dans bufA
                    buf_A_IN <= A_IN;
                when "0001" => -- stockage de MEM_CACHE1 dans bufA (poids faibles)
                    buf_A_IN <= mem_CACHE1_OUT(3 downto 0);
                when "0010" => -- stockage de MEM_CACHE1 dans bufA (poids forts)
                    buf_A_IN <= mem_CACHE1_OUT(7 downto 4);
                when "0011" => -- stockage de MEM_CACHE2 dans bufA (poids faibles)
                    buf_A_IN <= mem_CACHE2_OUT(3 downto 0);
                when "0100" => -- stockage de MEM_CACHE2 dans bufA (poids forts)
                    buf_A_IN <= mem_CACHE2_OUT(7 downto 4);
                when "0101" => -- stockage de S dans bufA (poids faibles)
                    buf_A_IN <= S_UAL(3 downto 0);
                when "0110" => -- stockage de S dans bufA (poids forts)
                    buf_A_IN <= S_UAL(7 downto 4);
                when "0111" => -- stockage B_IN dans bufB
                    buf_B_IN <= B_IN;
                when "1000" => -- stockage de MEM_CACHE1 dans bufB (poids faibles)
                    buf_B_IN <= mem_CACHE1_OUT(3 downto 0);
                when "1001" => -- stockage de MEM_CACHE1 dans bufB (poids forts)
                    buf_B_IN <= mem_CACHE1_OUT(7 downto 4);
                when "1010" => -- stockage de MEM_CACHE2 dans bufB (poids faibles)
                    buf_B_IN <= mem_CACHE2_OUT(3 downto 0);
                when "1011" => -- stockage de MEM_CACHE2 dans bufB (poids forts)
                    buf_B_IN <= mem_CACHE2_OUT(7 downto 4);
                when "1100" => -- stockage de S dans bufB (poids faibles)
                    buf_B_IN <= S_UAL(3 downto 0);
                when "1101" => -- stockage de S dans bufB (poids forts)
                    buf_B_IN <= S_UAL(7 downto 4);
                when "1110" => -- stockage de S dans MEM_CACHE1
                    mem_CACHE1_IN <= S_UAL;
                when "1111" => -- stockage de S dans MEM_CACHE2
                    mem_CACHE2_IN <= S_UAL;
                when others =>
                    buf_A_IN <= (others => '0');
                    buf_B_IN <= (others => '0');
                    mem_CACHE1_IN <= (others => '0');
                    mem_CACHE2_IN <= (others => '0');
            end case;
        elsif falling_edge(clk) then
            case SEL_OUT is
                when "00" => -- RES_OUT = 0
                    RES_OUT <= (others => '0');
                when "01" => -- RES_OUT = MEM_CACHE1
                    RES_OUT <= mem_CACHE1_OUT;
                when "10" => -- RES_OUT = MEM_CACHE2
                    RES_OUT <= mem_CACHE2_OUT;
                when "11" => -- RES_OUT = S
                    RES_OUT <= S_UAL;
                when others =>
                    RES_OUT <= (others => '0');
            end case;
        end if;
    end process;
    SR_OUT_L <= SR_OUT_LR(1);
    SR_OUT_R <= SR_OUT_LR(0);
    buf_SR_IN_LR_IN <= SR_OUT_LR;
end interconnexion_arch;