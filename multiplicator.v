module multi(
    input [2:0] a,
    input [2:0] b,
    output reg [4:0] product,
    output reg zeroFlag
);
reg [1:0] sum1;
reg [1:0] sum2;
   always@(*) begin
        if(b[0]==1'b1) assign sum1=a[1:0];
        else assign sum1=2'b00;
        if(b[1]==1'b1) assign sum2=a[1:0];
        else assign sum2=2'b00;
        if(!(a[0]||a[1]) || !(b[0]||b[1])) assign zeroFlag = 1;
        else assign zeroFlag = 0;

        assign product = sum1 + (sum2<<1) + ((a[2]^b[2])<<4);
   end
endmodule