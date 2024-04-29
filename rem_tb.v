

//command to test: vsim rem_tb -c -do "run -all"
module rem_tb();

`timescale 1ns/100ps


reg [2:0] numerator;
reg [2:0] denominator;
wire [2:0] result;
wire divbyzeroflag;

rem remainder_test
(
    .numerator(numerator),
    .denominator(denominator),
    .remainder(result),
    .divbyzero(divbyzeroflag)
);

integer i;
integer j;
reg [1:0] temp;
initial begin

    for(i=0;i<=3'b111;i=i+1) begin
        numerator=i;
        for(j=0;j<=3'b111;j=j+1)begin
            denominator=j;
            temp = numerator[1:0]%denominator[1:0];
            #100;
            if ( ( result[1:0] == temp[1:0] ) || ( (denominator == 3'b000 || denominator == 3'b100) && (divbyzeroflag == 1) && (result[2] == numerator[2]) ) )
                $display("[PASS] numerator = %b , denominator = %b , result = %b , flag = %b",numerator,denominator,result,divbyzeroflag);
            else
                $error("[FAIL] numerator = %b , denominator = %b , result = %b , expected result = %b , flag = %b",numerator,denominator,result,temp,divbyzeroflag);
        end
    end
$finish;
end


endmodule