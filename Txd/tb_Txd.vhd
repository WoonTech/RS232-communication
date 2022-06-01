--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:11:37 11/17/2020
-- Design Name:   
-- Module Name:   D:/Project/Year 4 Project/HDL/tutorial/Lab-4/Txd/tb_Txd.vhd
-- Project Name:  Txd
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Txd
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
 
ENTITY tb_Txd IS
END tb_Txd;
 
ARCHITECTURE behavior OF tb_Txd IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Rs232Txd
    PORT(
         DataIn : IN  std_logic_vector(7 downto 0);
         Send : IN  std_logic;
         Clock16x : IN  std_logic;
         Reset : IN  std_logic;
         Txd : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal tb_DataIn : std_logic_vector(7 downto 0) := (others => '0');
   signal tb_Send : std_logic := '0';
   signal tb_Clock16x : std_logic := '0';
   signal tb_Reset : std_logic := '1';

 	--Outputs
   signal tb_Txd : std_logic;

   -- Clock period definitions
   constant tb_Clock16x_period : time := 6.51 us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Rs232Txd PORT MAP (
          DataIn => tb_DataIn,
          Send => tb_Send,
          Clock16x => tb_Clock16x,
          Reset => tb_Reset,
          Txd => tb_Txd
        );

   -- Clock process definitions
   Clock16x :process
   begin
		tb_Clock16x <= '0';
		wait for tb_Clock16x_period/2;
		tb_Clock16x <= '1';
		wait for tb_Clock16x_period/2;
   end process;
	
	Reset: process
	begin
		tb_Reset <= '1';
		wait for 3*tb_Clock16x_period;
		tb_Reset <= '0';
		wait;
	end process;

   -- Stimulus process
   process
   begin		
      -- hold reset state for 100 ns.
		tb_DataIn <= "10101010";
      wait for 3*tb_Clock16x_period;	
		tb_Send <= '1';
		wait for 1*tb_Clock16x_period;	
		tb_Send <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
