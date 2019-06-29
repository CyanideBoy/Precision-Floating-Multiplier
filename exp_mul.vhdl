library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity exp_mul is
   port (
			ex1,ex2: in std_logic_vector(7 downto 0);
			outf: out std_logic_vector(15 downto 0)
         );
end entity;

architecture my of exp_mul is

	component fa8bit is
	port (a,b: in std_logic_vector(7 downto 0);
		  cin: in std_logic;
		  cout:out std_logic;
		  s: out std_logic_vector(7 downto 0));
	end component fa8bit;

	component mux_2 is
	port (  X0,X1 : in std_logic;
          OP : in std_logic;
           Z : out std_logic);
	end component mux_2;	
	
	component mux_4 is
	port (  X : in std_logic_vector(3 downto 0);
          OP : in std_logic_vector(1 downto 0);
           Z : out std_logic);
	end component mux_4;

	component mux_8 is
	port (  X : in std_logic_vector(7 downto 0);
          OP : in std_logic_vector(2 downto 0);
           Z : out std_logic);
	end component mux_8;

	component booth is
	port ( in1,in2: in std_logic_vector(7 downto 0);
		P: out std_logic_vector(15 downto 0));
	end component booth;
	
	signal a1,a2,ans,zt : std_logic_vector(7 downto 0);
	signal af: std_logic_vector(15 downto 0);
	signal s0,s1,sf,offs,gar1,gar2 : std_logic;
begin

	
	s0 <= ex1(7);
	s1 <= ex2(7);
	sf <= (s0 xor s1);

	a1(7 downto 4) <= "0001";
	a1(3 downto 0) <= ex1(3 downto 0);

	a2(7 downto 4) <= "0001";
	a2(3 downto 0) <= ex2(3 downto 0);


	mua : booth
	port map(in1=>a1,in2=>a2,P=>af);

	
	mux_2_1 : mux_2 port map( X0=>'0', X1=>'1', OP=>af(9), Z=>offs );
	
	
	fa1: fa8bit
	port map( a(7 downto 3)=>"00000", a(2 downto 0)=>ex1(6 downto 4), b=>"00001001",cin=>offs,cout=>gar1,s=>zt);

	fa2: fa8bit
	port map( a(7 downto 3)=>"00000", a(2 downto 0)=>ex2(6 downto 4), b=>zt,cin=>'0',cout=>gar2,s=>ans);

	outf(14 downto 10) <= ans(4 downto 0);
	outf(15) <= sf;
	
	gen1: for I in 2 to 9 generate 
		mux_2_I: mux_2 port map(X0=>af(I-2),X1=>af(I-1),OP=>offs,Z=>outf(I));
	end generate gen1;

	mux_2_I1: mux_2 port map(X0=>'0',X1=>af(0),OP=>offs,Z=>outf(1));

	outf(0)<= '0';

end my;
