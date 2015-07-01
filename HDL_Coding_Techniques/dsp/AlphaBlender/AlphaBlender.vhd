-------------------------------------------------------------------------------- 
-- Copyright (c) 1996-2009 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Company: Xilinx 
-- \   \   \/    Design: AlphaBlender
--  \   \        Version: 1.1
--  /   /        Filename: AlphaBlender.vhd
-- /___/   /\    Date Last Modified:  May 12, 2009
-- \   \  /  \   Date Created: Apr 20, 2009
--  \___\/\___\ 
-- 
--Device: Xilinx Spartan-6 and Virtex-6 
--Library: IEEE 
--Purpose: An Alpha Blending function implemented on a single DSP block, taking
--         advantage of available pipelining, preadder, multiplier and postadder
--         features
--         Implements the alpha blender function in a DSP48A1 or DSP48E1, taking
--         care of all needed shifting and padding of the pixel and alpha
--         coefficient inputs, and extracting the proper bits for the blended
--         pixel
--         Top-level design file
--Reference: http://www.xilinx.com
--Tools: Xilinx ISE 11.2, MTI ModelSim-SE 6.3b
--Revision History: 
--    Rev 1.0 - First release, wendling, Apr 22, 2009 
--    Rev 1.1 - Code and header cleaning, wendling, May 12, 2009 
-------------------------------------------------------------------------------- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity AlphaBlender is
  generic (
    PixelWidth : natural := 8;
    AlphaWidth : natural := 8
    );  
  port(
    clk       : in  std_logic;
    alpha     : in  std_logic_vector(AlphaWidth-1 downto 0);
    pixel1    : in  std_logic_vector(PixelWidth-1 downto 0);
    pixel2    : in  std_logic_vector(PixelWidth-1 downto 0);
    pixelout  : out std_logic_vector(PixelWidth-1 downto 0)
    );
end AlphaBlender;

architecture behavioral of AlphaBlender is

  constant DspDataWidth    : natural := 18;
  constant DspCascadeWidth : natural := 48;
  
  constant AlphaPadding : std_logic_vector(AlphaWidth-1 downto 0) := (others => '0');
  
  signal ain      : std_logic_vector(DspDataWidth-1 downto 0);
  signal ain_r1   : std_logic_vector(DspDataWidth-1 downto 0) := (others => '0');
  signal ain_r2   : std_logic_vector(DspDataWidth-1 downto 0) := (others => '0');
  signal bin      : std_logic_vector(DspDataWidth-1 downto 0);
  signal cin      : std_logic_vector(DspCascadeWidth-1 downto 0);
  signal din      : std_logic_vector(DspDataWidth-1 downto 0);
  signal bin_r    : std_logic_vector(DspDataWidth-1 downto 0) := (others => '0');
  signal din_r    : std_logic_vector(DspDataWidth-1 downto 0) := (others => '0');
  signal cin_r1   : std_logic_vector(DspCascadeWidth-1 downto 0) := (others => '0');
  signal cin_r2   : std_logic_vector(DspCascadeWidth-1 downto 0) := (others => '0');
  signal cin_r3   : std_logic_vector(DspCascadeWidth-1 downto 0) := (others => '0');
  signal preadd_r : std_logic_vector(DspDataWidth-1 downto 0) := (others => '0');
  signal mult_r   : std_logic_vector(2*DspDataWidth-1 downto 0) := (others => '0');
  signal sum_r    : std_logic_vector(DspCascadeWidth-1 downto 0) := (others => '0');

begin

  bin <= ext(pixel1 & AlphaPadding, DspDataWidth);
  cin <= ext(pixel1 & AlphaPadding & AlphaPadding, DspCascadeWidth);
  din <= ext(pixel2 & AlphaPadding, DspDataWidth);
  ain <= ext(alpha, DspDataWidth);
  
  addmultadd : process (clk)
  begin
    if rising_edge(clk) then
      ain_r1   <= ain;            
      ain_r2   <= ain_r1;            
      bin_r    <= bin;            
      din_r    <= din;            
      cin_r1   <= cin;   
      cin_r2   <= cin_r1;   
      cin_r3   <= cin_r2;   
      preadd_r <= din_r - bin_r;  
      mult_r   <= preadd_r * ain_r2; 
      sum_r    <= mult_r + cin_r3;   
    end if;
  end process addmultadd;

  pixelout <= sum_r(2*AlphaWidth+PixelWidth-1 downto 2*AlphaWidth);

end behavioral;
