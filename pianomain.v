`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:12:34 12/03/2011 
// Design Name: 
// Module Name:    pianomain 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module pianomain(vup,vdown,clk_50MHz,buttons,audio_out, leds);

input [12:0] buttons; // input buttons
input clk_50MHz;      // internal clock
input vup;            // increase volume
input vdown;          // decrease volume

output wire audio_out;  // ultimate summed PWM'd sound signal going to speaker
output wire [7:0] leds; // Volume Level Output

//Misc. inter-module wires
wire [9:0] wave0,wave1,wave2,wave3;          // Waves as they are generated from
wire [9:0] wave4,wave5,wave6,wave7;          // the wave generators. They are not
wire [9:0] wave8,wave9,wave10,wave11,wave12; // ajusted for volume.
wire [9:0] vwave0,vwave1,vwave2,vwave3;           // 
wire [9:0] vwave4,vwave5,vwave6,vwave7;           // The same waves ajusted for volume
wire [9:0] vwave8,vwave9,vwave10,vwave11,vwave12; //
wire [12:0] d_buttons; // the button inputs after being debounced
wire [13:0] swave; // the addition of all the indiviual waveforms, ajusted for volume


// Control Systems
wire [1:0] volume_buttons; // Input buttons for volume
wire [3:0] vcontrol; // Volume Control: 0, 1/8, 1/4, 3/8, 1/2, 5/8, 3/4 7/8, 1

 // 50MHz / (NOTE * 1023) = NOTE FREQ
 
parameter C4 = 186;  // 261.626 Hz
parameter Cs4 = 176; // 277.183 Hz
parameter D4 = 166;  // 293.665 Hz    These parameters get sent to the sine generators
parameter Ds4 = 157; // 311.127 Hz    and control the frequency of the output wave.
parameter E4 = 148;  // 329.628 Hz
parameter F4 = 139;  // 349.228 Hz
parameter Fs4 = 132; // 369.994 Hz
parameter G4 = 124;  // 391.995 Hz
parameter Gs4 = 117; // 415.305 Hz
parameter A4 = 111;  // 440.000 Hz
parameter As4 = 104; // 466.164 Hz
parameter B4 = 98;   // 493.883 Hz
parameter C5 = 93;   // 523.251 Hz

// Debouncing the buttons
debouncer db0(buttons[0],  clk_50MHz, d_buttons[0]);
debouncer db1(buttons[1],  clk_50MHz, d_buttons[1]);
debouncer db2(buttons[2],  clk_50MHz, d_buttons[2]);
debouncer db3(buttons[3],  clk_50MHz, d_buttons[3]);
debouncer db4(buttons[4],  clk_50MHz, d_buttons[4]);
debouncer db5(buttons[5],  clk_50MHz, d_buttons[5]);
debouncer db6(buttons[6],  clk_50MHz, d_buttons[6]);
debouncer db7(buttons[7],  clk_50MHz, d_buttons[7]);
debouncer db8(buttons[8],  clk_50MHz, d_buttons[8]);
debouncer db9(buttons[9],  clk_50MHz, d_buttons[9]);
debouncer db10(buttons[10],clk_50MHz, d_buttons[10]);
debouncer db11(buttons[11],clk_50MHz, d_buttons[11]);
debouncer db12(buttons[12],clk_50MHz, d_buttons[12]);

debouncer dbv1(vup,  clk_50MHz, d_up);
debouncer dbv2(vdown,clk_50MHz, d_down);

 // Frequency of sin wave is calculated by dividing the 50MHz clock by the parameter speed,
 // which sets the internal clock speed of the sine generator to 255 times faster
 // than the desired frequency. Because the generator takes 255 clocks to cycle
 // through the whole lookup table and create one period of the sine wave the
 // generator will create a sine wave at exactly the desired frequency.

sin_generator sg0(C4,  d_buttons[0], clk_50MHz,wave0);
sin_generator sg1(Cs4, d_buttons[1], clk_50MHz,wave1);
sin_generator sg2(D4,  d_buttons[2], clk_50MHz,wave2);
sin_generator sg3(Ds4, d_buttons[3], clk_50MHz,wave3);
sin_generator sg4(E4,  d_buttons[4], clk_50MHz,wave4);
sin_generator sg5(F4,  d_buttons[5], clk_50MHz,wave5);
sin_generator sg6(Fs4, d_buttons[6], clk_50MHz,wave6);
sin_generator sg7(G4,  d_buttons[7], clk_50MHz,wave7);
sin_generator sg8(Gs4, d_buttons[8], clk_50MHz,wave8);
sin_generator sg9(A4,  d_buttons[9], clk_50MHz,wave9);
sin_generator sg10(As4,d_buttons[10],clk_50MHz,wave10);
sin_generator sg11(B4, d_buttons[11],clk_50MHz,wave11);
sin_generator sg12(C5, d_buttons[12],clk_50MHz,wave12);

// -- Volume Control the individual waves -- //

// Make the volume_buttons edge sensitive
pos_edge pe0( d_down,clk_50MHz, volume_buttons[0]);
pos_edge pe1( d_up, clk_50MHz, volume_buttons[1]);

// Generate the control signals
volume_buttons vb0(.inc_dec(volume_buttons[1:0]), .clk(clk_50MHz), .control(vcontrol));


volume_control_display vcd0(.control(vcontrol), .clk(clk_50MHz), .display(leds));

volume_control vctrl0( .inwave(wave0), .control(vcontrol),.outwave(vwave0));
volume_control vctrl1( .inwave(wave1), .control(vcontrol),.outwave(vwave1));
volume_control vctrl2( .inwave(wave2), .control(vcontrol),.outwave(vwave2));
volume_control vctrl3( .inwave(wave3), .control(vcontrol),.outwave(vwave3));
volume_control vctrl4( .inwave(wave4), .control(vcontrol),.outwave(vwave4));
volume_control vctrl5( .inwave(wave5), .control(vcontrol),.outwave(vwave5));
volume_control vctrl6( .inwave(wave6), .control(vcontrol),.outwave(vwave6));
volume_control vctrl7( .inwave(wave7), .control(vcontrol),.outwave(vwave7));
volume_control vctrl8( .inwave(wave8), .control(vcontrol),.outwave(vwave8));
volume_control vctrl9( .inwave(wave9), .control(vcontrol),.outwave(vwave9));
volume_control vctrl10(.inwave(wave10),.control(vcontrol),.outwave(vwave10));
volume_control vctrl11(.inwave(wave11),.control(vcontrol),.outwave(vwave11));
volume_control vctrl12(.inwave(wave12),.control(vcontrol),.outwave(vwave12));

// -- Sum the Waves Together
// Add the sine waves together
sumer smr(vwave0,vwave1,vwave2,vwave3,vwave4,vwave5,vwave6,vwave7,vwave8,vwave9,vwave10, vwave11, vwave12, swave);

pwm pulse(swave,clk_50MHz,audio_out);


endmodule