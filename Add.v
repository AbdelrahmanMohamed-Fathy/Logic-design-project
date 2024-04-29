module Add (
    input signed [2:0] A,
    input signed [2:0] B,
    output reg signed[3:0] C
);
always @(*) begin
    C=A+B;
end
endmodule