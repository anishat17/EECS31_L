LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY MyLogic IS
    PORT(i0, i1, i2: IN std_logic;
        d: OUT std_logic);
END MyLogic;

ARCHITECTURE Struct OF MyLogic IS

    COMPONENT And2 IS
        PORT (x, y: IN std_logic;
              f: OUT std_logic);
    END COMPONENT;

    COMPONENT CustomHW IS
        PORT (x: IN std_logic;
              f: OUT std_logic);
    END COMPONENT;

    SIGNAL n1, n2: std_logic;

BEGIN
    And2_1: And2 PORT MAP (i0, i2, n1);
    And2_2: And2 PORT MAP (i1, n2, d);
    CustHW: CustomHW PORT MAP (n1, n2);
END Struct;