library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
    port(
        A: in std_logic_vector(3 downto 0);
        B: in std_logic_vector(3 downto 0);
        output: out std_logic_vector(20 downto 0)
    );
end top;

architecture top_arch of top is
    component mult4x4 is
        PORT (
           A: IN  std_logic_vector(3 downto 0);
           B: IN  std_logic_vector(3 downto 0);
           Y: OUT  std_logic_vector(7 downto 0)
           );
        end mult4x4 ;

    component BCD8
    port(
        B: In std_logic_vector(7 downto 0);
        P: Out std_logic_vector(9 downto 0)
    );
    end BCD8;

    component Add3
    port(
        A: In std_logic_vector(3 downto 0);
        P: Out std_logic_vector(3 downto 0)
    );
    end Add3;

    component SSD
    port(
        SSD_in: In std_logic_vector(3 downto 0);
        SSD_out: Out std_logic_vector(6 downto 0)
    );
    end SSD;

    signal multOut: std_logic_vector(7 downto 0);
    signal bcdOut: std_logic_vector(9 downto 0);

    signal bcdHun: std_logic_vector(3 downto 0);
begin
    multiplier: mult4x4
    port map(A => A, B=> B, Y =>multOut);
    
    encoder: BCD8
    port map(B => multOut, P => bcdOut);

    bcdHun <= "00" & bcdOut(9 downto 8);

    SSD_1: SSD
    port map(SSD_in => bcdHun, SSD_out => output(20 downto 14));

    SSD_2: SSD
    port map(SSD_in => bcdOut(7 downto 4), SSD_out => output(13 downto 7));

    SSD_3: SSD
    port map(SSD_in => bcdOut(3 downto 0), SSD_out => output(6 downto 0));

end top_arch;