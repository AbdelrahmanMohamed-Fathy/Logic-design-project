`timescale 1ns/100ps
module multi_tb;
reg[2:0] inputa;
reg[2:0] inputb;
wire[4:0] product;


multi DUT(
    .a(inputa),
    .b(inputb),
    .product(product)
);

integer i=0;
integer j=0;
reg [4:0] expPrdct;


initial begin
    for(i = 0; i < 3'b111 ;i = i + 1)begin
        inputa = i;
        #100;
    for(j = 0; j < 3'b111; j = j + 1)begin
        inputb = j;

        expPrdct[3:0] = inputa[1:0]*inputb[1:0];
        expPrdct[4] = inputa[2]^inputb[2];

        #100;

            if(product[3:0]==expPrdct[3:0] && product[4]==expPrdct[4]) $display("Pass: A=%b-B=%b P=%b",inputa,inputb,product);
            else $error ("Fail: A=%b B=%b P=%b exP=%b",inputa,inputb,product,expPrdct);

        end    
    end
    $finish(); 
end




endmodule