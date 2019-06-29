-- A DUT entity is used to wrap your design.
--  This example shows how you can do this for the
--  two-bit adder.
library std;
use std.textio.all;
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
entity DUT is
   port(input_vector: in std_logic_vector(15 downto 0);        -- Length of the input vector = number of input bits in your design
       	output_vector: out std_logic_vector(15 downto 0));	  -- Length of the output vector = number of output bits in your design
end entity;

architecture DutWrap of DUT is
   component exp_mul is									  -- This is the file you have designed.
     port(ex1,ex2: in std_logic_vector(7 downto 0);
		outf: out std_logic_vector(15 downto 0));
   end component;
begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   add_instance: exp_mul
			port map (
					ex1 => input_vector(15 downto 8),					  -- map all inputs to input_vector and outputs to output_vector
					ex2 => input_vector(7 downto 0),					  -- This mapping must be followed while writing the tracefile
					outf => output_vector);
end DutWrap;

