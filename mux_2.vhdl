library ieee;
use ieee.std_logic_1164.all;

entity mux_2  is
  port (X0, X1: in std_logic;
	OP: in std_logic;
	Z: out std_logic);
end entity mux_2;

architecture str of mux_2 is

begin
	
	Z<= (X0 and (not OP)) OR  (X1 and OP);
end str;
