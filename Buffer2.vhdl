library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity buf2 is
    generic (
        N : integer := 2
    );
    port (
        e1 : in std_logic_vector (N-1 downto 0);
        reset : in std_logic;
        preset : in std_logic;
        clock : in std_logic;
        s1 : out std_logic_vector (N-1 downto 0)
    );
end buf2;

architecture buf2_Arch of buf2 is
    begin
        -- Processus explicite BufProc
        BufProc : process(clock, reset)
        begin
            -- Reset asynchrone sur niveau haut
            if reset = '1' then
                s1 <= (others => '0');
            elsif rising_edge(clock) then
                -- Preset synchrone sur niveau haut
                if preset = '1' then
                    s1 <= (others => '1');
                else
                    -- Bufferisation sur front montant de l'horloge d'entrée
                    s1 <= e1;
                end if;
            end if;
        end process;
    end buf2_Arch;
