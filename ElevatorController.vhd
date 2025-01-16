library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ElevatorController is
  Port (
    clk          : in STD_LOGIC;
    rst          : in STD_LOGIC;
    floor_request: in STD_LOGIC_VECTOR(3 downto 0);
    door_open    : in STD_LOGIC;
    door_close   : in STD_LOGIC;
    button_2     : in STD_LOGIC; -- Button for selecting "2"
    button_show_state: in STD_LOGIC; -- Button for showing the state
    display      : out STD_LOGIC_VECTOR(6 downto 0); -- 7-segment display
    leds         : out STD_LOGIC_VECTOR(7 downto 0); -- LEDs for circular animation
    current_floor: out STD_LOGIC_VECTOR(3 downto 0)
  );
end ElevatorController;

architecture Behavioral of ElevatorController is
  signal state: STD_LOGIC_VECTOR(2 downto 0) := "000";
  signal digit_selected: STD_LOGIC := '0';
  signal display_value: STD_LOGIC_VECTOR(6 downto 0) := "0000010"; -- 7-segment encoding for "2"
  signal show_state_value: STD_LOGIC_VECTOR(6 downto 0) := "0111111"; -- 7-segment encoding for "1"
  signal animation_leds: STD_LOGIC_VECTOR(7 downto 0) := "10000000"; -- Circular animation pattern
  
begin
  process(clk, rst)
  begin
    if rst = '1' then
      state <= "000";
      digit_selected <= '0';
    elsif rising_edge(clk) then
      -- Elevator control logic here
      if button_2 = '1' then
        digit_selected <= '1';
        display <= display_value;
      elsif button_show_state = '1' then
        digit_selected <= '0';
        display <= show_state_value;
      else
        -- Implement elevator control logic based on other inputs
        -- You can add more conditions here to control the display
      end if;
      
      -- Elevator animation when changing floors
      if state /= "001" then
        -- Circular animation: Shift the pattern to the right
        animation_leds <= animation_leds(6 downto 0) & animation_leds(7);
      else
        -- Reset animation when the elevator reaches floor 1
        animation_leds <= "10000000";
      end if;
      
      leds <= animation_leds; -- Connect the animation to the LEDs
    end if;
  end process;
  
  -- Define your elevator control logic using "state" and other signals

end Behavioral;