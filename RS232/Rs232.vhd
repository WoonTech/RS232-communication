----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:04:55 11/22/2020 
-- Design Name: 
-- Module Name:    Rs232 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Rs232 is
			port( Reset, Clock16x, Send: in std_logic;
					DataIn: in std_logic_vector (7 downto 0);
					DataOut1: out std_logic_vector (7 downto 0));
end Rs232;

architecture Behavioral of Rs232 is
			signal int_DataOut : std_logic;

component Rs232Rxd is
			port( Reset, Clock16x, Rxd: in std_logic;
					DataOut1: out std_logic_vector (7 downto 0));
end component;

component Rs232Txd is
		 Port ( DataIn : in  STD_LOGIC_VECTOR (7 downto 0);
				  Send : in  STD_LOGIC;
				  Clock16x : in  STD_LOGIC;
				  Reset : in  STD_LOGIC;
				  Txd : out  STD_LOGIC);
end component;
		
begin
		
		U2: Rs232Txd port map(
						DataIn => DataIn,
						Send => Send,
						Clock16x => Clock16x,
						Reset => Reset,
						Txd => int_DataOut );
						
		U3: Rs232Rxd port map(
						Reset => Reset,			
						Clock16x => Clock16x,
						Rxd => int_DataOut ,
						DataOut1 => DataOut1);

end Behavioral;


