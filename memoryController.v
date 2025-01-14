module MemoryController #(
    parameter N = 32,  // Data width (n-bit)
    parameter M = 5    // Address width (m-bit, for 2^M registers)
)(
    input wire clk,              // Clock signal
    input wire reset,            // Reset signal
    input wire mem_ctrl,         // 1-bit memory port: 0 for write, 1 for read
    input wire [M-1:0] addr,     // Address port (m-bit)
    input wire [N-1:0] write_data, // Data input (n-bit)
    output reg [N-1:0] read_data  // Data output (n-bit)
);

    // Register array: 2^M registers, each N bits wide
    reg [N-1:0] registers [0:(1<<M)-1];

    // Write-1-Read-1 operation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all registers to zero
            integer i;
            for (i = 0; i < (1 << M); i = i + 1) begin
                registers[i] <= {N{1'b0}};
            end
            read_data <= {N{1'b0}};
        end else begin
            if (mem_ctrl == 0) begin
                // Write operation
                registers[addr] <= write_data;
            end else begin
                // Read operation
                read_data <= registers[addr];
            end
        end
    end

endmodule
