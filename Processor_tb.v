/*  Every time an instruction is executed, update the register file variable by using the 
    "writtenReg" and "writtenRegData" outputs of the processor.  Have the register file be in 
    the monitor system call somehow (will probably have to make 32 different variables for each 
    register. Syntax of monitor: $monitor ("format_string", par_1, par_2, ... );
*/

module Processor_tb;

/*============DECLERATIONS============*/
  
  /*-----------Processor-----------*/
  //INPUTS
  reg clk;
  reg [31:0] instruction;
  reg [31:0] memoryDataOutOutput_processorInput;
  
  //Outputs
  wire [4:0] writtenRegAddress;
  wire [31:0] writtenRegData;
  wire [31:0] memoryInstAddrInput_processorOutput;
  wire [31:0] memoryDataAddrInput_processorOutput;
  wire [31:0] memoryDataInInput_processorOutput;
  wire memoryMemReadInput_processorOutput;
  wire memoryMemWriteInput_processorOutput;
  /*-----------End Processor-----------*/


  /*-----------Memory-----------*/
  //INPUTS
  reg [31:0] memoryInstAddrInput;
  reg [31:0] memoryDataAddrInput;
  reg [31:0] memoryDataInInput;
  reg memoryMemReadInput;
  reg memoryMemWriteInput;

  //OUTPUTS
  wire [31:0] memoryInstOutOutput;
  wire [31:0] memoryDataOutOutput;
  /*-----------End Memory-----------*/


  /*-----------Register Output Monitor-------------*/

  reg [31:0] rF [31:0];

  /*-----------End Register Output Monitor-----------*/

/*============END DECLERATIONS============*/





/*============MODULE INSTANCES============*/

Processor myProcessor(
	clk, 
	instruction, 
	memoryDataOutOutput_processorInput, 
		writtenRegAddressOutput, 
		writtenRegDataOutput, 
		memoryInstAddrInput_processorOutput, 
		memoryDataAddrInput_processorOutput, 
		memoryDataInInput_processorOutput, 
		memoryMemReadInput_processorOutput, 
		memoryMemWriteInput_processorOutput
);

Memory myMemory(
    .inst_addr(memoryInstAddrInput),
    .instr(memoryInstOutOutput),
	.data_addr(memoryDataAddrInput),
	.data_in(memoryDataInInput),
	.mem_read(memoryMemReadInput),
	.mem_write(memoryMemWriteInput),
	.data_out(memoryDataOutOutput)
);

/*============END MODULE INSTANCES============*/


/*============PROCESSOR TO MEMORY CONNECTIONS============*/
  /*-----------Set memory inputs equal to processor outputs-----------*/
  always@(memoryInstAddrInput_processorOutput or memoryDataAddrInput_processorOutput or memoryDataInInput_processorOutput or memoryMemReadInput_processorOutput or memoryMemWriteInput_processorOutput)
  begin
    memoryInstAddrInput = memoryInstAddrInput_processorOutput;
    memoryDataAddrInput = memoryDataAddrInput_processorOutput;
    memoryDataInInput = memoryDataInInput_processorOutput;
    memoryMemReadInput = memoryMemReadInput_processorOutput;
    memoryMemWriteInput = memoryMemWriteInput_processorOutput;
  end 
  /*-----------End set memory inputs equal to processor outputs-----------*/
 

  /*-----------Set processor inputs equal to memory outputs-----------*/
  always@(memoryInstOutOutput or memoryDataOutOutput)
  begin
    instruction = memoryInstOutOutput;
    memoryDataOutOutput_processorInput = memoryDataOutOutput;
  end
  /*-----------End set processor inputs equal to memory outputs-----------*/
/*============END PROCESSOR TO MEMORY CONNECTIONS============*/




/*============INITIALIZE CLOCK============*/
  initial begin
  clk = 0;
  end
  always #50clk=~clk; /* 10MHz clock (50*1ns*2) with 50% duty-cycle */
/*============END INITIALIZE CLOCK============*/




/*============MONITOR CHANGED REGISTERS============*/
  always@(writtenRegAddress or writtenRegData)
  begin
  end
/*============END MONITOR CHANGED REGISTERS============*/
  
endmodule