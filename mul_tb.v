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
reg expZF;


initial begin
    file = $fopen("mult.txt","w");
    for(i = 0; i < 3'b111 ;i = i + 1)begin
        inputa = i;
        #100;
    for(j = 0; j < 3'b111; j = j + 1)begin
        inputb = j;

        expPrdct[3:0] = inputa[1:0]*inputb[1:0];
        expPrdct[4] = inputa[2]^inputb[2];
        expZF = !(inputa[0]||inputa[1]) || !(inputb[0]||inputb[1]);

        #100;

            if(product[4:0]==expPrdct[4:0] && expZF == zeroFlag) begin
                $display("[PASS] A=%b-B=%b A*B=%b signed flag=%b zero flag=%b",inputa,inputb,product,product[4],zeroFlag);
                $fdisplay(file,"[PASS] A=%b-B=%b A*B=%b signed flag=%b zero flag=%b",inputa,inputb,product,product[4],zeroFlag);
            end
            else $error ("[FAIL] A=%b B=%b A*B=%b signed flag=%b zero flag=%b exA*B=%b expZF=%b",inputa,inputb,product,product[4],zeroFlag,expPrdct,expZF);
           
        end    
    end
    $finish();
    $fclose(file);
end




endmodule