
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity mux_8 is
	port (  X : in std_logic_vector(7 downto 0);
                OP : in std_logic_vector(2 downto 0);
                Z : out std_logic);
end mux_8;

architecture str8 of mux_8 is
	
begin
	

        Z<= (X(0) and (not OP(0)) and (not OP(1)) and (not OP(2)) )	or	(X(1) and OP(0) and (not OP(1)) and (not OP(2)) )	or	(X(2) and (not OP(0)) and OP(1) and (not OP(2)) )	or	(X(3) and OP(0) and OP(1) and (not OP(2)) )	or	(X(4) and (not OP(0)) and (not OP(1)) and OP(2) )	or	(X(5) and OP(0) and (not OP(1)) and OP(2) )	or	(X(6) and (not OP(0)) and OP(1) and OP(2) )	or	(X(7) and OP(0) and OP(1) and OP(2) );
	
end str8;
