/*module alu(
    input[2:0] num1,
    input[2:0] num2,
    input[1:0] sel,
    output[4:0] result,
    output reg zeroFlag,
    output reg divByZeroFlag
);
always@(*) begin
    case(sel)
        //multiplication
        2'b10:
        begin
            multi multiplication(
                .a(num1),
                .b(num2),
                .product(result),
                .zeroFlag(zeroFlag)
            );
            divByZeroFlag=0;
            #100
        end
        //remainder
        2'b11:
        begin
            rem remainder(
                .numerator(num1),
                .denominator(num2),
                .remainder(result),
                .divbyzero(divByZeroFlag),
                .zero(zeroFlag)
            );
            #100
        end
        //addition and subtraction
        default:
        begin
            add_sum addition_subtraction(
                .num1(num1),
                .num(num2),
                .selection(sel[0]),
                .result(result),
                .zeroflag(zeroFlag)
            )
            divByZeroFlag=0;
            #100
        end
    endcase
end
endmodule
*/