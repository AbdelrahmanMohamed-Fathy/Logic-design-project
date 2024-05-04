//command to test: vsim add_sub_tb -c -do "run -all"
`timescale 1ns/100ps
module add_sub_tb();
reg [2:0] num1;
reg [2:0] num2;
reg selection;
wire [4:0] result;
wire zeroflag;

add_sub DUT
(
    .num1(num1),
    .num2(num2),
    .selection(selection),
    .result(result),
    .zeroflag(zeroflag)
);
integer addfile;
integer subfile;
integer i;
integer j;
integer sel;
integer signed signed_i;
integer signed signed_j;
reg [4:0] expectedResult;
initial begin
    file = $fopen("add.txt","w");
    file = $fopen("sub.txt","w");
    for(sel=0;sel<=1;sel=sel+1) begin
        for(i=0;i<=3'b111;i=i+1) begin
            for(j=0;j<=3'b111;j=j+1) begin
                num1=i;
                num2=j;
                selection=sel;
                #100
                if(i[2]) signed_i = -1*i[1:0];
                else signed_i = i[1:0];
                if(j[2]) signed_j = -1*j[1:0];
                else signed_j = j[1:0];
                #100
                if (selection) expectedResult = signed_i-signed_j;
                else expectedResult = signed_i+signed_j;
                #100
                if(expectedResult[4]) expectedResult[3:0] = ~expectedResult[3:0]+1;
                #100
                if(result==expectedResult && (zeroflag == !(expectedResult[3:0]))) begin
                    $display("[PASS] num1 = %b , num2 = %b , result = %b , zeroFlag = %b, operation = %b",num1,num2,result,zeroflag,selection);
                    if (selection)
                        $fdisplay(subfile,"[PASS] num1 = %b , num2 = %b , result = %b , zeroFlag = %b",num1,num2,result,zeroflag);
                    else
                        $fdisplay(subfile,"[PASS] num1 = %b , num2 = %b , result = %b , zeroFlag = %b",num1,num2,result,zeroflag);
                end
                else begin
                    $error("[FAIL] num1 = %b , num2 = %b , result = %b , expected result = %b , zeroFlag = %b, operation = %b",num1,num2,result,expectedResult,zeroflag,selection);
                    if (selection)
                        $fdisplay(subfile,"[FAIL] num1 = %b , num2 = %b , result = %b , expected result = %b , zeroFlag = %b",num1,num2,result,expectedResult,zeroflag);
                    else
                        $fdisplay(subfile,"[FAIL] num1 = %b , num2 = %b , result = %b , expected result = %b , zeroFlag = %b",num1,num2,result,expectedResult,zeroflag);
                end
            end
        end
    end
    $finish();
    $fclose(addfile);
    $fclose(subfile);
end
endmodule