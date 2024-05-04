//this module calculates the remainder of 2 (signed magnitude) 3 bit inputs
module rem(
    input[2:0] numerator,
    input[2:0] denominator,
    output reg[4:0] remainder,
    output reg divbyzero,
    output reg zero
);
assign remainder[3:2] = 2'b00;
always@(*) begin
    if (denominator[1:0]==2'b00) begin
        divbyzero=1;
        remainder[4] = numerator[2];
        remainder[1:0]=2'b00;
    end
    else begin
        divbyzero=0;
        case(numerator[1:0])
            2'b01:  begin remainder[0] = denominator[1];                      remainder[1] = 0;                                zero = 0;    end
            2'b10:  begin remainder[0] = 0;                                   remainder[1] = denominator[1] && denominator[0]; zero = 0;    end
            2'b11:  begin remainder[0] = denominator[1] && !denominator[0];   remainder[1] = 0;                                zero = 0;    end
            default:begin remainder[1:0]=2'b00;                                                                                zero = 1;    end
        endcase
        remainder[4]=(numerator[2]^denominator[2]);
    end
end
endmodule