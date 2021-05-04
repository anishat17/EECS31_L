library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity final_prob1 is
    Port ( k: in  STD_LOGIC;
           p: in  STD_LOGIC;
           s: in  STD_LOGIC;
           w: out STD_LOGIC);
end final_prob1;
architecture Behavioral of final_prob1 is
begin
    process(k, p, s)
    begin
        w <= (p AND (NOT k)) OR s;
    end process;
end Behavioral;