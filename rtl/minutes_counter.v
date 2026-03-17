module minutes_counter (
    input wire clk,
    input wire rst_n,
    input wire enable, //connected to the max_second from seconds_counter module
    input wire reset,
    output reg [7:0] minutes //7 bits [6:0} should be enough?, top level predefined ports tho so
);

    always @ (posedge clk) begin
        if (!rst_n) begin
            minutes <= 0;
        end else if (reset) begin
            minutes <= 0;
        end else if (enable) begin
            if (minutes == 99) begin
                minutes <= 0;
            end else begin
                minutes <= minutes + 1;
            end
        end
    end
    
endmodule