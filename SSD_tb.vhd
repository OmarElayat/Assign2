library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SSD_tb is
end entity;

architecture SSD_tb_arch of SSD_tb is
    component SSD
    port(
        SSD_in: In std_logic_vector(3 downto 0);
        SSD_out: Out std_logic_vector(6 downto 0)
    );
    end component;
    signal test_in: std_logic_vector(3 downto 0);
    signal test_out: std_logic_vector(6 downto 0);
begin
    dut: SSD
        port map(test_in,test_out);
   process
   begin
    for i in 0 to (2**4)-1 loop
        test_in <= std_logic_vector(to_unsigned(i,4));
        wait for 200 ns;
        end loop ;
    end process;

   process
        variable test_pass: boolean;
   begin
        wait on test_in;
        wait for 100 ns;
        if ((test_in = "0001" and test_out = "1111001") or
          (test_in   = "0010" and test_out = "0100100") or
          (test_in   = "0011" and test_out = "0110000") or
          (test_in   = "0100" and test_out = "0011001") or
          (test_in   = "0101" and test_out = "0010010") or
          (test_in   = "0110" and test_out = "0000010") or
          (test_in   = "0111" and test_out = "1111000") or
          (test_in   = "1000" and test_out = "0000000") or
          (test_in   = "1001" and test_out = "0011000") or
          (test_in   = "0000" and test_out = "1000000"))
      then
         test_pass := true;
      else
         test_pass := false;
      end if;
      -- error reporting
      assert test_pass
         report "test failed."
         severity note;
   end process;
end SSD_tb_arch;