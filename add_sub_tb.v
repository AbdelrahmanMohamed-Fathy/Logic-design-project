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
integer signed i;
integer signed j;
integer temp1;
integer temp2;
integer fd;
integer signed c;
initial begin
    fd=$fopen("add.txt","w");
    for(i=-3;i<=3;i=i+1) begin
        for(j=-3;j<=3;j=j+1) begin
            if(i<0)begin
                temp1=16-i;
                num1=temp1;
                num1[2]=1;
            end
            else begin
                num1=i;
            end
            if(j<0)begin
                temp2=16-j;
                num2=temp2;
                num2[2]=1;
            end
            else begin
                num2=j;
            end
            c=num1+num2;
            #1000
            $fdisplay(fd,"Testing Num1=%b and Num2=%b",num1,num2);
            $display("Testing Num1=%b and Num2=%b",num1,num2);
            if(c<0)begin
                c=16-c;
                c[3]=1;
            end
            if(result==c[3:0])begin
                if(zeroflag==1)begin
                    $fdisplay(fd,"%b + %b = %b       Zero Result",num1,num2,result);
                    $display("%b + %b = %b       Zero Result",num1,num2,result);
                end
                else begin
                    $fdisplay(fd,"%b + %b = %b",num1,num2,result);
                    $display("%b + %b = %b",num1,num2,result); 
                end
            end
            else begin
                $error("Error in the result of addition of %b +%b !=%b %b",num1,num2,result,c[3:0]);
            end
        end
    end
    $finish();
    $fclose(fd);
end
endmodule