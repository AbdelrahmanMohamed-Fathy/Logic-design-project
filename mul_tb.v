//command to test: vsim mul_tb -c -do "run -all"
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

            if(product[4:0]==expPrdct[4:0]) begin
                $display("[PASS] A=%b-B=%b A*B=%b signed flag=%b",inputa,inputb,product,product[4]);
                $fdisplay(file,"[PASS] A=%b-B=%b A*B=%b signed flag=%b",inputa,inputb,product,product[4]);
            end
            else $error ("[FAIL] A=%b B=%b A*B=%b signed flag=%b exA*B=%b ",inputa,inputb,product,product[4],expPrdct);
            if(product[3:0] == 4'b0000 && zeroFlag == 1'b1) begin
                $display("[PASS] Zero Flag: A=%b B=%b",inputa,inputb);
                $fdisplay(file,"[PASS] Zero Flag: A=%b B=%b",inputa,inputb);
            end
            else if (product[3:0] == 4'b0000 && zeroFlag ==1'b0) begin
                $error("[FAIL] Zero Flag: A=%b B=%b A*B=%b signed flag=%b zero flag=%b",inputa,inputb,product,product[4],zeroFlag);
                $fdisplay(file,"[FAIL] Zero Flag: A=%b B=%b A*B=%b signed flag=%b zero flag=%b",inputa,inputb,product,product[4],zeroFlag);
            end
            else if (product[3:0] != 4'b0000 && zeroFlag ==1'b1) begin
                $error("[FAIL] Zero Flag: A=%b B=%b A*B=%b signed flag=%b zero flag=%b",inputa,inputb,product,product[4],zeroFlag);
                $fdisplay(file,"[FAIL] Zero Flag: A=%b B=%b A*B=%b signed flag=%b zero flag=%b",inputa,inputb,product,product[4],zeroFlag);
            end
        end    
    end
    $finish();
    $fclose(file);
end




endmodule