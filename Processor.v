// Processor that can add the contents of two registers and store result in another register
module Processor(instruction, clk, dummyOut);
  input clk;
  input [31:0] instruction;
  
  output reg dummyOut;
  
  /*    regFile     */
  //inputs
  reg[4:0] writeReg, readReg1, readReg2;
  reg[31:0] writeRegData;
  //outputs
  wire [31:0] regData1, regData2;
  
  /*   ALU   */
  //inputs
  reg [31:0] ALUPort1, ALUPort2;
  //ouputs
  wire [31:0] ALUResult;
  wire ALUZeroResult; //Set to 1 if the result of the result of the ALU operation is '0'
  

  /*   Delclare instances of modules   */
  regFile myRegFile(.readAddress0(readReg1), .readAddress1(readReg2), .writeAddress(writeReg), .writeData(writeRegData), .writeEnable(1'b1), .clk(clk), .readData0(regData1), .readData1(regData2));
  ALU myALU(.ALUControl(4'b0010), .DataIn0(regData1), .DataIn1(regData2), .DataOut(ALUResult), .ZeroOut(ALUZeroResult));
  
  /*   Set dummyOut equal to 1   */
  initial begin
    dummyOut = 1;
  end
  
  always@(posedge clk)
  begin
    /*   Instruction Stage   */
    
    /*   Data Read Stage   */
    ALUPort1 = regData1;
    ALUPort2 = regData2;
    /*   Execution Stage   */
    writeRegData = ALUResult;
    
    /*   Data Memory Stage   */
    
    /* Write Back Stage   */
  end
endmodule

/*Structure of processor:
This is a test
Input: Instr, clk
Output: register file? (would need to make rF an output of regFle)

Control:
  - always@(instr[31:26]): update control lines to correct values for instruction
  - 
*/