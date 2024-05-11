//command to test: vsim add_sub_tb -c -do "run -all"
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
    addfile = $fopen("add.txt","w");
    subfile = $fopen("sub.txt","w");
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
                    if (selection) begin
                        $display("[PASS] A = %b , B = %b, A-B = %b, signed flag= %b, zeroFlag = %b",num1,num2,result,result[4],zeroflag);
                        $fdisplay(subfile,"[PASS] A = %b, B = %b, A-B = %b, signed flag= %b, zeroFlag = %b",num1,num2,result,result[4],zeroflag);
                    end
                    else begin
                        $display("[PASS] A = %b, B = %b, A+B = %b, signed flag= %b, zeroFlag = %b",num1,num2,result,result[4],zeroflag);
                        $fdisplay(addfile,"[PASS] A = %b , B = %b , A+B = %b , signed flag= %b, zeroFlag = %b",num1,num2,result,result[4],zeroflag);
                    end
                end
                else begin
                    if (selection) begin
                        $error("[FAIL] A = %b, B = %b, A-B = %b, expected result = %b, signed flag= %b, zeroFlag = %b",num1,num2,result,expectedResult,result[4],zeroflag);
                        $fdisplay(subfile,"[FAIL] A = %b, B = %b, A-B = %b, expected result = %b, signed flag= %b, zeroFlag = %b",num1,num2,result,expectedResult,result[4],zeroflag);
                    end
                    else begin
                        $error("[FAIL] A = %b, B = %b, A+B = %b, expected result = %b, signed flag= %b, zeroFlag = %b",num1,num2,result,expectedResult,result[4],zeroflag);
                        $fdisplay(addfile,"[FAIL] A = %b, B = %b, A+B = %b, expected result = %b, signed flag= %b, zeroFlag = %b",num1,num2,result,expectedResult,result[4],zeroflag);
                    end
                end
            end
        end
    end
    $finish();
    $fclose(addfile);
    $fclose(subfile);
end
endmodule