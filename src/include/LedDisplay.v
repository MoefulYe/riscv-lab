module LedDisplay(
    input clk, 
    input [32:1]data, 
    input enable_n,
    output [3:0] sel, 
    seg,
); 
    reg [2:0] which = 0; 
    assign sel = { which, enable_n };
    output reg [7:0] seg; 
    output reg [10:0] count = 0; 
    always @(posedge clk) count <= count + 1'b1;
    always @(negedge clk) if (&count) which <= which + 1'b1;

    output reg [3:0] digit; 
    always @* case (which)
        0: digit <= data[32:29]; 
        1: digit <= data[28:25];
        2: digit <= data[24:21];
        3: digit <= data[20:17];
        4: digit <= data[16:13];
        5: digit <= data[12:09];
        6: digit <= data[08:05];
        7: digit <= data[04:01]; 
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
