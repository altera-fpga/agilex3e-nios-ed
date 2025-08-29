module pb_debounce(
    input wire clk,
    input wire [3:0] pb_in,
    output reg [3:0] pb_out
);
    parameter M = 20;
    reg [M:0] shift [3:0];  // shift registers, each M+1 bits wide
    integer i;
 
    always @(posedge clk) begin
        // Shift register captures input, shifting left by 1
        for (i = 0; i < 4; i = i + 1) begin
            shift[i] <= {shift[i][M-1:0], pb_in[i]};
        end
 
        // Debounce output logic
        for (i = 0; i < 4; i = i + 1) begin
            if (~|shift[i])
                pb_out[i] <= 1'b0;
            else if (&shift[i])
                pb_out[i] <= 1'b1;
            else
                pb_out[i] <= pb_out[i];
        end
    end
endmodule