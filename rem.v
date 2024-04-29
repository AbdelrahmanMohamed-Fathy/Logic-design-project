module rem(
    input[2:0] numerator,
    input[2:0] denominator,
    output reg[2:0] remainder,
    output reg divbyzero
);
always@(*) begin
    if (denominator[1:0]==2'b00) begin
        divbyzero=1;
        remainder[2] = numerator[2];
        remainder[1:0]=2'b00;
    end
    else begin
        divbyzero=0;
        case (numerator[0])
            1'b1: remainder[0] = denominator[1];
            1'b0: remainder[0] = 1'b0;
            default: remainder[0] = 1'b0;
        endcase
        case (numerator[1] && denominator[0])
            1'b1: remainder[1] = denominator[1];
            1'b0: remainder[1] = 1'b0; 
            default: remainder[1] = 1'b0;
        endcase
        case (!(numerator[2] ^ denominator[2]))
            1'b1: remainder[2] = 0;
            1'b0: remainder[2] = 1;
            default: remainder[2] = 0;
        endcase
        if (remainder[1] && remainder[0])
            remainder=3'b000;
    end
end
endmodule