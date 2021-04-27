LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY TestBench IS
END TestBench;
ARCHITECTURE TestBenchArch OF TestBench IS
    COMPONENT UnitUnderTest IS
        PORT (a, b: IN std_logic;
              c: OUT std_logic);
    END COMPONENT;
    SIGNAL x, y, z: std_logic;
BEGIN
    CompToTest: UnitUnderTest PORT MAP (x, y, z);
    PROCESS
    BEGIN
        x <= '0'; y <= '1';
        WAIT FOR 10 ns;
        x <= '1';
        WAIT FOR 20 ns;
        x <= '0'; y <= '0';
        WAIT FOR 10 ns;
        x <= '1';
        WAIT FOR 20 ns;
       -- x <= '0'; y <= '1';
        --WAIT FOR 5 ns;
    END PROCESS;
END TestBenchArch;