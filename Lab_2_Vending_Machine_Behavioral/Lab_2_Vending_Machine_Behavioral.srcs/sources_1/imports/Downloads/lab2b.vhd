----------------------------------------------------------------------
-- EECS31L Assignment 2
-- FSM Behavioral Model
----------------------------------------------------------------------
-- Student First Name : Shaoxuan
-- Student Last Name : Yuan
-- Student ID : 89832399
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

entity Lab2b_FSM is
    Port ( Input : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           Clk : in  STD_LOGIC;
           Permit : out  STD_LOGIC;
           ReturnChange : out  STD_LOGIC);
end Lab2b_FSM;

architecture Behavioral of Lab2b_FSM is

-- DO NOT modify any signals, ports, or entities above this line
-- Recommendation: Create 2 processes (one for updating state status and the other for describing transitions and outputs)
-- Figure out the appropriate sensitivity list of both the processes.
-- Use CASE statements and IF/ELSE/ELSIF statements to describe your processes.
-- add your code here
TYPE StateType IS
    (Init_State, Five_State, Ten_State, Fifteen_State, Twenty_State, Twenty_Plus_State, Cancel_State);
    
    Signal Current_State, Next_State: StateType;    
BEGIN

-- PROCESSES
CombLogic: PROCESS (Input, Current_State)
BEGIN
    -- Combinational Logic Process
    CASE Current_State IS
    
        WHEN Init_State =>
            Permit <= '0' ;
            ReturnChange <= '0';
            IF (Input = "000" OR Input = "111") THEN -- No bills inserted / Transaction cancelled
                Next_State <= Init_State;
                
                
            ELSIF (Input = "001") THEN -- Five bill inserted
                Next_state <= Five_State AFTER 10 ns;
                
            ELSIF (Input = "010") THEN -- Ten bill inserted
                Next_state <= Ten_State AFTER 10 ns;
            
            ELSIF (Input = "100") THEN -- Twenty bill inserted
                Next_state <= Twenty_State AFTER 5 ns;
            END IF;      
            
        WHEN Five_State =>
            IF (Input = "000") THEN -- No bills inserted
                Next_State <= Five_State;
                
            ELSIF (Input = "111") THEN -- Transaction cancelled
                Next_State <= Cancel_State;            
                
            ELSIF (Input = "001") THEN -- Five bill inserted            
                Next_state <= Ten_State AFTER 10 ns;
                
            ELSIF (Input = "010") THEN -- Ten bill inserted
                Next_state <= Fifteen_State AFTER 10 ns;
            
            ELSIF (Input = "100") THEN -- Twenty bill inserted
                Next_state <= Twenty_Plus_State AFTER 5 ns;
            END IF;    
            
        WHEN Ten_State =>
        
            IF (Input = "000") THEN -- No bills inserted
                Next_State <= Ten_State;
                
            ELSIF (Input = "111") THEN -- Transaction cancelled
                Next_State <= Cancel_State;            
                
            ELSIF (Input = "001") THEN -- Five bill inserted
                Next_state <= Fifteen_State AFTER 10 ns;
                
            ELSIF (Input = "010") THEN -- Ten bill inserted                          
                Next_state <= Twenty_State AFTER 5 ns;
                              
            ELSIF (Input = "100") THEN -- Twenty bill inserted
                Next_state <= Twenty_Plus_State AFTER 5 ns;
            END IF;    
            
        WHEN Fifteen_State =>
    
            IF (Input = "000") THEN -- No bills inserted
                Next_State <= Fifteen_State;
                
            ELSIF (Input = "111") THEN -- Transaction cancelled
                Next_State <= Cancel_State;            
                
            ELSIF (Input = "001") THEN -- Five bill inserted
                Next_state <= Twenty_State AFTER 5 ns;
                
            ELSIF (Input = "010") THEN -- Ten bill inserted
                Next_state <= Twenty_Plus_State AFTER 5 ns;
            
            ELSIF (Input = "100") THEN -- Twenty bill inserted
                Next_state <= Twenty_Plus_State AFTER 5 ns;

            END IF;    
            
        WHEN Twenty_State =>
    
            Permit <= '1' ;
            Next_State <= Init_State AFTER 10 ns;
            
            
        WHEN Twenty_Plus_State =>
        
            Permit <= '1' ;
            ReturnChange <= '1';
            Next_State <= Init_State AFTER 10 ns;
            
        WHEN Cancel_State =>
            ReturnChange <= '1';
            Next_State <= Init_State AFTER 10 ns;
        WHEN others =>
            
            
    END CASE;              
END PROCESS CombLogic;


StateRegister: PROCESS (Clk)
BEGIN
    IF (Clk = '1' AND Clk'EVENT) THEN
        Current_State <= Next_State;
    END IF;       
    -- State Register Process
END PROCESS StateRegister;
-- PROCESSES

END Behavioral;