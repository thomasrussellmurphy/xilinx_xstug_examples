-------------------------------------------------------------------------------- 
-- Copyright (c) 1996-2009 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Company: Xilinx 
-- \   \   \/    Design: PolyDecFilter
--  \   \        Version: 1.0
--  /   /        Filename: Accum.vhd
-- /___/   /\    Date Last Modified:  Aug 18, 2005
-- \   \  /  \   Date Created: July 14, 2005
--  \___\/\___\ 
-- 
--Device: Xilinx Virtex-4 (4vsx35-FF668-10) 
--Library: IEEE 
--Purpose: Polyphase Decimating Filter Example
--         Sub-level design file
--Reference: http://www.xilinx.com
--Tools: Synplicity Synplify 8.1, Xilinx ISE 7.1i, MTI ModelSim-SE 6.0
--Revision History: 
--    Rev 1.0 - First release, brianp, Aug 18, 2005 
-------------------------------------------------------------------------------- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Accum is
  port(
    din    : in  signed(47 downto 0);
    clk    : in  std_logic;
    ce     : in  std_logic;
    reset  : in  std_logic;
    sync   : in  std_logic;
    dout   : out signed(47 downto 0)
    );
end Accum;

architecture behavioral of Accum is

  attribute syn_useioff               : boolean;
  attribute syn_useioff of behavioral : architecture is false;

  signal acc_r0 : signed(47 downto 0);
  signal acc_r1 : signed(47 downto 0);

  attribute syn_dspstyle           : string;
  attribute syn_dspstyle of acc_r0 : signal is "dsp48";

begin
  dout <= acc_r1;
  
  Accum : process (clk)
  begin
    if rising_edge(clk) then
      if (reset = '1') then
        acc_r0 <= (others => '0');
        acc_r1 <= (others => '0');
      else
        if (ce = '1') then
          if (sync = '1') then
            acc_r0 <= din;              -- load accumulator
            acc_r1 <= acc_r0;           -- capture register
          else
            acc_r0 <= din + acc_r0;     -- accumulate
          end if;
        end if;
      end if;
    end if;
  end process Accum;

end behavioral;
