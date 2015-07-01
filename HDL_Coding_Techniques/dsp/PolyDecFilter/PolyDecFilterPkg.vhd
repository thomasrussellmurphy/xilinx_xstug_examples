-------------------------------------------------------------------------------- 
-- Copyright (c) 1996-2009 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Company: Xilinx 
-- \   \   \/    Design: PolyDecFilter
--  \   \        Version: 1.0
--  /   /        Filename: PolyDecFilterPkg.vhd
-- /___/   /\    Date Last Modified:  Aug 18, 2005
-- \   \  /  \   Date Created: July 14, 2005
--  \___\/\___\ 
-- 
--Device: Xilinx Virtex-4 (4vsx35-FF668-10) 
--Library: IEEE 
--Purpose: Polyphase Decimating Filter Example
--         Filter package file.  Compile into work lilbrary.
--Reference: http://www.xilinx.com
--Tools: Synplicity Synplify 8.1, Xilinx ISE 7.1i, MTI ModelSim-SE 6.0
--Revision History: 
--    Rev 1.0 - First release, brianp, Aug 18, 2005 
-------------------------------------------------------------------------------- 

library ieee;
use ieee.std_logic_1164.all;

package PolyDecFilterPkg is

type CoefArray is array (0 to 127) of integer;

constant Coefficients :  CoefArray := (
         761,
         207,
         222,
         227,
         219,
         195,
         154,
          91,
           6,
        -104,
        -241,
        -407,
        -602,
        -828,
       -1082,
       -1366,
       -1676,
       -2009,
       -2364,
       -2733,
       -3112,
       -3495,
       -3874,
       -4240,
       -4585,
       -4900,
       -5174,
       -5397,
       -5559,
       -5649,
       -5657,
       -5573,
       -5388,
       -5095,
       -4684,
       -4152,
       -3494,
       -2705,
       -1786,
        -737,
         439,
        1738,
        3153,
        4675,
        6294,
        7996,
        9767,
       11592,
       13453,
       15332,
       17209,
       19064,
       20877,
       22627,
       24294,
       25859,
       27303,
       28608,
       29758,
       30740,
       31540,
       32150,
       32560,
       32767,
       32767,
       32560,
       32150,
       31540,
       30740,
       29758,
       28608,
       27303,
       25859,
       24294,
       22627,
       20877,
       19064,
       17209,
       15332,
       13453,
       11592,
        9767,
        7996,
        6294,
        4675,
        3153,
        1738,
         439,
        -737,
       -1786,
       -2705,
       -3494,
       -4152,
       -4684,
       -5095,
       -5388,
       -5573,
       -5657,
       -5649,
       -5559,
       -5397,
       -5174,
       -4900,
       -4585,
       -4240,
       -3874,
       -3495,
       -3112,
       -2733,
       -2364,
       -2009,
       -1676,
       -1366,
       -1082,
        -828,
        -602,
        -407,
        -241,
        -104,
           6,
          91,
         154,
         195,
         219,
         227,
         222,
         207,
         761
);


end PolyDecFilterPkg;

package body PolyDecFilterPkg is
end PolyDecFilterPkg;
