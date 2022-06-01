----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:49:34 11/27/2020 
-- Design Name: 
-- Module Name:    SystemClock - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Rs232SystemClock is
    Port ( Reset : in  STD_LOGIC;
			  SystemClock : in  STD_LOGIC;
           Clock16x : out  STD_LOGIC);
end Rs232SystemClock;

architecture Behavioral of Rs232SystemClock is

		signal iCount9: std_logic_vector (8 downto 0);
		
begin
		process(SystemClock)
		begin
			if SystemClock'event and SystemClock = '1' then
				if Reset = '1' then
					iCount9 <= (others=>'0');
							
				elsif iCount9 = "101000101" then
						iCount9 <= (others=>'0');
					else 
						iCount9 <= iCount9 + '1';
				end if;
			end if;
		end process;
		
		Clock16x <= iCount9(8);

end Behavioral;

