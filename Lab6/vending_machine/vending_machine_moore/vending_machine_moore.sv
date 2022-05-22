// Vending Machine RTL Code
module vending_machine_moore( 
 input logic clk, rstn,  
 input logic N, D,
 output logic open);
 
 // state variables and state encoding parameters
 parameter[1:0] CENTS_0=2'b00, CENTS_5=2'b01, CENTS_10=2'b10, CENTS_15=2'b11;
 logic[1:0] present_state, next_state; 

 // Sequential Logic for present state
 always_ff@(posedge clk) begin
   // Student to Add Code
  // Manual reset option
  present_state <= next_state;
 end

 // Combination Logic for Next State and Output
 always_comb begin 
  // Student to Add Code
  case (present_state)
    CENTS_0: begin
      open = 0;
      if ((!N && !D) || !rstn) begin
        next_state = CENTS_0;
      end
      else if (N && !D) begin
        next_state = CENTS_5;
      end
      else if (!N && D) begin
        next_state = CENTS_10;
      end
      else begin
        next_state = CENTS_15;
      end
    end
    CENTS_5: begin
      open = 0;
      if (!N && !D) begin
        next_state = CENTS_5;
      end
      else if (N && !D) begin
        next_state = CENTS_10;
      end
      else if (!N && D) begin
        next_state = CENTS_15;
      end
      else begin
        next_state = CENTS_15;
      end
      if (!rstn)
        next_state = CENTS_0;
    end
    CENTS_10: begin
      open = 0;
      if (!N && !D) begin
        next_state = CENTS_10;
      end
      else if (N && !D) begin
        next_state = CENTS_15;
      end
      else if (!N && D) begin
        next_state = CENTS_15;
      end
      else begin
        next_state = CENTS_15;
      end
      if (!rstn)
        next_state = CENTS_0;
    end
    CENTS_15: begin
      open = 1;
      next_state = CENTS_15;
      if (!rstn)
        next_state = CENTS_0;
    end 
    default: begin
      open = 0;
      next_state = CENTS_0;
    end
  endcase
 end
endmodule: vending_machine_moore

