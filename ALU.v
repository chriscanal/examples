module ALU(ALUControl, DataIn0, DataIn1, DataOut, ZeroOut);
  input [3:0] ALUControl;
  input signed [31:0] DataIn0, DataIn1;
  output reg signed [31:0] DataOut;
  output reg ZeroOut;

  always @ (ALUControl or DataIn0 or DataIn1)
  begin
    case (ALUControl)
      4'b0010: // add, lw, sw, addi, and addiu
	DataOut = DataIn0 + DataIn1;
      4'b0111: // set on less than
	begin
	  if (DataIn0 < DataIn1)
	    DataOut = 32'b00000000000000000000000000000001;
	  else
	    DataOut = 32'b00000000000000000000000000000000;
	end
      4'b0110: // beq
	begin
	  if ((DataIn0 - DataIn1) == 32'b00000000000000000000000000000000)
	    ZeroOut = 1;
	  else
	    ZeroOut = 0;
	end
    endcase
  end
endmodule
