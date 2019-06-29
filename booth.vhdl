library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity booth is
   port (
			in1,in2: in std_logic_vector(7 downto 0);
			P: out std_logic_vector(15 downto 0)
         );
end entity;

architecture Struct of booth is

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

	signal a: std_logic_vector(15 downto 0);
	signal a_2: std_logic_vector(15 downto 0);
	signal a_m2: std_logic_vector(15 downto 0);
	signal a_m: std_logic_vector(15 downto 0);
	
	constant a0: std_logic_vector(15 downto 0) := "0000000000000000";
	
	signal s0,s1b,s2b,s3b,a_m_t,a_m2_t,z1,z2,z3,z4: std_logic_vector(15 downto 0);
	signal f1_c,f3_c,gar1,gar2,gar3,gar4,zk,zc,am2t1,am2t2,am2t3,am2t4: std_logic;
begin

	genMUXF: for I in 8 to 15 generate
		m2r_I: mux_2 port map(X0=>'0',X1=>'1',OP=>in1(7),Z=>a(I));
	end generate genMUXF;
	
	a(7 downto 0)<=in1;
	
	a_2(15 downto 1)<=a(14 downto 0);
	a_2(0)<='0';
	
	a_m2_t <= not a_2;
	a_m_t <= not a;
	
	fatp1: fa8bit port map(a=>a_m2_t(7 downto 0),b=>a0(7 downto 0),cin=>'1',cout=>am2t1,s=>a_m2(7 downto 0));
	fatp2: fa8bit port map(a=>a_m2_t(15 downto 8),b=>a0(7 downto 0),cin=>am2t1,cout=>am2t2,s=>a_m2(15 downto 8));
	
	fatp3: fa8bit port map(a=>a_m_t(7 downto 0),b=>a0(7 downto 0),cin=>'1',cout=>am2t3,s=>a_m(7 downto 0));
	fatp4: fa8bit port map(a=>a_m_t(15 downto 8),b=>a0(7 downto 0),cin=>am2t3,cout=>am2t4,s=>a_m(15 downto 8));
	
	
	genMUX1: for I in 0 to 15 generate
		m4_I: mux_4 port map(X(0)=>a0(I),X(1)=>a(I),X(2)=>a_m2(I),X(3)=>a_m(I),OP=>in2(1 downto 0),Z=>s0(I));
	end generate genMUX1;
	
	genMUX2: for I in 0 to 15 generate
		m8_1_I: mux_8 port map(X(0)=>a0(I),X(1)=>a(I),X(2)=>a(I),X(3)=>a_2(I),X(4)=>a_m2(I),X(5)=>a_m(I),X(6)=>a_m(I),X(7)=>a0(I),OP=>in2(3 downto 1),Z=>s1b(I));
	end generate genMUX2;
	

	genMUX3: for I in 0 to 15 generate
		m8_2_I: mux_8 port map(X(0)=>a0(I),X(1)=>a(I),X(2)=>a(I),X(3)=>a_2(I),X(4)=>a_m2(I),X(5)=>a_m(I),X(6)=>a_m(I),X(7)=>a0(I),OP=>in2(5 downto 3),Z=>s2b(I));
	end generate genMUX3;


	genMUX4: for I in 0 to 15 generate
		m8_3_I: mux_8 port map(X(0)=>a0(I),X(1)=>a(I),X(2)=>a(I),X(3)=>a_2(I),X(4)=>a_m2(I),X(5)=>a_m(I),X(6)=>a_m(I),X(7)=>a0(I),OP=>in2(7 downto 5),Z=>s3b(I));
	end generate genMUX4;
	
    f1: fa8bit port map(a=>s0(7 downto 0),b(7 downto 2)=>s1b(5 downto 0),b(1 downto 0)=>"00",cin=>'0',cout=>f1_c,s=>z1(7 downto 0));
    f2: fa8bit port map(a=>s0(15 downto 8),b(7 downto 0)=>s1b(13 downto 6),cin=>f1_c,cout=>gar1,s=>z1(15 downto 8));


    f3: fa8bit port map(a(7 downto 4)=>s2b(3 downto 0),a(3 downto 0)=>"0000",b(7 downto 6)=>s3b(1 downto 0),b(5 downto 0)=>"000000",cin=>'0',cout=>f3_c,s=>z2(7 downto 0));
    f4: fa8bit port map(a(7 downto 0)=>s2b(11 downto 4),b(7 downto 0)=>s3b(9 downto 2),cin=>f3_c,cout=>gar2,s=>z2(15 downto 8));


	faf1: fa8bit port map(a=>z1(7 downto 0),b=>z2(7 downto 0),cin=>'0',cout=>zc,s=>z3(7 downto 0));
	faf2: fa8bit port map(a=>z1(15 downto 8),b=>z2(15 downto 8),cin=>zc,cout=>gar3,s=>z3(15 downto 8));

	
	P<=z3;
	 
end Struct;
