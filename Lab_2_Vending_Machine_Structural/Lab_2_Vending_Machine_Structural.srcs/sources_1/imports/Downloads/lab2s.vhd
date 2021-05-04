-- EECS31L Assignment 2
-- FSM Structural Model
----------------------------------------------------------------------
-- Student First Name : Shaoxuan
-- Student Last Name : Yuan
-- Student ID : 89832399
----------------------------------------------------------------------

-- Lab2s_FSM
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY Lab2s_FSM IS
     Port (Input : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           Clk : in  STD_LOGIC;
           Permit : out  STD_LOGIC;
           ReturnChange : out  STD_LOGIC);
END Lab2s_FSM;

ARCHITECTURE Structural OF Lab2s_FSM IS
-- DO NOT modify any signals, ports, or entities above this line
-- Required - there are multiple ways to complete this FSM; however, you will be restricted to the following as a best practice:
-- Create 2 processes (one for updating state status and the other for describing transitions and outputs)
-- For the combinatorial process, use Boolean equations consisting of AND, OR, and NOT gates while expressing the delay in terms of the NAND gates. 
-- Remember to use your calculated delay from the lab handout.
-- For the state register process, use IF statements. Remember to use the calculated delay from the lab handout.
-- Figure out the appropriate sensitivity list of both the processes.
-- add your code here
    ---------------------------------------------------
    Signal Current_State: STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    Signal Next_State: STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    ----------------------------------------------------
BEGIN

    StateRegister: PROCESS (Clk)
    BEGIN
        IF (Clk = '1' AND Clk'EVENT) THEN
            IF Next_State = "100" OR Next_State = "101" OR Next_State = "110" THEN -- twenty or twenty plus or cancel states
                Current_State <= Next_State; -- immediately register the state to push Permit forward in time
                                             -- and thus satisfy the Assert requirements in testbench
            ELSE
                Current_State <= Next_State AFTER 4 NS; -- 4 NS delay
            END IF;                            
            
        END IF;       
        -- State Register Process
    END PROCESS StateRegister;
    
    
    CombLogic: PROCESS (Input, Current_State)
    BEGIN
        IF (Input'EVENT AND NOT (Input = "000")) THEN -- only process when Input is not 000 (when it is active)
            Next_State(2) <= (NOT Current_State(2) AND Current_State(1) AND Current_State(0) AND NOT Input(2) AND
                NOT Input(1) AND Input(0)) OR (NOT Current_State(2) AND Current_State(1) AND NOT Input(2) AND
                Input(1) AND NOT Input(0)) OR (NOT Current_State(2) AND Input(2) AND NOT Input(1) AND NOT Input(0))
                OR (NOT Current_State(2) AND Input(2) AND Input(1) AND Input(0)) AFTER 5.6 NS;
            
            Next_State(1) <=  (NOT Current_State(2) AND NOT Current_State(1) AND Current_State(0) AND NOT Input(2) AND
                NOT Input(1) AND Input(0)) OR (NOT Current_State(2) AND Current_State(1) AND NOT Input(2) AND
                NOT Input(1) AND Input(0) AND NOT Current_State(0)) OR (NOT Current_State(2) AND Current_State(1) AND NOT Input(2) AND
                NOT Input(1) AND NOT Input(0)) OR (NOT Current_State(2) AND NOT Current_State(1) AND NOT Input(2) AND
                Input(1) AND NOT Input(0)) OR (NOT Current_State(2) AND Input(2) AND Input(1) AND Input(0)) AFTER 5.6 NS;
                
            Next_State(0) <= (NOT Current_State(2) AND NOT Current_State(0) AND NOT Input(2) AND NOT Input(1) AND Input(0)) OR
                (NOT Current_State(2) AND Current_State(1) AND Input(2) AND NOT Input(1) AND NOT Input(0)) OR
                (NOT Current_State(2) AND Current_State(0) AND NOT Input(1) AND NOT Input(0)) OR
                (NOT Current_State(2) AND Current_State(0) AND NOT Input(2) AND NOT Input(0)) AFTER 5.6 NS;               
       END IF;               
            
        Permit <= Current_State(2) AND NOT Current_State(1);
        
        ReturnChange <= (Current_State(2) AND NOT Current_State(1) AND Current_State(0)) OR
            (Current_State(2) AND Current_State(1) AND NOT Current_State(0));
                               
         IF (Current_State = "100" OR Current_State = "101" OR Current_State = "110") AND 
            (Input'EVENT AND (Input = "000")) THEN -- return to init
               Next_State <= "000";
         END IF;
                                      
    END PROCESS CombLogic;

END Structural;