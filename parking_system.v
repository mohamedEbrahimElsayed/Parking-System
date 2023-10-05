module parking_system(sensor_entrance,sensor_exit,password,clk,rst,red_led,green_led);
parameter IDLE=3'b000;
parameter WAIT_PASSWORD=3'b001;
parameter RIGHT_PASS=3'b010;
parameter WRONG_PASS=3'b011;
parameter STOP=3'b100;
input sensor_entrance,sensor_exit,clk,rst;
input [2:0] password;
output red_led,green_led;
reg [2:0] ns,cs;

//state memory
always @(posedge clk or posedge rst) begin
	if (rst)
		cs <= IDLE;
	else
		cs <= ns;
end
//next state
always @(sensor_entrance,sensor_exit,password,cs)begin
	case(cs)
		IDLE:begin
			if(sensor_entrance==1)
				ns = WAIT_PASSWORD;
			else
				ns = IDLE;
		end
		WAIT_PASSWORD:begin
			if(password==3'b011)
				ns = RIGHT_PASS;
			else
				ns = WRONG_PASS;
		end
		RIGHT_PASS:begin
			if(sensor_entrance==1 && sensor_exit==1)
				ns = STOP;
			else if(sensor_exit==1)
				ns = IDLE;
			else
				ns = RIGHT_PASS;
		end
		WRONG_PASS:begin
			if(password==3'b011)
				ns = RIGHT_PASS;
			else
				ns = WRONG_PASS;
		end
		STOP:begin
			if(password==3'b011)
				ns = RIGHT_PASS;
			else
				ns = STOP;
		end
		default: ns = IDLE;
	endcase
end
//output logic
assign green_led =(cs == WAIT_PASSWORD && password ==3'b011)? 1'b1:1'b0 ;
assign red_led =(cs == WAIT_PASSWORD && password != 3'b011)? 1'b1:1'b0 ;
endmodule