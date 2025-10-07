`timescale 1ns/1ps

module sig_control_tb;
  reg  clk, rst_n, X;
  wire [1:0] hwy, cntry;

  // DUT
  sig_control dut (
    .clk(clk),
    .rst_n(rst_n),
    .X(X),
    .hwy(hwy),
    .cntry(cntry)
  );

  // 10ns clock
  initial clk = 0;
  always #5 clk = ~clk;

  // Stimulus
  initial begin
    // VCD
    $dumpfile("traffic.vcd");
    $dumpvars(0, sig_control_tb);

    // Reset
    rst_n = 0; X = 0;
    repeat (3) @(posedge clk);
    rst_n = 1;

    // Let HWY stay green (no car)
    repeat (10) @(posedge clk);

    // Car arrives on CNTRY: trigger full cycle to CNTRY green
    X = 1;
    repeat (15) @(posedge clk);

    // Cars clear on CNTRY: return path to HWY
    X = 0;
    repeat (20) @(posedge clk);

    // Another car burst on CNTRY (hold S3 while X=1)
    X = 1;
    repeat (10) @(posedge clk);
    X = 1; repeat (8) @(posedge clk); // still present
    X = 0; repeat (25) @(posedge clk);

    $finish;
  end

  // Pretty print monitor
  function [7*8:1] color_str(input [1:0] c);
    case (c)
      2'd0: color_str = "RED   ";
      2'd1: color_str = "YELLOW";
      2'd2: color_str = "GREEN ";
      default: color_str = "XX    ";
    endcase
  endfunction

  always @(posedge clk) begin
    $display("t=%0t ns | X=%0b | HWY=%s | CNTRY=%s",
             $time, X, color_str(hwy), color_str(cntry));
  end
endmodule
