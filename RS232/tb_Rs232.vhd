--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:27:05 11/25/2020
-- Design Name:   
-- Module Name:   D:/Project/Year 4 Project/HDL/tutorial/Lab-4/RS232/tb_Rs232.vhd
-- Project Name:  RS232
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Rs232
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_Rs232 IS
END tb_Rs232;
 
ARCHITECTURE behavior OF tb_Rs232 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Rs232
    PORT(
         Reset : IN  std_logic;
         Clock16x : IN  std_logic;
         Send : IN  std_logic;
         DataIn : IN  std_logic_vector(7 downto 0);
         DataOut1 : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal tb_Reset : std_logic := '1';
   signal tb_Clock16x : std_logic := '0';
   signal tb_Send : std_logic := '0';
   signal tb_DataIn : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal tb_DataOut1 : std_logic_vector(7 downto 0);

   -- Clock period definitions
	constant tb_Clock16x_period : time := 6.51 us;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Rs232 PORT MAP (
          Reset => tb_Reset,
          Clock16x => tb_Clock16x,
          Send => tb_Send,
          DataIn => tb_DataIn,
          DataOut1 => tb_DataOut1
        );

   -- Clock process definitions
   Clock16x :process
   begin
		tb_Clock16x <= '0';
		wait for tb_Clock16x_period/2;
		tb_Clock16x <= '1';
		wait for tb_Clock16x_period/2;
   end process;
 
	Reset :process
	begin
		tb_Reset <= '1';
		wait for 3*tb_Clock16x_period/2;
		tb_Reset <= '0';
		wait;
	end process;


   process
   begin		
		tb_DataIn <="10101010";
		wait for 3*tb_Clock16x_period/2;
		tb_Send <= '1';
		wait for 5*tb_Clock16x_period/2;
		tb_Send <= '0';
		wait for 50*tb_Clock16x_period/2;
		tb_Send <= '1';
		wait for 20*tb_Clock16x_period/2;
		tb_Send <= '0';
		wait for 350*tb_Clock16x_period/2;
		tb_DataIn <="00001111";
		wait for 3*tb_Clock16x_period/2;
		tb_Send <= '1';
		wait for 5*tb_Clock16x_period/2;
		tb_Send <= '0';

      wait;
   end process;

END;
