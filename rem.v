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
        case(numerator[1:0])
            2'b01:begin remainder[0] = denominator[1];                      remainder[1] = 0;                                 end
            2'b10:begin remainder[0] = 0;                                   remainder[1] = denominator[1] && denominator[0];  end
            2'b11:begin remainder[0] = denominator[1] && !denominator[0];   remainder[1] = 0;                                 end
            default:remainder[1:0]=2'b00;
        endcase
        remainder[2]=(numerator[2]^denominator[2]);
    end
end
endmodule