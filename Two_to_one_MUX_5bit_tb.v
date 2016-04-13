module Two_to_one_MUX_5bit_tb; 
reg [4:0] A, B;
reg sel;
wire [4:0] out;

Two_to_one_MUX myMUX(.sel(sel), .A(A), .B(B), .out(out));

initial begin
  A = 5'b00000;
  B = 5'b00000;
  sel = 0;
  #100 B = 5'b00001;
  #100 A = 5'b00010; B = 5'b00100;
  #100 B = 5'b00001;
  
  #100 A = 5'b10000; B = 5'b00000;
  #100 sel = 1; 
  #100 B = 5'b00001;
  #100 A = 5'b00010; B = 5'b00100;
  #100 B = 5'b01000;

  
   #100 $finish;  //stop simulation
end

initial
  $monitor(
    "sel=%b A=%b B=%b out=%b",
    sel, A, B, out);

endmodule
