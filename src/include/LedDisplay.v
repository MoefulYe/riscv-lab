module LedDisplay(
    input clk_100M, 
    input [31:0]data,
    input enable, // 1使能
    output [3:0] sel, //[3]是使能位
    output reg [7:0] seg
); 
    reg [10:0] count = 0;
    reg [2:0] which = 0;
    assign sel = { enable, which };
    always @(posedge clk_100M) count <= count + 1'b1;
    always @(negedge clk_100M) if(&count) which <= which + 1'b1;

    reg [3:0] digit; 
    always @* case (which)
        0: digit <= data[31:28]; 
        1: digit <= data[27:24];
        2: digit <= data[23:20];
        3: digit <= data[19:16];
        4: digit <= data[15:12];
        5: digit <= data[11:08];
        6: digit <= data[07:04];
        7: digit <= data[03:00]; 
    endcase

    always @* case (digit) 
        4'h0: seg <= 8'b0000_0011; 
        4'h1: seg <= 8'b1001_1111; 
        4'h2: seg <= 8'b0010_0101;
        4'h3: seg <= 8'b0000_1101;
        4'h4: seg <= 8'b1001_1001;
        4'h5: seg <= 8'b0100_1001;
        4'h6: seg <= 8'b0100_0001;
        4'h7: seg <= 8'b0001_1111;
        4'h8: seg <= 8'b0000_0001;
        4'h9: seg <= 8'b0000_1001;
        4'hA: seg <= 8'b0001_0001;
        4'hB: seg <= 8'b1100_0001;
        4'hC: seg <= 8'b0110_0011;
        4'hD: seg <= 8'b1000_0101;
        4'hE: seg <= 8'b0110_0001;
        4'hF: seg <= 8'b0111_0001;
    endcase

endmodule 
