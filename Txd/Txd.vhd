----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:26:14 11/04/2020 
-- Design Name: 
-- Module Name:    Txd - Behavioral 
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

entity Rs232Txd is
    Port ( DataIn : in  STD_LOGIC_VECTOR (7 downto 0);
           Send : in  STD_LOGIC;
           Clock16x : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Txd : out  STD_LOGIC);
end Rs232Txd;

architecture Behavioral of Rs232Txd is
		attribute enum_encoding: string;
		-- state definitions
		type stateType is (stIdle, stData, stTxdStopandCompleted);
		attribute enum_encoding of stateType: type is "00 01 11";
		signal presState: stateType;
		signal nextState: stateType;
		signal iReset, iSend, iClock1xEnable, iEnableTxdBuffer,iEnableShift: std_logic;
		signal iTxdBuffer1: std_logic_vector (9 downto 0);
		signal iTxdBuffer2: std_logic_vector (9 downto 0);
		signal iTxdBuffer: std_logic_vector (9 downto 0);
		signal iClockDiv: std_logic_vector (3 downto 0);
		signal iClock1x: std_logic;
		signal iNoBitsSent: std_logic_vector (3 downto 0);
begin
		
		process (Clock16x)
		begin
		
		if Clock16x'event and Clock16x = '1' then
				--Reset signal
				if Reset = '1' or iReset = '1' then
						iClock1xEnable <= '0';
						iEnableTxdBuffer <= '0';
						iClockDiv <= (others=>'0');
						iSend <= '0';
				
				--Counter for iclock1x
				elsif iClock1xEnable = '1' then
						iClockDiv <= iClockDiv + '1';
				elsif iSend = '0' and Send = '1' then
							iClock1xEnable <= '1';
							--iTxdBuffer1 <= '1' & DataIn & '0';	
							iEnableTxdBuffer <= '1';
							iSend <= '1';
				end if;
				
		end if;
		
		end process;
		
		iClock1x <= iClockDiv(3);
		
		process (iClock1xEnable, iClock1x)
		begin
		
		
		if iClock1xEnable = '0' then
				iNoBitsSent <= (others=>'0');
				--iTxdBuffer2 <= "1111111111";
				iTxdBuffer <= "1111111111";
				presState <=stIdle;
				iEnableShift <= '0';	
				Txd <= '1';

		elsif iClock1x'event and iClock1x = '1' then
				--if bits = 10 bits / iEnableShift = 1
				if iEnableTxdBuffer = '1' then	
						if iEnableShift = '1' then					
							--iTxdBuffer2 <= '1' & iTxdBuffer2(9 downto 1);
							iTxdBuffer <= '1' & iTxdBuffer(9 downto 1);
							iNoBitsSent <= iNoBitsSent + '1';
							presState <= nextState;

						else
							--iTxdBuffer2 <= iTxdBuffer1;
							iTxdBuffer <= '1' & DataIn & '0';	
							iEnableShift <= '1';	
						end if;
						Txd <= iTxdBuffer(0);
				end if;
				
				if iTxdBuffer2(0) = '1' or iTxdBuffer2(0)= '0' then
						--iNoBitsSent <= iNoBitsSent + '1';
						--presState <= nextState;
				end if;
				
				
		end if;
		
		
		
		end process;
		
		
		
		--signal default
		Process(presState,iClock1xEnable,iNoBitsSent)
		begin
		iReset <='0';

		case presState is 
				when stidle =>
						if iClock1xEnable = '1' then
								nextState <= stData;
						else 
								nextState <= stIdle;
						end if;
				when stData =>
						if iNoBitsSent = "1001" then 	
								nextState <=  stTxdStopandCompleted;

						else
								nextState <= stData;
						end if;
				when  stTxdStopandCompleted =>
						iReset <= '1';
						nextState <= stIdle;
				end case;
		end process;

end Behavioral;

