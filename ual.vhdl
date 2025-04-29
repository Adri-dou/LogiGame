library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
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
    signal temp_shift    : STD_LOGIC_VECTOR(4 downto 0); -- Pour les décalages avec retenue
    signal temp_add_sub  : STD_LOGIC_VECTOR(4 downto 0); -- Addition/soustraction avec retenue
    signal temp_mult     : STD_LOGIC_VECTOR(7 downto 0); -- Multiplication 4x4 bits
begin

process(A, B, SR_IN_L, SR_IN_R, SEL_FCT)
begin
    -- Initialisation des retenues
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
            SR_OUT_R <= A(0);                      -- Bit sortant
            temp_shift <= SR_IN_L & A;             -- Décalage avec retenue
            S <= "0000" & temp_shift(4 downto 1);  -- Résultat
        
        -- Décalage gauche A avec SR_IN_R
        when "1001" => 
            SR_OUT_L <= A(3);                     -- Bit sortant
            temp_shift <= A & SR_IN_R;            -- Décalage avec retenue
            S <= "0000" & temp_shift(3 downto 0); -- Résultat
        
        -- Décalage droit B avec SR_IN_L
        when "1010" => 
            SR_OUT_R <= B(0);                     -- Bit sortant
            temp_shift <= SR_IN_L & B;            -- Décalage avec retenue
            S <= "0000" & temp_shift(4 downto 1); -- Résultat
        
        -- Décalage gauche B avec SR_IN_R
        when "1011" => 
            SR_OUT_L <= B(3);                     -- Bit sortant
            temp_shift <= B & SR_IN_R;            -- Décalage avec retenue
            S <= "0000" & temp_shift(3 downto 0); -- Résultat
        
        -- Addition avec retenue entrante
        when "1100" => 
            temp_add_sub <= std_logic_vector(unsigned('0' & A) + unsigned('0' & B) + unsigned'('0' & SR_IN_R));
            S <= "000" & temp_add_sub;
            SR_OUT_R <= temp_add_sub(4);          -- Retenue
        
        -- Addition sans retenue
        when "1101" => 
            temp_add_sub <= std_logic_vector(unsigned('0' & A) + unsigned('0' & B));
            S <= "0000" & temp_add_sub(3 downto 0);
        
        -- Soustraction
        when "1110" => 
            temp_add_sub <= std_logic_vector(unsigned('0' & A) - unsigned('0' & B));
            S <= "0000" & temp_add_sub(3 downto 0);
        
        -- Multiplication
        when "1111" => 
            temp_mult <= std_logic_vector(unsigned(A) * unsigned(B));
            S <= temp_mult;
        
        -- Cas par défaut (NOP)
        when others => 
            S <= (others => '0');
    end case;
end process;

end Behavioral;