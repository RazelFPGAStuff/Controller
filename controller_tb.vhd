--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:23:36 04/02/2018
-- Design Name:   
-- Module Name:   C:/FPGA/FPGA 2014/OpalKelly/SourceCode_working/Controller/controller_tb.vhd
-- Project Name:  Controller
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Controller
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_textio.all;

library STD;
use std.textio.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY controller_tb IS
END controller_tb;
 
ARCHITECTURE behavior OF controller_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Controller
    PORT(
         CLK : IN  std_logic;
         DATA_IN : IN  std_logic_vector(7 downto 0);
         BYTE_READY : IN  std_logic;
         DATA_OUT : OUT  std_logic_vector(7 downto 0);
         MEM_ADR : OUT  std_logic_vector(6 downto 0);
         MEM_WE : OUT  std_logic;
         MEM_EN : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal DATA_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal BYTE_READY : std_logic := '0';

 	--Outputs
   signal DATA_OUT : std_logic_vector(7 downto 0);
   signal MEM_ADR : std_logic_vector(6 downto 0);
   signal MEM_WE : std_logic;
   signal MEM_EN : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Controller PORT MAP (
          CLK => CLK,
          DATA_IN => DATA_IN,
          BYTE_READY => BYTE_READY,
          DATA_OUT => DATA_OUT,
          MEM_ADR => MEM_ADR,
          MEM_WE => MEM_WE,
          MEM_EN => MEM_EN
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   
        ---declare variables
	
	variable k : integer;
	variable data : std_logic_vector(7 downto 0) := x"00";
	
	variable num_vector : std_logic_vector(7 downto 0)	:= x"7F"; -- 128 --max data
	
	
	---
   
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 
		--Set Clock
		BYTE_READY <= '1';
		DATA_IN <= b"01010001"; --[7:3] 10 ns or 50Mhz / 5 --> 10Mhz
		wait for 50 us;
		BYTE_READY <= '0';
		wait for 1 us;
		
		--LOAD 
		BYTE_READY <= '1';
		DATA_IN <= b"10000010";
		wait for 50 us;
		BYTE_READY <= '0';
		wait for 1 us;
		
		--# of vectors 1st 7-bit
		BYTE_READY <= '1';
		DATA_IN <= num_vector ; --b"00000100";
		wait for 50 us;		
		BYTE_READY <= '0';
		wait for 100 us;
		
		--################ SEND DATA HERE ################
		for k in 0 to 127 loop
			data := data + x"01";
			BYTE_READY <= '1';
			DATA_IN <= data;
			wait for 0.1 us;
			BYTE_READY <= '0';	
			wait for 0.1 us;
		end loop;
		
		
		--############ END ################################
	
		--RUN 
		BYTE_READY <= '1';
		DATA_IN <= b"10000011";
		wait for 50 us;
		BYTE_READY <= '0';
		wait for 1 us;	
	    --IDLE
	
		wait for 20 us;
		BYTE_READY <= '0';	
		
		
		wait for 1 ms;

      wait;
   end process;

END;
