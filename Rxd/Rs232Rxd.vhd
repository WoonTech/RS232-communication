----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:31:15 10/28/2020 
-- Design Name: 
-- Module Name:    Rs232Rxd - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Rs232Rxd is
			port( Reset, Clock16x, Rxd: in std_logic;
					DataOut1: out std_logic_vector (7 downto 0));
end Rs232Rxd;

architecture Rs232Rxd_Arch of Rs232Rxd is

		attribute enum_encoding: string;
-- state definitions
		type stateType is (stIdle, stData, stStop, stRxdCompleted);
		attribute enum_encoding of statetype: type is "00 01 11 10";
		signal presState: stateType;
		signal nextState: stateType;
		signal iReset,iRxd1, iRxd2, iClock1xEnable, iClock1x, iEnableDataOut: std_logic ;
		signal iClockDiv: std_logic_vector (3 downto 0) ;
		signal iDataOut1, iShiftRegister: std_logic_vector (7 downto 0) ;
		signal iNoBitsReceived: std_logic_vector (3 downto 0) ;
	
begin

		process (Clock16x)
		begin
		if Clock16x'event and Clock16x = '1' then

				if Reset = '1' or iReset = '1' then
						iRxd1 <= '1';
						iRxd2 <= '1';
						iClock1xEnable <= '0';
						iClockDiv <= (others=>'0');
				else
						iRxd1 <= Rxd;
						iRxd2 <= iRxd1;
						if iClock1xEnable = '1' then
							iClockDiv <= iClockDiv + '1';
						elsif iRxd1 = '0' and iRxd2 = '1' then
							iClock1xEnable <= '1';
						end if;
				end if;
		end if;
		
		end process;
		
		iClock1x <= iClockDiv(3);

		process (iClock1xEnable, iClock1x)
		begin
		if iClock1xEnable = '0' then
				iNoBitsReceived <= (others=>'0');
				iShiftRegister <= (others=>'0');
				presState <= stIdle;
		elsif iClock1x'event and iClock1x = '1' then
				iNoBitsReceived <= iNoBitsReceived + '1';
				presState <= nextState;
				if iEnableDataOut = '1' then
						iDataOut1 <= iShiftRegister;
				else
						iShiftRegister <= Rxd & iShiftRegister(7 downto 1);
				end if;
		end if;
		end process;
		
		DataOut1 <= iDataOut1;
		
		process (presState, iClock1xEnable, iNoBitsReceived)
		begin
		
		-- signal defaults
		iReset <= '0';
		iEnableDataOut <= '0';
		case presState is
				when stIdle =>
						if iClock1xEnable = '1' then
								nextState <= stData;
						else
								nextState <= stIdle;
						end if;
				when stData =>
						if iNoBitsReceived = "1001" then
								iEnableDataOut <= '1';
								nextState <= stStop;
						else
								iEnableDataOut <= '0';
								nextState <= stData;
						end if;
				when stStop =>
						nextState <= stRxdCompleted;
				when stRxdCompleted =>
						iReset <= '1';
						nextState <= stIdle;
		end case;
		end process;
end Rs232Rxd_Arch;