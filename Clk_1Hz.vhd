LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Clk_1Hz IS
PORT ( Clk_in : IN STD_LOGIC;
      Clk_out : OUT STD_LOGIC );
END Clk_1Hz;

ARCHITECTURE Clock_1Hz OF Clk_1Hz IS
-- signal type is integer for data 25x106 (25 bits)
SIGNAL Counter : integer range 25000000 downto 0;
-- signal type is standard logic and define “Low”
SIGNAL Clk : STD_LOGIC := '0';
BEGIN
	PROCESS(Clk_in)
	BEGIN
	-- detect Positive Edge-Trigger
		if (rising_edge(Clk_in)) then
			Counter <= Counter + 1;
			if Counter >= 25000000 then
				Counter <= 0;
				Clk <= not(Clk);
			END IF;
		END IF;
	END PROCESS;
	Clk_out <= Clk;
END Clock_1Hz;