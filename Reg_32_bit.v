module reg32 (clk, storedData, inputData, loadEnable, rst);
  input [31:0] inputData;
  input clk, rst, loadEnable;
  output [31:0] storedData;
  reg [31:0] storedData;
  always @ (posedge clk)
  if (rst) 
    #1 storedData = 0; 
  else 
    if (loadEnable)
      #1 storedData = inputData;
    else
      #1 storedData = storedData;
endmodule
