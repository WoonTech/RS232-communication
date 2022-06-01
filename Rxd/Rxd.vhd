----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:25:59 10/28/2020 
-- Design Name: 
-- Module Name:    Rxd - Behavioral 
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

entity Rxd is
    Port ( Rest : in  STD_LOGIC;
           Clock16x : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           DataOut1 : out  STD_LOGIC_VECTOR (7 downto 0));
end Rxd;

architecture Behavioral of Rxd is

begin


end Behavioral;

