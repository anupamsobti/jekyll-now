----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:31:27 12/07/2011 
-- Design Name: 
-- Module Name:    anupam_dice_game - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity anupam_dice_game is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           switch : in  STD_LOGIC;
			  control: out STD_LOGIC_VECTOR(3 downto 0);
           data : out  STD_LOGIC_VECTOR (7 downto 0));
end anupam_dice_game;

architecture Behavioral of anupam_dice_game is
	
	type state is (s1,s2,s3,s4,s5,s6,s7,s8,s9);
	type state1 is (st1,st2,st3,st4);
	
	signal digit1,digit2,counter: INTEGER RANGE 1 to 6;
	signal digit: INTEGER RANGE 0 to 9;
	signal sum,store_sum: INTEGER RANGE 2 to 12;
	signal prstate,nxtstate : state;
	signal prstate1,nxtstate1 : state1;
	signal win,lose,play_again,flag: STD_LOGIC;

begin
	
	process(clk)
	begin
		if(rst='1') then
			prstate1 <= st1;
		elsif (clk'EVENT and clk='1') then
			prstate1 <= nxtstate1;
		end if;
	end process;
	
	process(prstate1,sum)
	begin
		case prstate1 is 
			when st1 =>
				win <= '0';
				lose <= '0';
				play_again <= '0';
				flag <= '0';
				
				if(sum =4 or sum =6 or sum =9) then
					nxtstate1 <= st2;
				elsif(sum =3 or sum =11) then
					nxtstate1 <= st3;
				else
					nxtstate1 <= st4;
				end if;
				
			when st2 =>
				win<='0';
				lose<='1';
				play_again<='1';
				flag<='0';
				
				if(sum=4 or sum=6 or sum =9) then
					nxtstate1 <= st2;
				elsif(sum=3 or sum=11) then
					nxtstate1 <= st3;
				else
					nxtstate1 <= st4;
				end if;
				
			when st3 =>
				win <='1';
				lose <= '0';
				play_again <='1';
				flag <= '0';
				
				if(sum =4 or sum =6 or sum =9) then
					nxtstate1 <= st2;
				elsif(sum =3 or sum = 11) then
					nxtstate1 <= st3;
				else
					nxtstate1 <= st4;
				end if;
				
			when st4 =>
				win <='0';
				lose <='0';
				play_again <='1';
				flag<='1';
				
				if(sum=store_sum) then
					nxtstate1 <= st3;
				elsif(sum =5 or sum=7 or sum=10) then
					nxtstate1 <= st2;
				else
					nxtstate1 <= st4;
				end if;
			end case;
	end process;

	process(clk)
	begin
		if(rst='1') then
			prstate <= s1;
		elsif(clk'event and clk='1') then
			prstate <= nxtstate;
		end if;
	end process;
	
	process(prstate)
	begin
		case prstate is
			when s1 => 
				control <= "0000";
				nxtstate <= s2;
			when s2 =>
				digit <= digit1;		-- Note that digit1 is the 8 bit std logic vector which should be decoded from the integral digit
				nxtstate <= s3;
			when s3 =>
				control <= "1000";
				nxtstate <= s4;
			when s4 =>
				control <= "0000";
				nxtstate <= s5;
			when s5 =>
				digit <= digit2;
				nxtstate <= s6;
			when s6 =>
				control <= "0100";
				nxtstate <= s7;
			when s7 =>
				control <= "0000";
				nxtstate <= s8;
			when s8 =>
				digit <= 9;
				nxtstate <= s9;
			when s9 =>
				control <= "0010";
				nxtstate <= s1;
		end case;
	end process;
	
	with digit select data <=
		"11111100" when 0,
		"01100000" when 1,
		"11011010" when 2,
		"11110010" when 3,
		"01100110" when 4,
		"10110110" when 5,
		"10111110" when 6,
		"11100000" when 7,
		"11111110" when 8,
		(7=> win,6 downto 5=>'0',4=> play_again,3 downto 2 => '0',1=> lose,0=>'0') when others;
		
		--		"11110110" when others;
	process(clk)
	begin
		if(counter =6) then
			counter <=1;
		elsif(clk'EVENT and clk='1') then
			counter <= counter+1;
		end if;
	end process;
	
	process(switch)
	begin
		if(switch'EVENT and switch ='1') then
			digit1 <= counter;
		end if;
	end process;
	
	process(switch)
	begin
		if(switch'EVENT and switch ='0') then
			digit2 <= counter;
		end if;
	end process;
	
	sum <= digit1 + digit2;
	
	process(flag)
	begin
		if(flag'EVENT and flag ='1') then
			store_sum <= sum;
		end if;
	end process;
	
end Behavioral;