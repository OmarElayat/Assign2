LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

entity mult4x4_tb is end mult4x4_tb;
architecture test of mult4x4_tb is
	component mult4x4 is
	   PORT (
	      A: IN  std_logic_vector(3 downto 0);
	      B: IN  std_logic_vector(3 downto 0);
	      Y: OUT  std_logic_vector(7 downto 0)
	      );
	end component mult4x4;
    signal Ain, Bin: std_logic_vector (3 downto 0);
    signal Yout: std_logic_vector (7 downto 0);
begin
	mult: mult4x4 port map (
		Ain,
		Bin,
		Yout
	);
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
   begin
      wait on Ain, Bin;
      wait for 50 ns;
      if (Yout = std_logic_vector((unsigned(Ain) * unsigned(Bin) ) ))
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