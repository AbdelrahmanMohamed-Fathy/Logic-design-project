`timescale 1ns/100ps
module mul_tb;
reg[2:0] inputa;
reg[2:0] inputb;
wire[4:0] product;
wire zeroFlag;


mul DUT(
    .a(inputa),
    .b(inputb),
    .product(product),
    .zeroFlag(zeroFlag)
);

integer file;
integer i=0;
integer j=0;
reg [4:0] expPrdct;


initial begin
    file = $fopen("mult.txt","w");
    for(i = 0; i < 3'b111 ;i = i + 1)begin
        inputa = i;
        #100;
    for(j = 0; j < 3'b111; j = j + 1)begin
        inputb = j;

        expPrdct[3:0] = inputa[1:0]*inputb[1:0];
        expPrdct[4] = inputa[2]^inputb[2];

        #100;

            if(product[3:0]==expPrdct[3:0] && product[4]==expPrdct[4]) begin
                $display("Pass: A=%b-B=%b P=%b",inputa,inputb,product);
                $fdisplay(file,"Pass: A=%b-B=%b P=%b",inputa,inputb,product);
            end
            else $error ("Fail: A=%b B=%b P=%b exP=%b",inputa,inputb,product,expPrdct);
            if(product[3:0] == 4'b0000 && zeroFlag == 1'b1) begin
                $display("Pass Zero Flag: A=%b B=%b",inputa,inputb);
                $fdisplay(file,"Pass Zero Flag: A=%b B=%b",inputa,inputb);
            end
            else if (product[3:0] == 4'b0000 && zeroFlag ==1'b0) begin
                $error("Fail Zero Flag: A=%b B=%b P=%b Z=%b",inputa,inputb,product,zeroFlag);
                $fdisplay(file,"Fail Zero Flag: A=%b B=%b P=%b Z=%b",inputa,inputb,product,zeroFlag);
            end
            else if (product[3:0] != 4'b0000 && zeroFlag ==1'b1) begin
                $error("Fail Zero Flag: A=%b B=%b P=%b Z=%b",inputa,inputb,product,zeroFlag);
                $fdisplay(file,"Fail Zero Flag: A=%b B=%b P=%b Z=%b",inputa,inputb,product,zeroFlag);
            end
        end    
    end
    $finish();
    $fclose(file);
end




endmodule