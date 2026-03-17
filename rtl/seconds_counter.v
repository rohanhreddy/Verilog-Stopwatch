module seconds_counter (
    input wire clk,
    input wire rst_n,
    input wire enable, //counts whenever this is high (stays high = keeps counting)
    input wire reset,
    output reg [5:0] count,
    output wire max_second
);
    
    always @ (posedge clk) begin
        if (!rst_n) begin //reset with active low
            count <= 0; //non blocking assignment
        end else if (reset) begin
            count <= 0;
        end else if (enable) begin
            if (count == 59) begin
                count <= 0;
            end else begin
                count <= count + 1;
            end
        end
    end

    assign max_second = (count == 59) & enable;

endmodule