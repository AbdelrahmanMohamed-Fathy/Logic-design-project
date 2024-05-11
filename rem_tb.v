//command to test: vsim rem_tb -c -do "run -all"
module rem_tb();
reg [2:0] numerator;
reg [2:0] denominator;
wire [4:0] result;
wire zeroFlag;
wire divbyzeroflag;

rem remainder_test
(
    .numerator(numerator),
    .denominator(denominator),
    .remainder(result),
    .zero(zeroFlag),
    .divbyzero(divbyzeroflag)
);
integer file;
integer i;
integer j;
reg [1:0] temp;
initial begin
    file = $fopen("rem.txt","w");
    for(i=0;i<=3'b111;i=i+1) begin
        numerator=i;
        for(j=0;j<=3'b111;j=j+1)begin
            denominator=j;
            temp = numerator[1:0]%denominator[1:0];
            #100;
            if ( ( result[1:0] == temp[1:0] && zeroFlag == !(temp) ) || ( (denominator == 3'b000 || denominator == 3'b100) && (divbyzeroflag == 1) && (result[4] == numerator[2] ) )) begin
                $display("[PASS] A = %b, B = %b, A%%B = %b, signed flag = %b, zeroFlag = %b, divByZeroFlag = %b",numerator,denominator,result,result[4],zeroFlag,divbyzeroflag);
                $fdisplay(file,"[PASS] A = %b, B = %b, A%%B = %b, zeroFlag = %b, divByZeroFlag = %b",numerator,denominator,result,zeroFlag,divbyzeroflag);
            end
            else begin
                $error("[FAIL] A = %b, B = %b, A%%B = %b, expected result = %b, signed flag= %b, zeroFlag = %b, divByZeroFlag = %b",numerator,denominator,result,temp,result[4],zeroFlag,divbyzeroflag);
                $fdisplay(file,"[FAIL] A = %b, B = %b, A%%B = %b, expected result = %b, signed flag= %b, zeroFlag = %b, divByZeroFlag = %b",numerator,denominator,result,temp,result[4],zeroFlag,divbyzeroflag);
            end
        end
    end
    $finish();
    $fclose(file);
end


endmodule