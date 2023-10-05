module parking_system_tb();
reg sensor_entrance,sensor_exit,clk,rst;
reg [2:0] password;
wire red_led,green_led;

parking_system DUT(.sensor_entrance(sensor_entrance),.sensor_exit(sensor_exit),.clk(clk),.rst(rst),.password(password),.red_led(red_led),.green_led(green_led));

integer i=0;
initial begin
	clk=0;
	forever
	#1 clk=~clk;
end
initial begin
rst=1;
sensor_exit=0;
sensor_entrance=0;
password=3'b000;
#50
rst=0;
#50
sensor_entrance=1;
password=3'b011;
for(i=0;i<1000;i=i+1)begin
#2
sensor_exit=$random;
end
for(i=0;i<1000;i=i+1)begin
#2
sensor_entrance=$random;
sensor_exit=$random;
password=$random;
end
#2 $stop;
end
endmodule

