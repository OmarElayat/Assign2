library library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BCD8 is
    port(
        B: In std_logic_vector(7 downto 0);
        P: Out std_logic_vector(9 downto 0)
    );
    end BCD8;

architecture BCD_imp of BCD8 is
    component Add3
    port(
        A: In std_logic_vector(3 downto 0);
        P: Out std_logic_vector(3 downto 0)
    );
    end Add3 ;
    
    signal S_c1 : std_logic_vector(3 downto 0)
    signal A_c2, S_c2 : std_logic_vector(3 downto 0)
    signal A_c3, S_c3 : std_logic_vector(3 downto 0)
    signal A_c4, S_c4 : std_logic_vector(3 downto 0)
    signal A_c5, S_c5 : std_logic_vector(3 downto 0)
    signal A_c6, S_c6 : std_logic_vector(3 downto 0)
    signal A_c7, S_c7 : std_logic_vector(3 downto 0)
    
    begin
        c1: Add3
        port map (
            A: "0" & B(7 downto 5);
            S: S_c1
        );
        c2: Add3
            port map(S_c1(2 downto 0)&B(4),S_c2);
        c3: Add3
            port map(S_c2(2 downto 0)&B(3),S_c3);
        c4: Add3
            port map(S_c3(2 downto 0)&B(2),S_c4);
        c5: Add3
            port map(S_c4(2 downto 0)&B(1),S_c5);
        c6: Add3
            port map("0" & S_c1(3) & S_c2(3) & S_c3(3),S_c6);
        c7: Add3
            port map(S_c6(2 downto 0) & S_c4(3), S_c7);
        P(9) <= S_c6(3);
        P(8 downto 5) <= S_c7;
        P(4 downto 1) <= S_c5;
        P(0) <= B(0);
    end BCD_imp;