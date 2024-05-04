module multi(
    input [2:0] a,
    input [2:0] b,
    output reg [1:0] sum1,
    output reg [1:0] sum2, 
    output reg [4:0] product
);
   always@(*) begin
        if(b[0]==1'b1) assign sum1=a[1:0];
        else assign sum1=2'b00;
        if(b[1]==1'b1) assign sum2=a[1:0];
        else assign sum2=2'b00;

        assign product = sum1 + (sum2<<1) + ((a[2]^b[2])<<4);
   end
endmodule