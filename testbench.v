module tb_MemoryController;

    parameter N = 32;
    parameter M = 5;

    reg clk;
    reg reset;
    reg mem_ctrl;
    reg [M-1:0] addr;
    reg [N-1:0] write_data;
    wire [N-1:0] read_data;

    // Instantiate the MemoryController
    MemoryController #(.N(N), .M(M)) uut (
        .clk(clk),
        .reset(reset),
        .mem_ctrl(mem_ctrl),
        .addr(addr),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 10ns clock period

    // Test sequence
    initial begin
        // Initialize signals
        reset = 1;
        mem_ctrl = 0;
        addr = 0;
        write_data = 0;

        // Release reset
        #10 reset = 0;

        // Write to register 3
        #10 addr = 5'd3; write_data = 32'hDEADBEEF; mem_ctrl = 0;

        // Read from register 3
        #10 mem_ctrl = 1;

        // Write to register 7
        #10 addr = 5'd7; write_data = 32'hCAFEBABE; mem_ctrl = 0;

        // Read from register 7
        #10 mem_ctrl = 1;

        // Finish simulation
        #10 $finish;
    end

endmodule
