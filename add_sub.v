module add_sub (
    input [2:0] num1,
    input [2:0] num2,
    input selection,
    output reg [4:0] result,
    output reg zeroflag
);
reg [2:0]num;
always @(*) begin
    result[4:0] = 5'b00000;
    num[1:0] = num2[1:0];
    if(selection) begin
        num[2] = !num2[2];
    end
    else begin
        num[2] = num2[2];
    end
    if(!(num1[2]^num[2])) begin
        result[2:0]=num1[1:0]+num[1:0];
        result[4]=num1[2]&num[2];
    end
    else begin
        if(num1[2]==1) begin
            result[2:0]=(~(num1[2:0])+num[2:0]+1'b1);
        end
        else begin
            result[2:0]=((num1[2:0]+~(num[2:0])+1'b1));
        end
        
        if(result[2]==1) begin
            result[4]=0;
        end
        else begin
            result[4]=1'b1;
            result[2:0]=~result[2:0]+1'b1;
        end
        result[2]=0;
    end
    if(num1[1:0]==0&&num2[1:0]==0) begin
        result[4:0]=0;
    end
    if(result[2:0]==3'b000) begin
        zeroflag=1;
    end
    else begin
        zeroflag=0;
    end
end
endmodule