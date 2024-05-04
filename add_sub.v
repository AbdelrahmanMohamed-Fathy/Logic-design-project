`timescale 1ns/100ps
module Add (
    input [2:0] num1,
    input [2:0] num2,
    input selection,
    output reg [3:0] result,
    output reg zeroflag
);
always @(*) begin
    result[3:0] = 4'b0000;
    if(selection)begin
        num2[2] = !num2[2];
    end
    if(!(num1[2]^num2[2]))begin
        result[2:0]=num1[1:0]+num2[1:0];
        result[3]=num1[2]&num2[2];
    end
    else begin
        if(num1[2]==1)begin
            result[2:0]=(~(num1[2:0])+num2[2:0]+1'b1);
        end
        else begin
            result[2:0]=((num1[2:0]+~(num2[2:0])+1'b1));
        end
        #100
        if(result[2]==1)begin
            result[3]=0;
        end
        else begin
            result[3]=1'b1;
            result[2:0]=~result[2:0]+1'b1;
        end
        result[2]=0;
    end
    if(num1[1:0]==0&&num2[1:0]==0)begin
        result[3:0]=0;
    end
    if(result[2:0]==3'b000)begin
        zeroflag=1;
    end
    else begin
        zeroflag=0;
    end
end
endmodule