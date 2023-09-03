module prbs7 (
    input clk_i,
    input rst_ni,
    input [6:0] lfsr_init_i,
    input load_prbs_i,
    input freeze_i,
    output prbs_o
);
    reg [6:0] lfsr_reg;
    always @(posedge clk_i) begin
        if (!rst_ni) begin
            lfsr_reg <= 7'h7f;
        end else if (load_prbs_i == 1) begin
            lfsr_reg <= lfsr_init_i;
        end else if (freeze_i == 1) begin
            lfsr_reg <= lfsr_reg;
        end else begin
            lfsr_reg <= {lfsr_reg[5:0], lfsr_reg[6] ^ lfsr_reg[5]};
        end
    end
    
    assign prbs_o = lfsr_reg[6];

endmodule