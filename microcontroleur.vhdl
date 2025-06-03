library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity microcontroleur is
    port(
        clk, reset : in std_logic;
        A_IN, B_IN: in std_logic_vector (3 downto 0);
        SR_OUT_L, SR_OUT_R : out std_logic;
        RES_OUT : out std_logic_vector (7 downto 0)
    );
end microcontroleur;

architecture microcontroleur_arch of microcontroleur is
    -- signaux internes du microcontrôleur
    signal SR_IN_L, SR_IN_R : std_logic := '0';
    signal SR_OUT_L_intern, SR_OUT_R_intern : std_logic;
    signal MEM_SEL_FCT_IN, SEL_ROUTE : std_logic_vector(3 downto 0);
    signal MEM_SEL_OUT_IN : std_logic_vector(1 downto 0);
    signal MEM_SEL_FCT_OUT : std_logic_vector(3 downto 0);
    signal MEM_SEL_OUT_OUT : std_logic_vector(1 downto 0);
-- déclaration de l'ensemble des types de composants intégrés dans le microcontrôleur
component interconnexion is
    port (
        SR_IN_L, SR_IN_R, clk, reset : in std_logic;
        A_IN, B_IN, SEL_FCT, SEL_ROUTE : in std_logic_vector (3 downto 0);
        SEL_OUT : in std_logic_vector (1 downto 0);
        SR_OUT_L, SR_OUT_R : out std_logic;
        RES_OUT : out std_logic_vector
    );
end component;
component mem_instruct is
    port (
        clk, reset : in std_logic;
        SEL_FCT, SEL_ROUTE : out std_logic_vector (3 downto 0);
        SEL_OUT : out std_logic_vector (1 downto 0)
    );
end component;
component memSELfct is
    port (
        E : in std_logic_vector (3 downto 0);
        S : out STD_LOGIC_VECTOR (3 downto 0);
        clk, reset : in std_logic
    );
end component;
component memSELout is
    port (
        E : in std_logic_vector (1 downto 0);
        S : out STD_LOGIC_VECTOR (1 downto 0);
        clk, reset : in std_logic
    );
end component;
begin
    -- ajout de chaque composant
    inteconnexion_ut : interconnexion port map (
        SR_IN_L => SR_IN_L,
        SR_IN_R => SR_IN_R,
        clk => clk,
        reset => reset,
        A_IN => A_IN,
        B_IN => B_IN,
        SEL_FCT => MEM_SEL_FCT_OUT,
        SEL_ROUTE => SEL_ROUTE,
        SEL_OUT => MEM_SEL_OUT_OUT,
        SR_OUT_L => SR_OUT_L,
        SR_OUT_R => SR_OUT_R,
        RES_OUT => RES_OUT
    );
    mem_instruct_ut : mem_instruct port map (
        clk => clk,
        reset => reset,
        SEL_FCT => MEM_SEL_FCT_IN,
        SEL_ROUTE => SEL_ROUTE,
        SEL_OUT => MEM_SEL_OUT_IN
    );
    memSELfct_ut : memSELfct port map (
        clk => clk,
        reset => reset,
        E => MEM_SEL_FCT_IN,
        S => MEM_SEL_FCT_OUT
    );
    memSELout_ut : memSELout port map (
        clk => clk,
        reset => reset,
        E => MEM_SEL_OUT_IN,
        S => MEM_SEL_OUT_OUT
    );
end microcontroleur_arch;