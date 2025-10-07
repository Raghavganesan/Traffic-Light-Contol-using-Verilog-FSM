// Traffic light controller (Moore FSM) — HWY vs CNTRY
// Lights are 2-bit coded: RED=00, YELLOW=01, GREEN=10

module sig_control (
  input  wire clk,
  input  wire rst_n,     // active-low synchronous reset
  input  wire X,         // 1 => car waiting on country road
  output reg  [1:0] hwy, // highway light
  output reg  [1:0] cntry// country road light
);

  // Light encodings
  localparam [1:0] RED   = 2'd0,
                   YEL   = 2'd1,
                   GRN   = 2'd2;

  // States
  localparam [2:0] S0 = 3'd0, // HWY=G, CNTRY=R
                   S1 = 3'd1, // HWY=Y, CNTRY=R  (Y→R delay)
                   S2 = 3'd2, // HWY=R, CNTRY=R (R→G delay)
                   S3 = 3'd3, // HWY=R, CNTRY=G
                   S4 = 3'd4; // HWY=R, CNTRY=Y (Y→R delay)

  // Timing parameters (in clk cycles) — tune as you wish
  // Example: if clk=1 Hz, Y2R=3s, R2G=2s
  localparam integer Y2R_DELAY = 3;
  localparam integer R2G_DELAY = 2;

  reg [2:0]  state, next_state;
  reg [31:0] count;            // down-counter for timed states
  wire       done = (count == 0);

  // State register + timer loader/decrementer
  always @(posedge clk) begin
    if (!rst_n) begin
      state <= S0;
      count <= 0;
    end else begin
      // advance state
      state <= next_state;

      // (re)load counter when entering a timed state; otherwise count down
      if (state != next_state) begin
        case (next_state)
          S1: count <= (Y2R_DELAY > 0) ? Y2R_DELAY : 0; // HWY Y→R
          S2: count <= (R2G_DELAY > 0) ? R2G_DELAY : 0; // all-red pause
          S4: count <= (Y2R_DELAY > 0) ? Y2R_DELAY : 0; // CNTRY Y→R
          default: count <= 0;                          // S0, S3 are untimed
        endcase
      end else if (count != 0) begin
        count <= count - 1;
      end
    end
  end

  // Next-state (pure combinational) — Moore transitions
  always @* begin
    next_state = state;
    case (state)
      S0: next_state = (X ? S1 : S0);          // HWY green until a car arrives on CNTRY
      S1: next_state = (done ? S2 : S1);       // wait Y→R
      S2: next_state = (done ? S3 : S2);       // all red, then give CNTRY green
      S3: next_state = (X ? S3 : S4);          // keep CNTRY green while cars are present
      S4: next_state = (done ? S0 : S4);       // CNTRY yellow → back to HWY green
      default: next_state = S0;
    endcase
  end

  // Moore outputs — depend ONLY on current state
  always @* begin
    case (state)
      S0: begin hwy = GRN; cntry = RED; end
      S1: begin hwy = YEL; cntry = RED; end
      S2: begin hwy = RED; cntry = RED; end
      S3: begin hwy = RED; cntry = GRN; end
      S4: begin hwy = RED; cntry = YEL; end
      default: begin hwy = RED; cntry = RED; end
    endcase
  end

endmodule
