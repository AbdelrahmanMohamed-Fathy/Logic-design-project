module alu(
    input[2:0] num1,
    input[2:0] num2,
    input[1:0] sel,
    output[4:0] result,
    output zeroFlag,
    output divByZeroFlag
);
always@(*) begin
    case(sel)
        //multiplication
        2'b10:
        begin
            
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
            
        end
    endcase
end
endmodule