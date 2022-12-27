library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity BCD8_tb is
end BCD8_tb;

architecture tb_arch of BCD8_tb is
    component BCD8
    port(
        B: In std_logic_vector(7 downto 0);
        P: Out std_logic_vector(9 downto 0)
    );
    end component;

    signal B_tb: std_logic_vector(7 downto 0);
    signal P_tb: std_logic_vector(9 downto 0);

begin
    DUT: BCD8
        port map(B_tb,P_tb);

    process
    begin
      for i in 0 to 255 loop
          B_tb <= std_logic_vector(to_unsigned(i,8));
          wait for 200 ns;
          end loop ;
    end process;

    process
        variable passed: boolean;
        variable B_val: unsigned(7 downto 0);
        variable P_val: unsigned (9 downto 0);
        variable P_hun_val: unsigned(1 downto 0);
        variable P_ten_val: unsigned(3 downto 0);
        variable P_unit_val: unsigned(3 downto 0);
    begin
        wait on B_tb;
        B_val <= unsigned(B_tb);
        wait for 100 ns;
        P_hun_val <= unsigned(P_tb)/100;
        P_ten_val <= (unsigned(P_tb) mod 100)/10;
        P_unit_val <= (unsigned(P_tb) mod 10);
        P_val <= P_hun_val & P_ten_val & P_unit_val;
        if(B_val = P_val) then
            passed := true;
        else
            passed := false;
        end if;
        assert passed
            report "test failed"
            severity note;
    end process;
end tb_arch;
        