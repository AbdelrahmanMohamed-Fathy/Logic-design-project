module alu(
    input[2:0] num1,
    input[2:0] num2,
    input[1:0] sel,
    output reg [4:0] result,
    output reg zeroFlag,
    output reg divByZeroFlag
);

wire[4:0] addsubResult;
wire[4:0] mulResult;
wire[4:0] remResult;

wire addsubZeroFlag;
wire mulZeroFlag;
wire remZeroFlag;

wire actualDivByZero;

add_sub addition_subtraction(
    .num1(num1),
    .num2(num2),
    .selection(sel[0]),
    .result(addsubResult),
    .zeroflag(addsubZeroFlag)
);

multi multiplication(
    .a(num1),
    .b(num2),
    .product(mulResult),
    .zeroFlag(mulZeroFlag)
);

rem remainder(
    .numerator(num1),
    .denominator(num2),
    .remainder(remResult),
    .divbyzero(actualDivByZero),
    .zero(remZeroFlag)
);

always@(*) begin
    case(sel)
        //multiplication
        2'b10:
        begin
            result=mulResult;
            zeroFlag=mulZeroFlag;
            divByZeroFlag=0;
        end
        //remainder
        2'b11:
        begin
            result=remResult;
            zeroFlag=remZeroFlag;
            divByZeroFlag=actualDivByZero;
        end
        //addition and subtraction
        default:
        begin
            result=addsubResult;
            zeroFlag=addsubZeroFlag;
            divByZeroFlag=0;
        end
    endcase
end
endmodule