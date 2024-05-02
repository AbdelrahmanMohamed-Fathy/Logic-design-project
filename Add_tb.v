`timescale 1ns/100ps
module Add_tb;
reg [2:0] num1;
reg [2:0] num2;
wire [3:0] result;
wire zeroflag;

Add DUT
(
    .num1(num1),
    .num2(num2),
    .result(result),
    .zeroflag(zeroflag)
);
integer i;
integer j;
integer fd;
initial begin
    fd=$fopen("add.txt","w");
    for(i=3'b000;i<=3'b111;i=i+1) begin
        for(j=3'b000;j<=3'b111;j=j+1) begin
            num1=i[2:0];
            num2=j[2:0];
            #1000
            $fdisplay(fd,"Testing Num1=%b and Num2=%b",num1,num2);
            $display("Testing Num1=%b and Num2=%b",num1,num2);
            if(zeroflag==1)begin
                $fdisplay(fd,"%b + %b = %b       Zero Result",num1,num2,result);
                $display("%b + %b = %b       Zero Result",num1,num2,result);
            end
            else begin
                $fdisplay(fd,"%b + %b = %b",num1,num2,result);
                $display("%b + %b = %b",num1,num2,result); 
            end
        end
    end
    $finish();
    $fclose(fd);
end
endmodule