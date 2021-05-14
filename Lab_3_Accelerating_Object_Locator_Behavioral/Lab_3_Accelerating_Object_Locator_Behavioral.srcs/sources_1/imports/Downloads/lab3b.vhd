----------------------------------------------------------------------
-- EECS31L Assignment 3
-- Locator Behavioral Model
----------------------------------------------------------------------
-- Student First Name : Shaoxuan
-- Student Last Name : Yuan
-- Student ID : 89832399
----------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

entity Locator_beh  is
    Port ( Clk : in  STD_LOGIC;
		   Start : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Loc : out  STD_LOGIC_VECTOR (15 downto 0);
           Done : out  STD_LOGIC);
end Locator_beh;

architecture Behavioral of Locator_beh is
   TYPE regArray_type IS 
      ARRAY (0 TO 7) OF std_logic_vector(15 DOWNTO 0); 
   SIGNAL regArray : regArray_type :=  (X"0000", X"000B", X"0023", X"0007", X"000A", X"0000", X"0000", X"0000");     
-- do not modify any code above this line
-- additional variables/signals can be declared if needed below
-- add your code starting here    
    TYPE Statetype IS (S_Start, S_Compute, S_End);
    SIGNAL Currstate, Nextstate: Statetype;
    SIGNAL location: STD_LOGIC_VECTOR (15 downto 0) := X"0000";
    SIGNAL test_location: STD_LOGIC_VECTOR (31 downto 0) := X"00000000";

begin
    PROCESS (Clk, Currstate)
    variable temp: std_logic_vector(31 DOWNTO 0):= X"00000000";
    BEGIN
    
    CASE Currstate IS
        WHEN S_Start =>
            Loc <= X"0000";
            Done <= '0';
            location <= X"0000";
            IF (Start = '1') THEN
                Nextstate <= S_Compute;
            END IF;
        WHEN S_Compute =>
            Loc <= X"0000";
            Done <= '0';
            -- at^2
            temp := regArray(1) * regArray(2);
            temp := temp(15 downto 0) * regArray(2);                     
            -- /2            
            temp := '0' & temp(31 downto 1);
            -- +v0t+x0
            temp := temp + regArray(3) * regArray(2) + regArray(4);
            location <= temp(15 downto 0);
            Nextstate <= S_End;
        WHEN S_End =>
            Loc <= location;
            Done <= '1';            
            Nextstate <= S_Start;        
    END CASE;

    IF (Clk = '1' AND Clk'EVENT) THEN
        IF (Rst = '1') THEN
            Currstate <= S_Start;
        ELSE
            Currstate <= Nextstate;
        END IF;
    END IF;
    
    END PROCESS;

end Behavioral;

