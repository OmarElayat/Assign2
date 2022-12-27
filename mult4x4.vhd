LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

entity mult4x4 is
	   PORT (
	      A: IN  std_logic_vector(3 downto 0);
	      B: IN  std_logic_vector(3 downto 0);
	      Y: OUT  std_logic_vector(7 downto 0)
	      );
end entity ; -- mult4x4

architecture arch of mult4x4 is
begin
	Y <= std_logic_vector(unsigned(A) * unsigned(B));
end architecture ; -- arch