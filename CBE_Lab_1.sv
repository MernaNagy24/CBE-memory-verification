module SinglePortRAM_SynchRandW (
    input [31: 0] Data_in,
    input [3: 0] Address,
    input EN ,Clk ,rst,
    output logic [31: 0] Data_out,
    output logic Valid_out
);

logic [31: 0] Memory [0:15];

integer i;
always_ff @(posedge Clk or negedge rst) begin
    if(!rst)begin
        for(i = 0; i < 16; i = i + 1) begin
        Memory[i] <= 0;
        Data_out <= 0;
        Valid_out <= 0;
        end
    end else begin
        if(EN)begin
            Memory[Address] <= Data_in;
            Valid_out <= 0; 
        end else begin
            Data_out <= Memory[Address];
            Valid_out <= 1;
        end
    end
end
endmodule