module myproj (btog,in,out);
    input btog;
    input [3:0] in;
    output reg [4:0] out;
    integer i;
    reg [4:0] middleout;
    always@(btog or in) begin
        if(btog) begin
	    out[4] = 0;
            out[3] = in[3];
            out[2] = in[3] ^ in[2];
            out[1] = in[2] ^ in[1];
            out[0] = in[1] ^ in[0];
        end
        else begin
	    middleout[4] = 0;
            middleout[3] = in[3];
            for (i = 2; i >= 0; i = i - 1) begin
            	middleout[i] = middleout[i+1] ^ in[i];
            end
	        out[4]= (middleout[3] & middleout[2]) | (middleout[3]&middleout[1]);
		out[3] = (middleout[3]&(!middleout[2])&(!middleout[1]));
		out[2] = (!middleout[3]&middleout[2])|(middleout[2]&middleout[1]);
		out[1] = (middleout[3]&middleout[2]&(!middleout[1]))|(!middleout[3]&middleout[1]);
		out[0] = middleout[0];
	 end
    end
	    
endmodule

module testbench;
    
	reg btog;
	reg [3:0]in;
	wire [4:0]out;
	myproj ins(.btog(btog),.in(in),.out(out));
	initial 
	begin
		assign btog = 1'b1;
		assign in = 4'b0100;
		#25;
		assign btog = 1'b0;
		assign in = 4'b1000;
		#25;
		assign btog = 1'b0;
		assign in = 4'b0100;
		#25;
		assign btog = 1'b1;
		assign in = 4'b1110;
		#25;
		assign btog = 1'b1;
		assign in = 4'b1001;
		#25;
		
	end
endmodule
