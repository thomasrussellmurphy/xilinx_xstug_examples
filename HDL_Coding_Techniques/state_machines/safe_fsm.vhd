--
-- Finite State Machine Safe Implementation VHDL Coding Example
--   One-hot encoding
--   Recovery-only state
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/state_machines/safe_fsm.vhd
--
library ieee;
use ieee.std_logic_1164.all;

entity safe_fsm is

  port(
    clk : in  std_logic;
    rst : in  std_logic;
    c   : in  std_logic_vector(3 downto 0);
    d   : in  std_logic_vector(3 downto 0);
    q   : out std_logic_vector(3 downto 0));

end safe_fsm;

architecture behavioral of safe_fsm is

  type state_t is ( idle, state0, state1, state2, recovery );
  signal state, next_state : state_t;

  attribute fsm_encoding : string;
  attribute fsm_encoding of state : signal is "one-hot";
  attribute safe_implementation : string;
  attribute safe_implementation of state : signal is "yes";
  attribute safe_recovery_state : string;
  attribute safe_recovery_state of state : signal is "recovery";
  
begin

  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        state <= idle;
      else
        state <= next_state;
      end if;
    end if;
  end process;

  process(state, c, d)
  begin
  
    next_state <= state;

    case state is
      when idle =>
        if c(0) = '1' then
          next_state <= state0;
        end if;
        q <= "0000";

      when state0 =>
        if c(0) = '1' and c(1) = '1' then
          next_state <= state1;
        end if;
        q <= d;

      when state1 =>
        next_state <= state2;
        q <= "1100";

      when state2 =>
        if c(1) = '0' then
          next_state <= state1;
        elsif c(2) = '1' then
          next_state <= state2;
        elsif c(3) = '1' then
          next_state <= idle;
        end if;
        q <= "0101";

      when recovery =>
        next_state <= state0;
        q <= "1111";

    end case;

  end process;
  
end behavioral;
