`timescale 1ns/100ps
module Add_tb;
reg signed [2:0] A;
reg signed [2:0] B;
wire signed [3:0] C;

Add DUT
(
    .A(A),
    .B(B),
    .C(C)
);
integer i;
integer j;
integer fd;
initial begin
    fd=$fopen("add.txt","w");
    for(i=-3;i<=3;i=i+1) begin
        for(j=-3;j<=3;j=j+1) begin
            A=i[2:0];
            B=j[2:0];
            #10;
            $fdisplay(fd,"A(%d)+B(%d)=C(%d)",A,B,C);
            $display("A(%d)+B(%d)=%d",A,B,C);
        end
    end
    $finish();
    $fclose(fd);
end
endmodule