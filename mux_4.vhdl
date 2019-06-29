
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity mux_4 is
	port (  X : in std_logic_vector(3 downto 0);
                OP : in std_logic_vector(1 downto 0);
                Z : out std_logic);
end mux_4;

architecture str4 of mux_4 is
	
begin
	

        Z<= (X(0) and (not OP(0)) and (not OP(1)) )	or	(X(1) and OP(0) and (not OP(1)) )	or	(X(2) and (not OP(0)) and OP(1) )	or	(X(3) and OP(0) and OP(1) );
	
end str4;
