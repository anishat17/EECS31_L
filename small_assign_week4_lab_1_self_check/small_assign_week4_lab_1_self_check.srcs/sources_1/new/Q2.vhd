library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity final_prob2 is
    Port ( A: in STD_LOGIC_VECTOR (1 DOWNTO 0);
           B: in STD_LOGIC_VECTOR (1 DOWNTO 0);
           F: out STD_LOGIC_VECTOR (1 DOWNTO 0));
end final_prob2;

architecture Behavioral of final_prob2 is
begin
    process(A, B)
    begin
        F(0) <= A(0) AND B(0);
    end process;
end Behavioral;