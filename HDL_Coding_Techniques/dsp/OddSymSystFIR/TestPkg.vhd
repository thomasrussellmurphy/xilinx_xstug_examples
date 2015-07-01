-------------------------------------------------------------------------------- 
-- Copyright (c) 1996-2009 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Company: Xilinx 
-- \   \   \/    Design: OddSymSystFIR
--  \   \        Version: 1.0
--  /   /        Filename: DelayLine.vhd
-- /___/   /\    Date Last Modified:  May 29, 2009
-- \   \  /  \   Date Created: July 14, 2005
--  \___\/\___\ 
-- 
--Device: Xilinx Virtex-6 
--Library: IEEE 
--Purpose: Symmetric Systolic FIR Filter with an Odd Number of Stages
--         Testbench package file.
--Reference: http://www.xilinx.com
--Tools: Xilinx ISE 11.2, MTI ModelSim-SE 6.3b
--Revision History: 
--    Rev 1.0 - First release
--    Rev 1.1 - Added header, wendling, May 29, 2009 
-------------------------------------------------------------------------------- 

library ieee;
use ieee.std_logic_1164.all;

package TestPkg is

type TestDataType is array (0 to 1023) of integer;
constant TestData :  TestDataType := (
 0, 
 0, 
 0, 
 0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 1, --23171, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0, 
 0, 
 0, 
 0, 
     0, 
0, 
0, 
0, 
     0  
);

end TestPkg;

package body TestPkg is
end TestPkg;
