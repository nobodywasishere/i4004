library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity top is
	port(
		led_r : out std_logic
	);
end top;

architecture synth of top is

begin
	led_r <= '1';
end;
