----------------------------------------------------------------------
-- EECS31L Assignment 4 - Part 2
-- Locator Structural Model
----------------------------------------------------------------------
-- Student First Name : Shaoxuan
-- Student Last Name : Yuan
-- Student ID : 89832399
----------------------------------------------------------------------

---------- Components library ----------

---------- 8x16 Register File ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY RegFile IS
   PORT (R_Addr1, R_Addr2, W_Addr: IN std_logic_vector(2 DOWNTO 0);
         R_en, W_en: IN std_logic;
         Reg_Data1 : OUT std_logic_vector(15 DOWNTO 0); 
			Reg_Data2 : OUT std_logic_vector(15 DOWNTO 0); 
         W_Data: IN std_logic_vector(15 DOWNTO 0); 
         Clk, Rst: IN std_logic);
END RegFile;

ARCHITECTURE Beh OF RegFile IS 
   TYPE regArray_type IS 
      ARRAY (0 TO 7) OF std_logic_vector(15 DOWNTO 0); 
   SIGNAL regArray : regArray_type;
BEGIN
   WriteProcess: PROCESS(Clk)
   BEGIN
      IF (Clk = '1' AND Clk'EVENT) THEN
         IF (Rst = '1') THEN
            regArray(0) <= X"0000" AFTER 6.0 NS;
            regArray(1) <= X"000B" AFTER 6.0 NS;
            regArray(2) <= X"0023" AFTER 6.0 NS;
            regArray(3) <= X"0007" AFTER 6.0 NS;
            regArray(4) <= X"000A" AFTER 6.0 NS;
            regArray(5) <= X"0000" AFTER 6.0 NS;
            regArray(6) <= X"0000" AFTER 6.0 NS;
            regArray(7) <= X"0000" AFTER 6.0 NS;
         ELSE
            IF (W_en = '1') THEN
                regArray(conv_integer(W_Addr)) <= W_Data AFTER 6.0 NS;
                END IF;
        END IF;
     END IF;
   END PROCESS;
            
   ReadProcess1: PROCESS(R_en, R_Addr1, regArray)
   BEGIN
      IF (R_en = '1') THEN
        CASE R_Addr1 IS
            WHEN "000" =>
                Reg_Data1 <= regArray(0) AFTER 6.0 NS;
            WHEN "001" =>
                Reg_Data1 <= regArray(1) AFTER 6.0 NS;
            WHEN "010" =>
                Reg_Data1 <= regArray(2) AFTER 6.0 NS;
            WHEN "011" =>
                Reg_Data1 <= regArray(3) AFTER 6.0 NS;
            WHEN "100" =>
                Reg_Data1 <= regArray(4) AFTER 6.0 NS;
            WHEN "101" =>
                Reg_Data1 <= regArray(5) AFTER 6.0 NS;
            WHEN "110" =>
                Reg_Data1 <= regArray(6) AFTER 6.0 NS;
            WHEN "111" =>
                Reg_Data1 <= regArray(7) AFTER 6.0 NS;
            WHEN OTHERS =>
                Reg_Data1 <= (OTHERS=>'0') AFTER 6.0 NS;
        END CASE;
      ELSE
        Reg_Data1 <= (OTHERS=>'0') AFTER 6.0 NS;
      END IF;
   END PROCESS;
	
	ReadProcess2: PROCESS(R_en, R_Addr2, regArray)
   BEGIN
      IF (R_en = '1') THEN
        CASE R_Addr2 IS
            WHEN "000" =>
                Reg_Data2 <= regArray(0) AFTER 6.0 NS;
            WHEN "001" =>
                Reg_Data2 <= regArray(1) AFTER 6.0 NS;
            WHEN "010" =>
                Reg_Data2 <= regArray(2) AFTER 6.0 NS;
            WHEN "011" =>
                Reg_Data2 <= regArray(3) AFTER 6.0 NS;
            WHEN "100" =>
                Reg_Data2 <= regArray(4) AFTER 6.0 NS;
            WHEN "101" =>
                Reg_Data2 <= regArray(5) AFTER 6.0 NS;
            WHEN "110" =>
                Reg_Data2 <= regArray(6) AFTER 6.0 NS;
            WHEN "111" =>
                Reg_Data2 <= regArray(7) AFTER 6.0 NS;
            WHEN OTHERS =>
                Reg_Data2 <= (OTHERS=>'0') AFTER 6.0 NS;
        END CASE;
      ELSE
        Reg_Data2 <= (OTHERS=>'0') AFTER 6.0 NS;
      END IF;
   END PROCESS;
END Beh;


---------- 16-Bit ALU ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;


ENTITY ALU IS
    PORT (Sel: IN std_logic;
            A: IN std_logic_vector(15 DOWNTO 0);
            B: IN std_logic_vector(15 DOWNTO 0);
            ALU_Out: OUT std_logic_vector (15 DOWNTO 0) );
END ALU;

ARCHITECTURE Beh OF ALU IS

BEGIN
    PROCESS (A, B, Sel)
         variable temp: std_logic_vector(31 DOWNTO 0):= X"00000000";
    BEGIN
        IF (Sel = '0') THEN
            ALU_Out <= A + B AFTER 12 NS;                
        ELSIF (Sel = '1') THEN
            temp := A * B ;
                ALU_Out <= temp(15 downto 0) AFTER 12 NS; 
        END IF;
          
    END PROCESS;
END Beh;


---------- 16-bit Shifter ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Shifter IS
   PORT (I: IN std_logic_vector(15 DOWNTO 0);
         Q: OUT std_logic_vector(15 DOWNTO 0);
         sel: IN std_logic );
END Shifter;

ARCHITECTURE Beh OF Shifter IS 
BEGIN
   PROCESS (I,sel) 
   BEGIN
         IF (sel = '1') THEN 
            Q <= I(14 downto 0) & '0' AFTER 4.0 NS;
         ELSE
            Q <= '0' & I(15 downto 1) AFTER 4.0 NS;
         END IF;   
   END PROCESS; 
END Beh;


---------- 2-to-1 Selector ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Selector IS
   PORT (sel: IN std_logic;
         x,y: IN std_logic_vector(15 DOWNTO 0);
         f: OUT std_logic_vector(15 DOWNTO 0));
END Selector;

ARCHITECTURE Beh OF Selector IS 
BEGIN
   PROCESS (x,y,sel)
   BEGIN
         IF (sel = '0') THEN
            f <= x AFTER 3.0 NS;
         ELSE
            f <= y AFTER 3.0 NS;
         END IF;   
   END PROCESS; 
END Beh;


---------- 16-bit Register ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Reg IS
   PORT (I: IN std_logic_vector(15 DOWNTO 0);
         Q: OUT std_logic_vector(15 DOWNTO 0);
         Ld: IN std_logic; 
         Clk, Rst: IN std_logic );
END Reg;

ARCHITECTURE Beh OF Reg IS 
BEGIN
   PROCESS (Clk)
   BEGIN
      IF (Clk = '1' AND Clk'EVENT) THEN
         IF (Rst = '1') THEN
            Q <= X"0000" AFTER 4.0 NS;
         ELSIF (Ld = '1') THEN
            Q <= I AFTER 4.0 NS;
         END IF;   
      END IF;
   END PROCESS; 
END Beh;

---------- 16-bit Three-state Buffer ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ThreeStateBuff IS
    PORT (Control_Input: IN std_logic;
          Data_Input: IN std_logic_vector(15 DOWNTO 0);
          Output: OUT std_logic_vector(15 DOWNTO 0) );
END ThreeStateBuff;

ARCHITECTURE Beh OF ThreeStateBuff IS
BEGIN
    PROCESS (Control_Input, Data_Input)
    BEGIN
        IF (Control_Input = '1') THEN
            Output <= Data_Input AFTER 2 NS;
        ELSE
            Output <= (OTHERS=>'Z') AFTER 2 NS;
        END IF;
    END PROCESS;
END Beh;

---------- Controller ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY Controller IS
    PORT(R_en: OUT std_logic;
         W_en: OUT std_logic;
         R_Addr1: OUT std_logic_vector(2 DOWNTO 0);
         R_Addr2: OUT std_logic_vector(2 DOWNTO 0);
         W_Addr: OUT std_logic_vector(2 DOWNTO 0);
         Reg_Data1_Sel: OUT std_logic;
         Reg_Data2_Sel: OUT std_logic;
         Shifter_Sel: OUT std_logic;
         Selector_Sel: OUT std_logic;
         ALU_sel : OUT std_logic;
         OutReg_Ld: OUT std_logic;
         Oe: OUT std_logic;
         Done: OUT std_logic;
         Start, Clk, Rst: IN std_logic); 
END Controller;


ARCHITECTURE Beh OF Controller IS
    TYPE Statetype IS (S_Start, Comp1, Comp1_Reg0, 
                                Comp2, Comp2_Reg0,
                                Comp3, Comp3_Reg0, Comp3_Reg1,
                                Comp4, Comp4_Reg0, Comp4_Reg1,
                                Comp5, Comp5_Reg0,
                                Comp6, Comp6_Reg0,
                                S_End);
    SIGNAL Currstate, Nextstate: Statetype;
BEGIN
    CombLogic: PROCESS(Start, Rst, Currstate)
    BEGIN
        IF (Rst = '1') THEN
            Oe <= '0' AFTER 11 NS;
            Done <= '0' AFTER 11 NS;
            Nextstate <= S_Start AFTER 11 NS;
        END IF;
        
        CASE Currstate IS
            WHEN S_Start =>
                IF (Start = '1') THEN
                    Nextstate <= Comp1 AFTER 11 NS;
                END IF;
                    
            WHEN Comp1 =>
                Reg_Data1_Sel <= '0';
                Reg_Data2_Sel <= '0';
                
                R_en <= '1' AFTER 11 NS;
                R_Addr1 <= "010" AFTER 11 NS;
                R_Addr2 <= "010" AFTER 11 NS;
                W_Addr <= "101" AFTER 11 NS;
                W_en <= '1' AFTER 11 NS;
                
                ALU_sel <= '1' AFTER 11 NS;
                Selector_Sel <= '1' AFTER 11 NS;
                
                OutReg_Ld <= '1' AFTER 11 NS;
                Oe <= '0' AFTER 11 NS;
                Nextstate <= Comp1_Reg0 AFTER 11 NS;
                
            WHEN Comp1_Reg0 =>
                Nextstate <= Comp2 AFTER 11 NS;  
                         
            WHEN Comp2 =>            
                Reg_Data1_Sel <= '1';
                Reg_Data2_Sel <= '0';
                
                R_en <= '1' AFTER 11 NS;
                R_Addr1 <= "001" AFTER 11 NS;
                R_Addr2 <= "001" AFTER 11 NS;
                W_Addr <= "101" AFTER 11 NS;
                W_en <= '1' AFTER 11 NS;
                
                ALU_sel <= '1' AFTER 11 NS;
                Selector_Sel <= '1' AFTER 11 NS;
                
                OutReg_Ld <= '1' AFTER 11 NS;
                Oe <= '0' AFTER 11 NS;
                Nextstate <= Comp2_Reg0 AFTER 11 NS;
                
            WHEN Comp2_Reg0 =>
                Nextstate <= Comp3 AFTER 11 NS;      
                
            WHEN Comp3 =>
                Reg_Data1_Sel <= '1';
                
                R_en <= '1' AFTER 11 NS;
                R_Addr1 <= "001" AFTER 11 NS;
                R_Addr2 <= "101" AFTER 11 NS;
                W_Addr <= "101" AFTER 11 NS;
                W_en <= '1' AFTER 11 NS;
                
                ALU_sel <= '1' AFTER 11 NS;
                Shifter_Sel <= '0' AFTER 11 NS;
                Selector_Sel <= '0' AFTER 11 NS;
                
                OutReg_Ld <= '1' AFTER 11 NS;
                Oe <= '0' AFTER 11 NS;       
                Nextstate <= Comp3_Reg0 AFTER 11 NS;       

            WHEN Comp3_Reg0 =>
                Nextstate <= Comp3_Reg1 AFTER 11 NS;

            WHEN Comp3_Reg1 =>
                Nextstate <= Comp4 AFTER 11 NS;     
                
            WHEN Comp4 =>
                Reg_Data1_Sel <= '0';
                Reg_Data2_Sel <= '0';
            
                R_en <= '1' AFTER 11 NS;
                R_Addr1 <= "010" AFTER 11 NS;
                R_Addr2 <= "011" AFTER 11 NS;
                W_Addr <= "110" AFTER 11 NS;
                W_en <= '1' AFTER 11 NS;
                
                ALU_sel <= '1' AFTER 11 NS;
                Selector_Sel <= '1' AFTER 11 NS;
                
                OutReg_Ld <= '1' AFTER 11 NS;
                Oe <= '0' AFTER 11 NS;
                Nextstate <= Comp4_Reg0 AFTER 11 NS;
                
            WHEN Comp4_Reg0 =>
                Nextstate <= Comp4_Reg1 AFTER 11 NS;

            WHEN Comp4_Reg1 =>
                Nextstate <= Comp5 AFTER 11 NS;    
                
            WHEN Comp5 =>
                Reg_Data1_Sel <= '0';
                Reg_Data2_Sel <= '0';
            
                R_en <= '1' AFTER 11 NS;
                R_Addr1 <= "101" AFTER 11 NS;
                R_Addr2 <= "110" AFTER 11 NS;
                W_Addr <= "111" AFTER 11 NS;
                W_en <= '1' AFTER 11 NS;
                
                ALU_sel <= '0' AFTER 11 NS;
                Selector_Sel <= '1' AFTER 11 NS;
                
                OutReg_Ld <= '1' AFTER 11 NS;
                Oe <= '0' AFTER 11 NS;    
                Nextstate <= Comp5_Reg0 AFTER 11 NS;

            WHEN Comp5_Reg0 =>
                Nextstate <= Comp6 AFTER 11 NS;               
                
            WHEN Comp6 =>
                Reg_Data1_Sel <= '1';
                Reg_Data2_Sel <= '0';
            
                R_en <= '1' AFTER 11 NS;
                R_Addr1 <= "111" AFTER 11 NS;
                R_Addr2 <= "100" AFTER 11 NS;
                W_Addr <= "111" AFTER 11 NS;
                W_en <= '1' AFTER 11 NS;
                ALU_sel <= '0' AFTER 11 NS;
                Selector_Sel <= '1' AFTER 11 NS;
                
                OutReg_Ld <= '1' AFTER 11 NS;            
                Oe <= '0' AFTER 11 NS;
                Nextstate <= Comp6_Reg0 AFTER 11 NS;
                
            WHEN Comp6_Reg0 =>
                Nextstate <= S_End AFTER 11 NS;
                    
                                        
            WHEN S_End =>
                W_en <= '0' AFTER 11 NS;
                R_en <= '0' AFTER 11 NS;
                OutReg_Ld <= '0' AFTER 11 NS;
                Done <= '1' AFTER 11 NS;
                Oe <= '1' AFTER 11 NS;
                Nextstate <= S_Start AFTER 11 NS;
                
            WHEN OTHERS =>
        END CASE;

    END PROCESS;
    
    StateReg: PROCESS(Clk)
    BEGIN
        IF (Clk = '1' AND Clk'EVENT) THEN            
            Currstate <= Nextstate AFTER 4 NS;
        END IF;
    END PROCESS;
    

END Beh;


---------- Locator (with clock cycle =  38 NS )----------
--         INDICATE YOUR CLOCK CYCLE TIME ABOVE      ----

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

entity Locator_struct is
    Port ( Clk : in  STD_LOGIC;
		   Start : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Loc : out  STD_LOGIC_VECTOR (15 downto 0);
           Done : out  STD_LOGIC);
end Locator_struct;

architecture Struct of Locator_struct is
    
    COMPONENT RegFile IS
        PORT (  R_Addr1, R_Addr2, W_Addr: IN std_logic_vector(2 DOWNTO 0);
                R_en, W_en: IN std_logic;
                Reg_Data1: OUT std_logic_vector(15 DOWNTO 0); 
				Reg_Data2: OUT std_logic_vector(15 DOWNTO 0);
                W_Data: IN std_logic_vector(15 DOWNTO 0); 
                Clk, Rst: IN std_logic );
    END COMPONENT;
    
    COMPONENT ALU IS
        PORT (Sel: IN std_logic;
                A: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
                B: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
                ALU_Out: OUT STD_LOGIC_VECTOR (15 DOWNTO 0) );
    END COMPONENT;

    COMPONENT Shifter IS
         PORT (I: IN std_logic_vector(15 DOWNTO 0);
               Q: OUT std_logic_vector(15 DOWNTO 0);
               sel: IN std_logic );
    END COMPONENT;

    COMPONENT Selector IS
        PORT (sel: IN std_logic;
              x,y: IN std_logic_vector(15 DOWNTO 0);
              f: OUT std_logic_vector(15 DOWNTO 0) );
    END COMPONENT;
   
    COMPONENT Reg IS
        PORT (I: IN std_logic_vector(15 DOWNTO 0);
              Q: OUT std_logic_vector(15 DOWNTO 0);
              Ld: IN std_logic; 
              Clk, Rst: IN std_logic );
    END COMPONENT;
    
    COMPONENT ThreeStateBuff IS
        PORT (Control_Input: IN std_logic;
              Data_Input: IN std_logic_vector(15 DOWNTO 0);
              Output: OUT std_logic_vector(15 DOWNTO 0) );
    END COMPONENT;
    
    COMPONENT Controller IS
       PORT(R_en: OUT std_logic;
            W_en: OUT std_logic;
            R_Addr1: OUT std_logic_vector(2 DOWNTO 0);
            R_Addr2: OUT std_logic_vector(2 DOWNTO 0);
            W_Addr: OUT std_logic_vector(2 DOWNTO 0);
            Reg_Data1_Sel: OUT std_logic;
            Reg_Data2_Sel: OUT std_logic;
            Shifter_sel: OUT std_logic;
            Selector_sel: OUT std_logic;
            ALU_sel : OUT std_logic;
            OutReg_Ld: OUT std_logic;
            Oe: OUT std_logic;
            Done: OUT std_logic;
            Start, Clk, Rst: IN std_logic); 
     END COMPONENT;
    -- do not modify any code above this line
    -- add signals needed below. hint: name them something you can keep track of while debugging/testing
    -- add your code starting here
    SIGNAL R_en_out, W_en_out, Shifter_sel_out, Selector_sel_out, ALU_sel_out, Ld_out, Oe_out, Done_out: std_logic;
    SIGNAL Reg_Data1_sel_out, Reg_Data2_sel_out: std_logic;
    SIGNAL Reg_Data1_selector_result, Reg_Data2_selector_result: std_logic_vector(15 DOWNTO 0);
    SIGNAL R_Addr1_out, R_Addr2_out, W_Addr_out: std_logic_vector(2 DOWNTO 0);
    SIGNAL Reg_Data1_out, Reg_Data2_out: std_logic_vector(15 DOWNTO 0);
    SIGNAL ALU_Result: STD_LOGIC_VECTOR (15 DOWNTO 0);
    SIGNAL Shifter_Result: std_logic_vector(15 DOWNTO 0);
    SIGNAL Selector_Result: std_logic_vector(15 DOWNTO 0);
    SIGNAL Reg_Result: std_logic_vector(15 DOWNTO 0);
    SIGNAL Location: std_logic_vector(15 DOWNTO 0);
    SIGNAL Reg_Data1_Result, Reg_Data2_Result: std_logic_vector(15 DOWNTO 0);
    SIGNAL ALU_Reg_Result, Shifter_Reg_Result: std_logic_vector(15 DOWNTO 0);
BEGIN 
    Controller_Part: Controller PORT MAP
    (R_en => R_en_out, 
    W_en => W_en_out, 
    R_Addr1 => R_Addr1_out, 
    R_Addr2 => R_Addr2_out, 
    W_Addr => W_Addr_out, 
    Reg_Data1_Sel => Reg_Data1_sel_out,
    Reg_Data2_Sel => Reg_Data2_sel_out,
    Shifter_sel => Shifter_sel_out,
    Selector_sel => Selector_sel_out, 
    ALU_sel => ALU_sel_out, 
    OutReg_Ld => Ld_out, 
    Oe => Oe_out, 
    Done => Done_out, 
    Start => Start, 
    Clk => Clk, 
    Rst => Rst);
    
    RegFile_Part: RegFile PORT MAP
    (R_Addr1 => R_Addr1_out,
    R_Addr2 => R_Addr2_out, 
    W_Addr => W_Addr_out,
    R_en => R_en_out, 
    W_en => W_en_out, 
    Reg_Data1 => Reg_Data1_out,
    Reg_Data2 => Reg_Data2_out,
    W_Data => Selector_Result,
    Clk => Clk,
    Rst => Rst);
        
    Reg_Data1_Selector: Selector PORT MAP
    (sel => Reg_Data1_sel_out,
    x => Reg_Data1_out,
    y => ALU_Reg_Result,
    f => Reg_Data1_selector_result); 
    
    Reg_Data2_Selector: Selector PORT MAP
    (sel => Reg_Data2_sel_out,
    x => Reg_Data2_out,
    y => Shifter_Reg_Result,
    f => Reg_Data2_selector_result); 
    
    Reg_Data1: Reg PORT MAP
    (I => Reg_Data1_selector_result,
    Q => Reg_Data1_result,
    Ld => Ld_out,
    Clk => Clk,
    Rst => Rst);
    
    Reg_Data2: Reg PORT MAP
    (I => Reg_Data2_selector_result,
    Q => Reg_Data2_result,
    Ld => Ld_out,
    Clk => Clk,
    Rst => Rst);
    
    ALU_Part: ALU PORT MAP
    (Sel => ALU_sel_out,
    A => Reg_Data2_result,
    B => Reg_Data1_result,
    ALU_Out => ALU_Result);
    
    ALU_Out_Reg: Reg PORT MAP
    (I => ALU_Result,
    Q => ALU_Reg_Result,
    Ld => Ld_out,
    Clk => Clk,
    Rst => Rst);
        
    Shifter_Part: Shifter PORT MAP
    (I => Reg_Data1_result,
    Q => Shifter_Result,
    sel => Shifter_sel_out);
    
    Shifter_Out_Reg: Reg PORT MAP
    (I => Shifter_Result,
    Q => Shifter_Reg_Result,
    Ld => Ld_out,
    Clk => Clk,
    Rst => Rst);
    
    Selector_Part: Selector PORT MAP
    (sel => Selector_sel_out,
    x => Shifter_Reg_Result,
    y => ALU_Reg_Result,
    f => Selector_Result);    
    
    ThreeStateBuff_Part: ThreeStateBuff PORT MAP
    (Control_Input => Oe_out,
    Data_Input => Selector_Result,
    Output => Location);
    
    PROCESS (Clk)
    BEGIN
        IF (Clk = '1' AND Clk'EVENT) THEN         
            Loc <= Location;
            Done <= Done_out;        
        END IF;
    END PROCESS;
    
end Struct;
