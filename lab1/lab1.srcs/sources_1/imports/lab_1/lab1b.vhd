----------------------------------------------------------------------
-- Digital Design 101 Lab Assignment 1 - S21
-- LFDetector Behavioral Model
----------------------------------------------------------------------
-- Student First Name : Shaoxuan
-- Student Last Name : Yuan
-- Student ID : 89832399
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY LFDetector_behav IS
   PORT (Fuel3, Fuel2, Fuel1, Fuel0: IN std_logic;
         FuelWarningLight: OUT std_logic);
END LFDetector_behav;

ARCHITECTURE Behavior OF LFDetector_behav IS
BEGIN
-- DO NOT modify any signals, ports, or entities above this line
-- add your code below this line
    PROCESS(Fuel3, Fuel2, FUel1, Fuel0)
    BEGIN
        FuelWarningLight <= (NOT Fuel3) AND (NOT Fuel2);
    END PROCESS;
-- put your code in a PROCESS
-- use AND/OR/NOT keywords for behavioral function


END Behavior;