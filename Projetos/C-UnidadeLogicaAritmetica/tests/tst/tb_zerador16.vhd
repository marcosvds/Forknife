-- Elementos de Sistemas
-- developed by RAfael C.
-- file: tb_zerador16.vhd
-- date: 4/4/2017

library ieee;
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_zerador16 is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_zerador16 is

  component zerador16 is
      port(z   : in STD_LOGIC;
           a   : in STD_LOGIC_VECTOR(15 downto 0);
           y   : out STD_LOGIC_VECTOR(15 downto 0)
         );
  end component;

  signal  a,y   : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
  signal  clk, z : STD_LOGIC := '0';

begin

	ze16: zerador16 port map(z,a,y);

  clock : process
  begin
    clk <= not clk;
    wait for 10 ns;
  end process;

  main : process
  begin
    test_runner_setup(runner, runner_cfg);
    wait until clk'event and clk='1';
    a <= x"FFFF";
    z <= '1';
    wait until clk'event and clk='1';
    assert(y = x"0000") report "a=0000, z=1";
    wait until clk'event and clk='1';
    a <= x"A5A5";
    z <= '0';
    wait until clk'event and clk='1';
    assert(y = x"A5A5") report "a=A5A5, z=0, y=A5A5";
    test_runner_cleanup(runner); -- Simulacao acaba aqui
  end process;
end architecture;
