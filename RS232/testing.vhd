----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:51:29 11/04/2020 
-- Design Name: 
-- Module Name:    Rs232Txd - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Rs232Txd is
    Port ( dataIn : in  STD_LOGIC_VECTOR (7 downto 0);
           send : in  STD_LOGIC;
           clock16x : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           txd : out  STD_LOGIC);
end Rs232Txd;

architecture Behavioral of Rs232Txd is

	attribute enum_encoding: string;
	-- state definitions
	type stateType is (stIdle, stData, stStop, stTxdCompleted);
	attribute enum_encoding of stateType: type is "00 01 11 10";
	signal presState: stateType;
	signal nextState: stateType;
	signal iSend, iReset, iClock1xEnable, iEnableTxdBuffer, iEnableShift: std_logic;
	signal iTxdBuffer: std_logic_vector (9 downto 0);
	signal iTxdBuffer2: std_logic_vector (9 downto 0);
	signal iClockDiv: std_logic_vector (3 downto 0);
	signal iClock1x: std_logic;
	signal iNoBitsSent: std_logic_vector (3 downto 0);
begin
	
	process(clock16x)
	begin
		if rising_edge(clock16x) then
			if reset = '1' or iReset = '1' then
				iTxdBuffer <= (others=>'1');
				iClock1xEnable <= '0';
				iClockDiv <= (others=>'0');
				iEnableTxdBuffer <= '0';
			end if;
			
			if iClock1xEnable = '1' then
					iClockDiv <= iClockDiv + '1';
			
			--if rising edge and send is '1', enable clock1x and store dataIn into TxdBuffer
			elsif send = '1' then
				iClock1xEnable <= '1';
				iTxdBuffer <= '1' & DataIn(7 downto 0) & '0';
				iEnableTxdBuffer <= '1';
			end if;		
		end if;
	end process;
	
	iClock1x <= iClockDiv(3);
	
	--shift the data bit by bit into txd, while checking the number of bits sent
	process(iClock1xEnable, iClock1x)
	begin
		if iClock1xEnable = '0' then
			iNoBitsSent <= (others=>'0');
			presState <= stIdle;
			txd <= '1';
			
		elsif rising_edge(iClock1x) then
			presState <= nextState;
		end if;
		
		if rising_edge(iClock1x) then
			if iEnableTxdBuffer <= '1' and iReset = '0' then
				--if buffer is enabled but shifting is not enabled (not in stData yet), transfer the buffer	
				if iEnableShift = '1'  and iReset = '0' then
					txd <= iTxdBuffer2(0);
					iNoBitsSent <= iNoBitsSent + '1';
					iTxdBuffer2 <= '1' & iTxdBuffer2(9 downto 1);		
				else
					iTxdBuffer2 <= iTxdBuffer(9 downto 0);
				end if;
			end if;
		end if;
	end process;
	
	process(presState, iClock1xEnable, iNoBitsSent)
	begin
	-- signal defaults
	iReset <= '0';
	case presState is
			when stIdle =>
					if iClock1xEnable = '1' then
							nextState <= stData;
					else
							nextState <= stIdle;
					end if;
			when stData =>
					if iNoBitsSent = "1010" then
						iEnableShift <= '0';
						nextState <= stTxdCompleted;
					else
						iEnableShift <= '1';
						nextState <= stData;
					end if;
					
			when stStop =>
					nextState <= stTxdCompleted;
					
			when stTxdCompleted =>
					iReset <= '1';
					nextState <= stIdle;
	end case;
	end process;
	
end Behavioral;

