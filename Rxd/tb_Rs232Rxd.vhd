--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:41:38 10/28/2020
-- Design Name:   
-- Module Name:   C:/Users/Wan Heng Woon/OneDrive/Desktop/project1/project_year4/HDL/tutorial/Lab-4/Rxd/tb_Rs232Rxd.vhd
-- Project Name:  Rxd
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Rs232Rxd
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
 
ENTITY tb_Rs232Rxd IS
END tb_Rs232Rxd;
 
ARCHITECTURE behavior OF tb_Rs232Rxd IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Rs232Rxd
    PORT(
         Reset : IN  std_logic;
         Clock16x : IN  std_logic;
         Rxd : IN  std_logic;
         DataOut1 : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal tb_Reset : std_logic := '1';
   signal tb_Clock16x : std_logic := '0';
   signal tb_Rxd : std_logic := '0';

 	--Outputs
   signal tb_DataOut1 : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant tb_Clock16x_period: time := 6.51 us;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Rs232Rxd PORT MAP (
          Reset => tb_Reset,
          Clock16x => tb_Clock16x,
          Rxd => tb_Rxd,
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
	
	Reset: process
	begin
		tb_Reset <= '1';
		wait for 3*tb_Clock16x_period;
		tb_Reset <= '0';
		wait;
	end process;
	
	-- produce enable signal
	process
	begin
		tb_rxd <= '1';
		wait for 5.5*tb_Clock16x_period;
		tb_rxd <= '0'; -- Start bit
		wait for 16*tb_Clock16x_period;
		tb_rxd <= '0'; -- Bit 0
		wait for 16*tb_Clock16x_period;
		tb_rxd <= '1'; -- Bit 1
		wait for 16*tb_Clock16x_period;
		tb_rxd <= '0'; -- Bit 2
		wait for 16*tb_Clock16x_period;
		tb_rxd <= '0'; -- Bit 3
		wait for 16*tb_Clock16x_period;
		tb_rxd <= '0'; -- Bit 4
		wait for 16*tb_Clock16x_period;
		tb_rxd <= '1'; -- Bit 5
		wait for 16*tb_Clock16x_period;
		tb_rxd <= '1'; -- Bit 6
		wait for 16*tb_Clock16x_period;
		tb_rxd <= '0'; -- Bit 7
		wait for 16*tb_Clock16x_period;
		tb_rxd <= '1'; -- Stop bit
		wait for 16*tb_Clock16x_period;
	wait;
	end process;

END;
