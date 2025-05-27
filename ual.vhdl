library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UAL is
    Port (
        A          : in  STD_LOGIC_VECTOR(3 downto 0);   -- Entrée A sur 4 bits
        B          : in  STD_LOGIC_VECTOR(3 downto 0);   -- Entrée B sur 4 bits
        SR_IN_L    : in  STD_LOGIC;                      -- Retenue entrante gauche
        SR_IN_R    : in  STD_LOGIC;                      -- Retenue entrante droite
        SEL_FCT    : in  STD_LOGIC_VECTOR(3 downto 0);   -- Sélection de fonction
        S          : out STD_LOGIC_VECTOR(7 downto 0);   -- Sortie résultat sur 8 bits
        SR_OUT_L   : out STD_LOGIC;                      -- Retenue sortante gauche
        SR_OUT_R   : out STD_LOGIC                       -- Retenue sortante droite
    );
end UAL;

architecture Behavioral of UAL is
begin

process(A, B, SR_IN_L, SR_IN_R, SEL_FCT)
    -- Variables
    variable A_sur_8bits         : std_logic_vector(7 downto 0);
    variable B_sur_8bits         : std_logic_vector(7 downto 0);
begin
    -- Initialisation
    A_sur_8bits := "0000" & A;
    B_sur_8bits := "0000" & B;

    SR_OUT_L <= '0';
    SR_OUT_R <= '0';
    S <= (others => '0');

    case SEL_FCT is
        -- NOP
        when "0000" => 
            S <= (others => '0');
        
        -- S = A
        when "0001" => 
            S <= "0000" & A;
        
        -- S = B
        when "0010" => 
            S <= "0000" & B;
        
        -- S = NOT A
        when "0011" => 
            S <= "0000" & not A;
        
        -- S = NOT B
        when "0100" => 
            S <= "0000" & not B;
        
        -- S = A AND B
        when "0101" => 
            S <= "0000" & (A and B);
        
        -- S = A OR B
        when "0110" => 
            S <= "0000" & (A or B);
        
        -- S = A XOR B
        when "0111" => 
            S <= "0000" & (A xor B);

          -- Décalage droit A avec SR_IN_L
        when "1000" =>
            SR_OUT_R <= A(0);                     -- Bit sortant
            S(3) <= SR_IN_L;                      -- Bit entrant
            S(2 downto 0) <= A(3 downto 1);       -- Décalage
        
        -- Décalage gauche A avec SR_IN_R
        when "1001" => 
            SR_OUT_L <= A(3);                     -- Bit sortant
            S(0) <= SR_IN_R;                      -- Bit entrant
            S(3 downto 1) <= A(2 downto 0);       -- Décalage
        
        -- Décalage droit B avec SR_IN_L
        when "1010" => 
            SR_OUT_R <= B(0);                     -- Bit sortant
            S(3) <= SR_IN_L;                      -- Bit entrant
            S(2 downto 0) <= B(3 downto 1);       -- Décalage
        
        -- Décalage gauche B avec SR_IN_R
        when "1011" => 
            SR_OUT_L <= B(3);                     -- Bit sortant
            S(0) <= SR_IN_R;                      -- Bit entrant
            S(3 downto 1) <= B(2 downto 0);       -- Décalage         
    
        
        -- Addition avec retenue entrante
        when "1100" => 
            S <= A_sur_8bits + B_sur_8bits + ("0000000" & SR_IN_R);
        
        -- Addition sans retenue
        when "1101" => 
            S <= A_sur_8bits + B_sur_8bits;
        
        -- Soustraction
        when "1110" => 
            S <= A_sur_8bits - B_sur_8bits;

          -- Multiplication
        when "1111" => 
            S <= std_logic_vector(unsigned(A) * unsigned(B));
        
        -- Cas par défaut (NOP)
        when others => 
            S <= (others => '0');

    end case;
end process;

end Behavioral;