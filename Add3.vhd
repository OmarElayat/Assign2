library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Add3 is
    port( 
        A: In std_logic_vector(3 downto 0);
        S: Out std_logic_vector(3 downto 0)
    );
    end Add3 ;

architecture Add3_arch of Add3 is
    signal u: unsigned(3 downto 0);
    begin
        u <= unsigned(A);
        AddProc: process(A)
        begin
            if(u < 5) then
                S <= A;
            elsif(u > 4 or u <10) then
                S <= A + 3;
            else
                S <= 'X';
            end if;
        end process;
    end Add3_arch;