
-- VHDL Instantiation Created from source file Rs232Rxd.vhd -- 15:08:45 12/04/2020
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Rs232Rxd
	PORT(
		Reset : IN std_logic;
		Clock16x : IN std_logic;
		Rxd : IN std_logic;          
		DataOut1 : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	Inst_Rs232Rxd: Rs232Rxd PORT MAP(
		Reset => ,
		Clock16x => ,
		Rxd => ,
		DataOut1 => 
	);


