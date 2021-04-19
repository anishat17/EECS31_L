----------------------------------------------------------------------
-- Digital Design 101 Lab Assignment 1 - S21
-- LFDetector Structural Model
----------------------------------------------------------------------
-- Student First Name : Shaoxuan
-- Student Last Name : Yuan
-- Student ID : 89832399
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY NAND2 IS
   PORT (x: IN std_logic;
         y: IN std_logic;
         F: OUT std_logic);
END NAND2;  

ARCHITECTURE behav OF NAND2 IS
BEGIN
   PROCESS(x, y)
   BEGIN
      F <= NOT (x AND y) AFTER 1.4 ns; 
   END PROCESS;
END behav;
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY LFDetector_structural IS
   PORT (Fuel3, Fuel2, Fuel1, Fuel0: IN std_logic;
         FuelWarningLight: OUT std_logic);
END LFDetector_structural;

ARCHITECTURE Structural OF LFDetector_structural IS

-- DO NOT modify any signals, ports, or entities above this line
-- add your code below this line
-- you should be declaring and connecting components in this code
-- you should not use a PROCESS for lab 1s
-- use the appropriate library component(s) specified in the lab handout
-- add the appropriate internal signals & wire your design below
    COMPONENT NAND2 IS
        PORT (a, b: IN std_logic;
              F: OUT std_logic);
    END COMPONENT;
    ----------------------------------------------------
    SIGNAL w1, w2, w3, w4: std_logic;
    
BEGIN
    NAND2_1: NAND2 PORT MAP (Fuel2, Fuel2, w1);
    NAND2_2: NAND2 PORT MAP (Fuel3, Fuel3, w2);
    NAND2_3: NAND2 PORT MAP (w1, w2, w3);
    NAND2_4: NAND2 PORT MAP (w3, w3, FuelWarningLight); 
END Structural;