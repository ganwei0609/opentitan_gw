// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// SECDED Decoder generated by
// util/design/secded_gen.py -m 6 -k 16 -s 3741324996 -c hsiao

module prim_secded_22_16_dec (
  input        [21:0] in,
  output logic [15:0] d_o,
  output logic [5:0] syndrome_o,
  output logic [1:0] err_o
);


  // Syndrome calculation
  assign syndrome_o[0] = ^(in & 22'h01C5C6);
  assign syndrome_o[1] = ^(in & 22'h023317);
  assign syndrome_o[2] = ^(in & 22'h049E2C);
  assign syndrome_o[3] = ^(in & 22'h0831E9);
  assign syndrome_o[4] = ^(in & 22'h10CA71);
  assign syndrome_o[5] = ^(in & 22'h206C9A);

  // Corrected output calculation
  assign d_o[0] = (syndrome_o == 6'h1a) ^ in[0];
  assign d_o[1] = (syndrome_o == 6'h23) ^ in[1];
  assign d_o[2] = (syndrome_o == 6'h7) ^ in[2];
  assign d_o[3] = (syndrome_o == 6'h2c) ^ in[3];
  assign d_o[4] = (syndrome_o == 6'h32) ^ in[4];
  assign d_o[5] = (syndrome_o == 6'h1c) ^ in[5];
  assign d_o[6] = (syndrome_o == 6'h19) ^ in[6];
  assign d_o[7] = (syndrome_o == 6'h29) ^ in[7];
  assign d_o[8] = (syndrome_o == 6'hb) ^ in[8];
  assign d_o[9] = (syndrome_o == 6'h16) ^ in[9];
  assign d_o[10] = (syndrome_o == 6'h25) ^ in[10];
  assign d_o[11] = (syndrome_o == 6'h34) ^ in[11];
  assign d_o[12] = (syndrome_o == 6'he) ^ in[12];
  assign d_o[13] = (syndrome_o == 6'h2a) ^ in[13];
  assign d_o[14] = (syndrome_o == 6'h31) ^ in[14];
  assign d_o[15] = (syndrome_o == 6'h15) ^ in[15];

  // err_o calc. bit0: single error, bit1: double error
  assign err_o[0] = ^syndrome_o;
  assign err_o[1] = ~err_o[0] & (|syndrome_o);

endmodule : prim_secded_22_16_dec
