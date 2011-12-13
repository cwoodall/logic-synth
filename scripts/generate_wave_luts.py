import math
import random

def generateSineTable(max_dac_val=63.0, steps_per_cycle=256):
	sine_lut = [];
	for r in range(0, steps_per_cycle):
		sine_lut.append((max_dac_val/2) * (math.sin(r*2*math.pi/steps_per_cycle) + 1)) 
	return sine_lut

def generateTriangleWave(max_dac_val=63.0, steps_per_cycle=256):
	tri_lut = [];
	for r in range(0, steps_per_cycle/2):
		tri_lut.append(r*max_dac_val*2/steps_per_cycle)

	for r in range(steps_per_cycle/2, steps_per_cycle):
		tri_lut.append((steps_per_cycle-r)*max_dac_val*2/steps_per_cycle)

	return tri_lut

def generateSawTooth(max_dac_val=63.0, steps_per_cycle=256, neg=0):
	sawtooth_lut = []
	for r in range(0, steps_per_cycle):
		sawtooth_lut.append(abs(neg*steps_per_cycle - r)*max_dac_val/steps_per_cycle)
	return sawtooth_lut

def generateSquare(max_dac_val=63.0, steps_per_cycle=256):
	square_lut = []
	for r in range(0, steps_per_cycle/2): square_lut.append(0)
	for r in range(steps_per_cycle/2, steps_per_cycle): square_lut.append(max_dac_val)
	return square_lut

def generateNoise(max_dac_val=63.0, steps_per_cycle=256):
	noise_lut = []
	for r in range(0, steps_per_cycle): noise_lut.append(random.randint(0,max_dac_val))
	return noise_lut

def generateVerilogLUT(module_name, bit_width, step_width, some_lut):
	print "module %s ( step, val );" % (module_name)
	print "\tinput [%i:0] step;" % (step_width - 1)
	print "\toutput reg [%i:0] val;" % (bit_width - 1)
	print "\talways @ (step) begin"
	print "\t\tcase (step)"
	for i in range(0, len(some_lut)):
		print "\t\t\t%i'd%i: val <= %i'd%i;" % (step_width, i, bit_width, round(some_lut[i]))
	print "\t\tendcase"
	print "\tend"
	print "endmodule"
	print
	print "module %s_TEST ( );" % (module_name)
	print "\treg [%i:0] step;" % bit_width
	print "\twire [%i:0] val;" % step_width
	print "\t%s UUT (step, val);" % module_name
	print "\tinitial begin"
	print "\t\t$dumpvars;"
	print "\t\tstep <= 0;"
	print "\t\t#100"
	print "\t\trepeat (%i) begin" % (step_width-1)
	print "\t\t\t#10 step <= step + 1;"
	print "\t\tend"
	print "\tend"
	print "endmodule"
## Example output
generateVerilogLUT("Sine_LUT", 10, 10, generateSineTable(2047,1024))

# module Sine_LUT ( step, val );
# 	input [8:0] step;
# 	output [6:0] val;
# 
# 	reg [6:0] val;
# 	always @ (step) begin
# 		case (step)
# 			8'd0: val <= 6'd31;
# 			8'd1: val <= 6'd32;
# 			8'd2: val <= 6'd33;
# 			8'd3: val <= 6'd33;
# 			8'd4: val <= 6'd34;
# 			8'd5: val <= 6'd35;
# 			8'd6: val <= 6'd36;
# 			8'd7: val <= 6'd36;
# 			8'd8: val <= 6'd37;
# 			8'd9: val <= 6'd38;
# 			8'd10: val <= 6'd39;
# 			8'd11: val <= 6'd39;
# 			8'd12: val <= 6'd40;
# 			8'd13: val <= 6'd41;
# 			8'd14: val <= 6'd41;
# 			8'd15: val <= 6'd42;
# 			8'd16: val <= 6'd43;
# 			8'd17: val <= 6'd44;
# 			8'd18: val <= 6'd44;
# 			8'd19: val <= 6'd45;
# 			8'd20: val <= 6'd46;
# 			8'd21: val <= 6'd46;
# 			8'd22: val <= 6'd47;
# 			8'd23: val <= 6'd48;
# 			8'd24: val <= 6'd48;
# 			8'd25: val <= 6'd49;
# 			8'd26: val <= 6'd49;
# 			8'd27: val <= 6'd50;
# 			8'd28: val <= 6'd51;
# 			8'd29: val <= 6'd51;
# 			8'd30: val <= 6'd52;
# 			8'd31: val <= 6'd52;
# 			8'd32: val <= 6'd53;
# 			8'd33: val <= 6'd53;
# 			8'd34: val <= 6'd54;
# 			8'd35: val <= 6'd54;
# 			8'd36: val <= 6'd55;
# 			8'd37: val <= 6'd55;
# 			8'd38: val <= 6'd56;
# 			8'd39: val <= 6'd56;
# 			8'd40: val <= 6'd57;
# 			8'd41: val <= 6'd57;
# 			8'd42: val <= 6'd58;
# 			8'd43: val <= 6'd58;
# 			8'd44: val <= 6'd58;
# 			8'd45: val <= 6'd59;
# 			8'd46: val <= 6'd59;
# 			8'd47: val <= 6'd59;
# 			8'd48: val <= 6'd60;
# 			8'd49: val <= 6'd60;
# 			8'd50: val <= 6'd60;
# 			8'd51: val <= 6'd60;
# 			8'd52: val <= 6'd61;
# 			8'd53: val <= 6'd61;
# 			8'd54: val <= 6'd61;
# 			8'd55: val <= 6'd61;
# 			8'd56: val <= 6'd61;
# 			8'd57: val <= 6'd62;
# 			8'd58: val <= 6'd62;
# 			8'd59: val <= 6'd62;
# 			8'd60: val <= 6'd62;
# 			8'd61: val <= 6'd62;
# 			8'd62: val <= 6'd62;
# 			8'd63: val <= 6'd62;
# 			8'd64: val <= 6'd62;
# 			8'd65: val <= 6'd62;
# 			8'd66: val <= 6'd62;
# 			8'd67: val <= 6'd62;
# 			8'd68: val <= 6'd62;
# 			8'd69: val <= 6'd62;
# 			8'd70: val <= 6'd62;
# 			8'd71: val <= 6'd62;
# 			8'd72: val <= 6'd61;
# 			8'd73: val <= 6'd61;
# 			8'd74: val <= 6'd61;
# 			8'd75: val <= 6'd61;
# 			8'd76: val <= 6'd61;
# 			8'd77: val <= 6'd60;
# 			8'd78: val <= 6'd60;
# 			8'd79: val <= 6'd60;
# 			8'd80: val <= 6'd60;
# 			8'd81: val <= 6'd59;
# 			8'd82: val <= 6'd59;
# 			8'd83: val <= 6'd59;
# 			8'd84: val <= 6'd58;
# 			8'd85: val <= 6'd58;
# 			8'd86: val <= 6'd58;
# 			8'd87: val <= 6'd57;
# 			8'd88: val <= 6'd57;
# 			8'd89: val <= 6'd56;
# 			8'd90: val <= 6'd56;
# 			8'd91: val <= 6'd55;
# 			8'd92: val <= 6'd55;
# 			8'd93: val <= 6'd54;
# 			8'd94: val <= 6'd54;
# 			8'd95: val <= 6'd53;
# 			8'd96: val <= 6'd53;
# 			8'd97: val <= 6'd52;
# 			8'd98: val <= 6'd52;
# 			8'd99: val <= 6'd51;
# 			8'd100: val <= 6'd51;
# 			8'd101: val <= 6'd50;
# 			8'd102: val <= 6'd49;
# 			8'd103: val <= 6'd49;
# 			8'd104: val <= 6'd48;
# 			8'd105: val <= 6'd48;
# 			8'd106: val <= 6'd47;
# 			8'd107: val <= 6'd46;
# 			8'd108: val <= 6'd46;
# 			8'd109: val <= 6'd45;
# 			8'd110: val <= 6'd44;
# 			8'd111: val <= 6'd44;
# 			8'd112: val <= 6'd43;
# 			8'd113: val <= 6'd42;
# 			8'd114: val <= 6'd41;
# 			8'd115: val <= 6'd41;
# 			8'd116: val <= 6'd40;
# 			8'd117: val <= 6'd39;
# 			8'd118: val <= 6'd39;
# 			8'd119: val <= 6'd38;
# 			8'd120: val <= 6'd37;
# 			8'd121: val <= 6'd36;
# 			8'd122: val <= 6'd36;
# 			8'd123: val <= 6'd35;
# 			8'd124: val <= 6'd34;
# 			8'd125: val <= 6'd33;
# 			8'd126: val <= 6'd33;
# 			8'd127: val <= 6'd32;
# 			8'd128: val <= 6'd31;
# 			8'd129: val <= 6'd30;
# 			8'd130: val <= 6'd29;
# 			8'd131: val <= 6'd29;
# 			8'd132: val <= 6'd28;
# 			8'd133: val <= 6'd27;
# 			8'd134: val <= 6'd26;
# 			8'd135: val <= 6'd26;
# 			8'd136: val <= 6'd25;
# 			8'd137: val <= 6'd24;
# 			8'd138: val <= 6'd23;
# 			8'd139: val <= 6'd23;
# 			8'd140: val <= 6'd22;
# 			8'd141: val <= 6'd21;
# 			8'd142: val <= 6'd21;
# 			8'd143: val <= 6'd20;
# 			8'd144: val <= 6'd19;
# 			8'd145: val <= 6'd18;
# 			8'd146: val <= 6'd18;
# 			8'd147: val <= 6'd17;
# 			8'd148: val <= 6'd16;
# 			8'd149: val <= 6'd16;
# 			8'd150: val <= 6'd15;
# 			8'd151: val <= 6'd14;
# 			8'd152: val <= 6'd14;
# 			8'd153: val <= 6'd13;
# 			8'd154: val <= 6'd13;
# 			8'd155: val <= 6'd12;
# 			8'd156: val <= 6'd11;
# 			8'd157: val <= 6'd11;
# 			8'd158: val <= 6'd10;
# 			8'd159: val <= 6'd10;
# 			8'd160: val <= 6'd9;
# 			8'd161: val <= 6'd9;
# 			8'd162: val <= 6'd8;
# 			8'd163: val <= 6'd8;
# 			8'd164: val <= 6'd7;
# 			8'd165: val <= 6'd7;
# 			8'd166: val <= 6'd6;
# 			8'd167: val <= 6'd6;
# 			8'd168: val <= 6'd5;
# 			8'd169: val <= 6'd5;
# 			8'd170: val <= 6'd4;
# 			8'd171: val <= 6'd4;
# 			8'd172: val <= 6'd4;
# 			8'd173: val <= 6'd3;
# 			8'd174: val <= 6'd3;
# 			8'd175: val <= 6'd3;
# 			8'd176: val <= 6'd2;
# 			8'd177: val <= 6'd2;
# 			8'd178: val <= 6'd2;
# 			8'd179: val <= 6'd2;
# 			8'd180: val <= 6'd1;
# 			8'd181: val <= 6'd1;
# 			8'd182: val <= 6'd1;
# 			8'd183: val <= 6'd1;
# 			8'd184: val <= 6'd1;
# 			8'd185: val <= 6'd0;
# 			8'd186: val <= 6'd0;
# 			8'd187: val <= 6'd0;
# 			8'd188: val <= 6'd0;
# 			8'd189: val <= 6'd0;
# 			8'd190: val <= 6'd0;
# 			8'd191: val <= 6'd0;
# 			8'd192: val <= 6'd0;
# 			8'd193: val <= 6'd0;
# 			8'd194: val <= 6'd0;
# 			8'd195: val <= 6'd0;
# 			8'd196: val <= 6'd0;
# 			8'd197: val <= 6'd0;
# 			8'd198: val <= 6'd0;
# 			8'd199: val <= 6'd0;
# 			8'd200: val <= 6'd1;
# 			8'd201: val <= 6'd1;
# 			8'd202: val <= 6'd1;
# 			8'd203: val <= 6'd1;
# 			8'd204: val <= 6'd1;
# 			8'd205: val <= 6'd2;
# 			8'd206: val <= 6'd2;
# 			8'd207: val <= 6'd2;
# 			8'd208: val <= 6'd2;
# 			8'd209: val <= 6'd3;
# 			8'd210: val <= 6'd3;
# 			8'd211: val <= 6'd3;
# 			8'd212: val <= 6'd4;
# 			8'd213: val <= 6'd4;
# 			8'd214: val <= 6'd4;
# 			8'd215: val <= 6'd5;
# 			8'd216: val <= 6'd5;
# 			8'd217: val <= 6'd6;
# 			8'd218: val <= 6'd6;
# 			8'd219: val <= 6'd7;
# 			8'd220: val <= 6'd7;
# 			8'd221: val <= 6'd8;
# 			8'd222: val <= 6'd8;
# 			8'd223: val <= 6'd9;
# 			8'd224: val <= 6'd9;
# 			8'd225: val <= 6'd10;
# 			8'd226: val <= 6'd10;
# 			8'd227: val <= 6'd11;
# 			8'd228: val <= 6'd11;
# 			8'd229: val <= 6'd12;
# 			8'd230: val <= 6'd13;
# 			8'd231: val <= 6'd13;
# 			8'd232: val <= 6'd14;
# 			8'd233: val <= 6'd14;
# 			8'd234: val <= 6'd15;
# 			8'd235: val <= 6'd16;
# 			8'd236: val <= 6'd16;
# 			8'd237: val <= 6'd17;
# 			8'd238: val <= 6'd18;
# 			8'd239: val <= 6'd18;
# 			8'd240: val <= 6'd19;
# 			8'd241: val <= 6'd20;
# 			8'd242: val <= 6'd21;
# 			8'd243: val <= 6'd21;
# 			8'd244: val <= 6'd22;
# 			8'd245: val <= 6'd23;
# 			8'd246: val <= 6'd23;
# 			8'd247: val <= 6'd24;
# 			8'd248: val <= 6'd25;
# 			8'd249: val <= 6'd26;
# 			8'd250: val <= 6'd26;
# 			8'd251: val <= 6'd27;
# 			8'd252: val <= 6'd28;
# 			8'd253: val <= 6'd29;
# 			8'd254: val <= 6'd29;
# 			8'd255: val <= 6'd30;
# 		endcase
# 	end
# endmodule
