library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top_tb is
end top_tb;


architecture top_tb_arch of top_tb is
	component top
    port(
        A: in std_logic_vector(3 downto 0);
        B: in std_logic_vector(3 downto 0);
        res: out std_logic_vector(20 downto 0)
        );
    end component ;

    signal Ain, Bin: std_logic_vector (3 downto 0);
    signal Yout: std_logic_vector (20 downto 0);
begin
    toop: top
    port map(Ain,Bin,Yout);
	P1: process
	begin
		 for i in 0 to 15 loop
			for j in 0 to 15 loop
				Ain <= std_logic_vector(to_unsigned (i,4));
				Bin <= std_logic_vector(to_unsigned (j,4));
				wait for 100 ns;
			end loop;
		end loop;
	end process;
	   --verifier
   process
      variable test_pass: boolean;
      variable bcd_hun: std_logic_vector(7 downto 0);
      variable bcd_ten: std_logic_vector(7 downto 0);
      variable bcd_unit: std_logic_vector(7 downto 0);
      variable P_val: unsigned(11 downto 0);
      variable mul: unsigned(7 downto 0);
      begin
      wait on Ain, Bin;
      wait for 50 ns;
      mul := unsigned(A) * unsigned(B);
      bcd_hun := mul/100;
      bcd_ten := (mul mod 100)/10;
      bcd_unit := (mul mod 10);
      P_val := "00" & bcd_hun(1 downto 0) & bcd_ten(3 downto 0) & bcd_unit(3 downto 0);

      if (((P_val(11 downto 8) = "0001" and Yout(20 downto 14) = "1111001") or
          (P_val(11 downto 8)  = "0010" and Yout(20 downto 14) = "0100100") or
          (P_val(11 downto 8)  = "0011" and Yout(20 downto 14) = "0110000") or
          (P_val(11 downto 8)  = "0100" and Yout(20 downto 14) = "0011001") or
          (P_val(11 downto 8)  = "0101" and Yout(20 downto 14) = "0010010") or
          (P_val(11 downto 8)  = "0110" and Yout(20 downto 14) = "0000010") or
          (P_val(11 downto 8)  = "0111" and Yout(20 downto 14) = "1111000") or
          (P_val(11 downto 8)  = "1000" and Yout(20 downto 14) = "0000000") or
          (P_val(11 downto 8)  = "1001" and Yout(20 downto 14) = "0011000") or
          (P_val(11 downto 8)  = "0000" and Yout(20 downto 14) = "1000000")) and
         ((P_val(7 downto 4)   = "0001" and Yout(13 downto 7) = "1111001") or
          (P_val(7 downto 4)   = "0010" and Yout(13 downto 7) = "0100100") or
          (P_val(7 downto 4)   = "0011" and Yout(13 downto 7) = "0110000") or
          (P_val(7 downto 4)   = "0100" and Yout(13 downto 7) = "0011001") or
          (P_val(7 downto 4)   = "0101" and Yout(13 downto 7) = "0010010") or
          (P_val(7 downto 4)   = "0110" and Yout(13 downto 7) = "0000010") or
          (P_val(7 downto 4)   = "0111" and Yout(13 downto 7) = "1111000") or
          (P_val(7 downto 4)   = "1000" and Yout(13 downto 7) = "0000000") or
          (P_val(7 downto 4)   = "1001" and Yout(13 downto 7) = "0011000") or
          (P_val(7 downto 4)   = "0000" and Yout(13 downto 7) = "1000000")) and
         ((P_val(3 downto 0)   = "0001" and Yout(6 downto 0) = "1111001") or
          (P_val(3 downto 0)   = "0010" and Yout(6 downto 0) = "0100100") or
          (P_val(3 downto 0)   = "0011" and Yout(6 downto 0) = "0110000") or
          (P_val(3 downto 0)   = "0100" and Yout(6 downto 0) = "0011001") or
          (P_val(3 downto 0)   = "0101" and Yout(6 downto 0) = "0010010") or
          (P_val(3 downto 0)   = "0110" and Yout(6 downto 0) = "0000010") or
          (P_val(3 downto 0)   = "0111" and Yout(6 downto 0) = "1111000") or
          (P_val(3 downto 0)   = "1000" and Yout(6 downto 0) = "0000000") or
          (P_val(3 downto 0)   = "1001" and Yout(6 downto 0) = "0011000") or
          (P_val(3 downto 0)   = "0000" and Yout(6 downto 0) = "1000000")))
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
end architecture ; -- test