// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Register Package auto-generated by `reggen` containing data structure

package rv_plic_reg_pkg;

  // Param list
  parameter int NumSrc = 123;
  parameter int NumTarget = 1;
  parameter int PrioWidth = 2;

  // Address width within the block
  parameter int BlockAw = 10;

  ////////////////////////////
  // Typedefs for registers //
  ////////////////////////////
  typedef struct packed {
    logic        q;
  } rv_plic_reg2hw_le_mreg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio0_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio1_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio2_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio3_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio4_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio5_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio6_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio7_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio8_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio9_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio10_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio11_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio12_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio13_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio14_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio15_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio16_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio17_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio18_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio19_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio20_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio21_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio22_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio23_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio24_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio25_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio26_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio27_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio28_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio29_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio30_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio31_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio32_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio33_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio34_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio35_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio36_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio37_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio38_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio39_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio40_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio41_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio42_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio43_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio44_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio45_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio46_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio47_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio48_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio49_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio50_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio51_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio52_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio53_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio54_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio55_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio56_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio57_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio58_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio59_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio60_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio61_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio62_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio63_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio64_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio65_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio66_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio67_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio68_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio69_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio70_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio71_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio72_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio73_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio74_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio75_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio76_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio77_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio78_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio79_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio80_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio81_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio82_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio83_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio84_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio85_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio86_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio87_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio88_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio89_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio90_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio91_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio92_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio93_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio94_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio95_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio96_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio97_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio98_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio99_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio100_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio101_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio102_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio103_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio104_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio105_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio106_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio107_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio108_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio109_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio110_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio111_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio112_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio113_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio114_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio115_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio116_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio117_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio118_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio119_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio120_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio121_reg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_prio122_reg_t;

  typedef struct packed {
    logic        q;
  } rv_plic_reg2hw_ie0_mreg_t;

  typedef struct packed {
    logic [1:0]  q;
  } rv_plic_reg2hw_threshold0_reg_t;

  typedef struct packed {
    logic [6:0]  q;
    logic        qe;
    logic        re;
  } rv_plic_reg2hw_cc0_reg_t;

  typedef struct packed {
    logic        q;
  } rv_plic_reg2hw_msip0_reg_t;


  typedef struct packed {
    logic        d;
    logic        de;
  } rv_plic_hw2reg_ip_mreg_t;

  typedef struct packed {
    logic [6:0]  d;
  } rv_plic_hw2reg_cc0_reg_t;


  ///////////////////////////////////////
  // Register to internal design logic //
  ///////////////////////////////////////
  typedef struct packed {
    rv_plic_reg2hw_le_mreg_t [122:0] le; // [503:381]
    rv_plic_reg2hw_prio0_reg_t prio0; // [380:379]
    rv_plic_reg2hw_prio1_reg_t prio1; // [378:377]
    rv_plic_reg2hw_prio2_reg_t prio2; // [376:375]
    rv_plic_reg2hw_prio3_reg_t prio3; // [374:373]
    rv_plic_reg2hw_prio4_reg_t prio4; // [372:371]
    rv_plic_reg2hw_prio5_reg_t prio5; // [370:369]
    rv_plic_reg2hw_prio6_reg_t prio6; // [368:367]
    rv_plic_reg2hw_prio7_reg_t prio7; // [366:365]
    rv_plic_reg2hw_prio8_reg_t prio8; // [364:363]
    rv_plic_reg2hw_prio9_reg_t prio9; // [362:361]
    rv_plic_reg2hw_prio10_reg_t prio10; // [360:359]
    rv_plic_reg2hw_prio11_reg_t prio11; // [358:357]
    rv_plic_reg2hw_prio12_reg_t prio12; // [356:355]
    rv_plic_reg2hw_prio13_reg_t prio13; // [354:353]
    rv_plic_reg2hw_prio14_reg_t prio14; // [352:351]
    rv_plic_reg2hw_prio15_reg_t prio15; // [350:349]
    rv_plic_reg2hw_prio16_reg_t prio16; // [348:347]
    rv_plic_reg2hw_prio17_reg_t prio17; // [346:345]
    rv_plic_reg2hw_prio18_reg_t prio18; // [344:343]
    rv_plic_reg2hw_prio19_reg_t prio19; // [342:341]
    rv_plic_reg2hw_prio20_reg_t prio20; // [340:339]
    rv_plic_reg2hw_prio21_reg_t prio21; // [338:337]
    rv_plic_reg2hw_prio22_reg_t prio22; // [336:335]
    rv_plic_reg2hw_prio23_reg_t prio23; // [334:333]
    rv_plic_reg2hw_prio24_reg_t prio24; // [332:331]
    rv_plic_reg2hw_prio25_reg_t prio25; // [330:329]
    rv_plic_reg2hw_prio26_reg_t prio26; // [328:327]
    rv_plic_reg2hw_prio27_reg_t prio27; // [326:325]
    rv_plic_reg2hw_prio28_reg_t prio28; // [324:323]
    rv_plic_reg2hw_prio29_reg_t prio29; // [322:321]
    rv_plic_reg2hw_prio30_reg_t prio30; // [320:319]
    rv_plic_reg2hw_prio31_reg_t prio31; // [318:317]
    rv_plic_reg2hw_prio32_reg_t prio32; // [316:315]
    rv_plic_reg2hw_prio33_reg_t prio33; // [314:313]
    rv_plic_reg2hw_prio34_reg_t prio34; // [312:311]
    rv_plic_reg2hw_prio35_reg_t prio35; // [310:309]
    rv_plic_reg2hw_prio36_reg_t prio36; // [308:307]
    rv_plic_reg2hw_prio37_reg_t prio37; // [306:305]
    rv_plic_reg2hw_prio38_reg_t prio38; // [304:303]
    rv_plic_reg2hw_prio39_reg_t prio39; // [302:301]
    rv_plic_reg2hw_prio40_reg_t prio40; // [300:299]
    rv_plic_reg2hw_prio41_reg_t prio41; // [298:297]
    rv_plic_reg2hw_prio42_reg_t prio42; // [296:295]
    rv_plic_reg2hw_prio43_reg_t prio43; // [294:293]
    rv_plic_reg2hw_prio44_reg_t prio44; // [292:291]
    rv_plic_reg2hw_prio45_reg_t prio45; // [290:289]
    rv_plic_reg2hw_prio46_reg_t prio46; // [288:287]
    rv_plic_reg2hw_prio47_reg_t prio47; // [286:285]
    rv_plic_reg2hw_prio48_reg_t prio48; // [284:283]
    rv_plic_reg2hw_prio49_reg_t prio49; // [282:281]
    rv_plic_reg2hw_prio50_reg_t prio50; // [280:279]
    rv_plic_reg2hw_prio51_reg_t prio51; // [278:277]
    rv_plic_reg2hw_prio52_reg_t prio52; // [276:275]
    rv_plic_reg2hw_prio53_reg_t prio53; // [274:273]
    rv_plic_reg2hw_prio54_reg_t prio54; // [272:271]
    rv_plic_reg2hw_prio55_reg_t prio55; // [270:269]
    rv_plic_reg2hw_prio56_reg_t prio56; // [268:267]
    rv_plic_reg2hw_prio57_reg_t prio57; // [266:265]
    rv_plic_reg2hw_prio58_reg_t prio58; // [264:263]
    rv_plic_reg2hw_prio59_reg_t prio59; // [262:261]
    rv_plic_reg2hw_prio60_reg_t prio60; // [260:259]
    rv_plic_reg2hw_prio61_reg_t prio61; // [258:257]
    rv_plic_reg2hw_prio62_reg_t prio62; // [256:255]
    rv_plic_reg2hw_prio63_reg_t prio63; // [254:253]
    rv_plic_reg2hw_prio64_reg_t prio64; // [252:251]
    rv_plic_reg2hw_prio65_reg_t prio65; // [250:249]
    rv_plic_reg2hw_prio66_reg_t prio66; // [248:247]
    rv_plic_reg2hw_prio67_reg_t prio67; // [246:245]
    rv_plic_reg2hw_prio68_reg_t prio68; // [244:243]
    rv_plic_reg2hw_prio69_reg_t prio69; // [242:241]
    rv_plic_reg2hw_prio70_reg_t prio70; // [240:239]
    rv_plic_reg2hw_prio71_reg_t prio71; // [238:237]
    rv_plic_reg2hw_prio72_reg_t prio72; // [236:235]
    rv_plic_reg2hw_prio73_reg_t prio73; // [234:233]
    rv_plic_reg2hw_prio74_reg_t prio74; // [232:231]
    rv_plic_reg2hw_prio75_reg_t prio75; // [230:229]
    rv_plic_reg2hw_prio76_reg_t prio76; // [228:227]
    rv_plic_reg2hw_prio77_reg_t prio77; // [226:225]
    rv_plic_reg2hw_prio78_reg_t prio78; // [224:223]
    rv_plic_reg2hw_prio79_reg_t prio79; // [222:221]
    rv_plic_reg2hw_prio80_reg_t prio80; // [220:219]
    rv_plic_reg2hw_prio81_reg_t prio81; // [218:217]
    rv_plic_reg2hw_prio82_reg_t prio82; // [216:215]
    rv_plic_reg2hw_prio83_reg_t prio83; // [214:213]
    rv_plic_reg2hw_prio84_reg_t prio84; // [212:211]
    rv_plic_reg2hw_prio85_reg_t prio85; // [210:209]
    rv_plic_reg2hw_prio86_reg_t prio86; // [208:207]
    rv_plic_reg2hw_prio87_reg_t prio87; // [206:205]
    rv_plic_reg2hw_prio88_reg_t prio88; // [204:203]
    rv_plic_reg2hw_prio89_reg_t prio89; // [202:201]
    rv_plic_reg2hw_prio90_reg_t prio90; // [200:199]
    rv_plic_reg2hw_prio91_reg_t prio91; // [198:197]
    rv_plic_reg2hw_prio92_reg_t prio92; // [196:195]
    rv_plic_reg2hw_prio93_reg_t prio93; // [194:193]
    rv_plic_reg2hw_prio94_reg_t prio94; // [192:191]
    rv_plic_reg2hw_prio95_reg_t prio95; // [190:189]
    rv_plic_reg2hw_prio96_reg_t prio96; // [188:187]
    rv_plic_reg2hw_prio97_reg_t prio97; // [186:185]
    rv_plic_reg2hw_prio98_reg_t prio98; // [184:183]
    rv_plic_reg2hw_prio99_reg_t prio99; // [182:181]
    rv_plic_reg2hw_prio100_reg_t prio100; // [180:179]
    rv_plic_reg2hw_prio101_reg_t prio101; // [178:177]
    rv_plic_reg2hw_prio102_reg_t prio102; // [176:175]
    rv_plic_reg2hw_prio103_reg_t prio103; // [174:173]
    rv_plic_reg2hw_prio104_reg_t prio104; // [172:171]
    rv_plic_reg2hw_prio105_reg_t prio105; // [170:169]
    rv_plic_reg2hw_prio106_reg_t prio106; // [168:167]
    rv_plic_reg2hw_prio107_reg_t prio107; // [166:165]
    rv_plic_reg2hw_prio108_reg_t prio108; // [164:163]
    rv_plic_reg2hw_prio109_reg_t prio109; // [162:161]
    rv_plic_reg2hw_prio110_reg_t prio110; // [160:159]
    rv_plic_reg2hw_prio111_reg_t prio111; // [158:157]
    rv_plic_reg2hw_prio112_reg_t prio112; // [156:155]
    rv_plic_reg2hw_prio113_reg_t prio113; // [154:153]
    rv_plic_reg2hw_prio114_reg_t prio114; // [152:151]
    rv_plic_reg2hw_prio115_reg_t prio115; // [150:149]
    rv_plic_reg2hw_prio116_reg_t prio116; // [148:147]
    rv_plic_reg2hw_prio117_reg_t prio117; // [146:145]
    rv_plic_reg2hw_prio118_reg_t prio118; // [144:143]
    rv_plic_reg2hw_prio119_reg_t prio119; // [142:141]
    rv_plic_reg2hw_prio120_reg_t prio120; // [140:139]
    rv_plic_reg2hw_prio121_reg_t prio121; // [138:137]
    rv_plic_reg2hw_prio122_reg_t prio122; // [136:135]
    rv_plic_reg2hw_ie0_mreg_t [122:0] ie0; // [134:12]
    rv_plic_reg2hw_threshold0_reg_t threshold0; // [11:10]
    rv_plic_reg2hw_cc0_reg_t cc0; // [9:1]
    rv_plic_reg2hw_msip0_reg_t msip0; // [0:0]
  } rv_plic_reg2hw_t;

  ///////////////////////////////////////
  // Internal design logic to register //
  ///////////////////////////////////////
  typedef struct packed {
    rv_plic_hw2reg_ip_mreg_t [122:0] ip; // [252:7]
    rv_plic_hw2reg_cc0_reg_t cc0; // [6:0]
  } rv_plic_hw2reg_t;

  // Register Address
  parameter logic [BlockAw-1:0] RV_PLIC_IP_0_OFFSET = 10'h 0;
  parameter logic [BlockAw-1:0] RV_PLIC_IP_1_OFFSET = 10'h 4;
  parameter logic [BlockAw-1:0] RV_PLIC_IP_2_OFFSET = 10'h 8;
  parameter logic [BlockAw-1:0] RV_PLIC_IP_3_OFFSET = 10'h c;
  parameter logic [BlockAw-1:0] RV_PLIC_LE_0_OFFSET = 10'h 10;
  parameter logic [BlockAw-1:0] RV_PLIC_LE_1_OFFSET = 10'h 14;
  parameter logic [BlockAw-1:0] RV_PLIC_LE_2_OFFSET = 10'h 18;
  parameter logic [BlockAw-1:0] RV_PLIC_LE_3_OFFSET = 10'h 1c;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO0_OFFSET = 10'h 20;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO1_OFFSET = 10'h 24;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO2_OFFSET = 10'h 28;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO3_OFFSET = 10'h 2c;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO4_OFFSET = 10'h 30;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO5_OFFSET = 10'h 34;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO6_OFFSET = 10'h 38;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO7_OFFSET = 10'h 3c;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO8_OFFSET = 10'h 40;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO9_OFFSET = 10'h 44;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO10_OFFSET = 10'h 48;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO11_OFFSET = 10'h 4c;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO12_OFFSET = 10'h 50;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO13_OFFSET = 10'h 54;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO14_OFFSET = 10'h 58;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO15_OFFSET = 10'h 5c;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO16_OFFSET = 10'h 60;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO17_OFFSET = 10'h 64;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO18_OFFSET = 10'h 68;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO19_OFFSET = 10'h 6c;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO20_OFFSET = 10'h 70;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO21_OFFSET = 10'h 74;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO22_OFFSET = 10'h 78;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO23_OFFSET = 10'h 7c;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO24_OFFSET = 10'h 80;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO25_OFFSET = 10'h 84;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO26_OFFSET = 10'h 88;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO27_OFFSET = 10'h 8c;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO28_OFFSET = 10'h 90;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO29_OFFSET = 10'h 94;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO30_OFFSET = 10'h 98;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO31_OFFSET = 10'h 9c;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO32_OFFSET = 10'h a0;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO33_OFFSET = 10'h a4;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO34_OFFSET = 10'h a8;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO35_OFFSET = 10'h ac;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO36_OFFSET = 10'h b0;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO37_OFFSET = 10'h b4;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO38_OFFSET = 10'h b8;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO39_OFFSET = 10'h bc;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO40_OFFSET = 10'h c0;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO41_OFFSET = 10'h c4;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO42_OFFSET = 10'h c8;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO43_OFFSET = 10'h cc;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO44_OFFSET = 10'h d0;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO45_OFFSET = 10'h d4;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO46_OFFSET = 10'h d8;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO47_OFFSET = 10'h dc;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO48_OFFSET = 10'h e0;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO49_OFFSET = 10'h e4;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO50_OFFSET = 10'h e8;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO51_OFFSET = 10'h ec;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO52_OFFSET = 10'h f0;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO53_OFFSET = 10'h f4;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO54_OFFSET = 10'h f8;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO55_OFFSET = 10'h fc;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO56_OFFSET = 10'h 100;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO57_OFFSET = 10'h 104;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO58_OFFSET = 10'h 108;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO59_OFFSET = 10'h 10c;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO60_OFFSET = 10'h 110;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO61_OFFSET = 10'h 114;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO62_OFFSET = 10'h 118;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO63_OFFSET = 10'h 11c;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO64_OFFSET = 10'h 120;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO65_OFFSET = 10'h 124;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO66_OFFSET = 10'h 128;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO67_OFFSET = 10'h 12c;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO68_OFFSET = 10'h 130;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO69_OFFSET = 10'h 134;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO70_OFFSET = 10'h 138;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO71_OFFSET = 10'h 13c;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO72_OFFSET = 10'h 140;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO73_OFFSET = 10'h 144;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO74_OFFSET = 10'h 148;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO75_OFFSET = 10'h 14c;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO76_OFFSET = 10'h 150;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO77_OFFSET = 10'h 154;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO78_OFFSET = 10'h 158;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO79_OFFSET = 10'h 15c;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO80_OFFSET = 10'h 160;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO81_OFFSET = 10'h 164;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO82_OFFSET = 10'h 168;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO83_OFFSET = 10'h 16c;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO84_OFFSET = 10'h 170;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO85_OFFSET = 10'h 174;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO86_OFFSET = 10'h 178;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO87_OFFSET = 10'h 17c;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO88_OFFSET = 10'h 180;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO89_OFFSET = 10'h 184;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO90_OFFSET = 10'h 188;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO91_OFFSET = 10'h 18c;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO92_OFFSET = 10'h 190;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO93_OFFSET = 10'h 194;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO94_OFFSET = 10'h 198;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO95_OFFSET = 10'h 19c;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO96_OFFSET = 10'h 1a0;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO97_OFFSET = 10'h 1a4;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO98_OFFSET = 10'h 1a8;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO99_OFFSET = 10'h 1ac;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO100_OFFSET = 10'h 1b0;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO101_OFFSET = 10'h 1b4;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO102_OFFSET = 10'h 1b8;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO103_OFFSET = 10'h 1bc;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO104_OFFSET = 10'h 1c0;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO105_OFFSET = 10'h 1c4;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO106_OFFSET = 10'h 1c8;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO107_OFFSET = 10'h 1cc;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO108_OFFSET = 10'h 1d0;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO109_OFFSET = 10'h 1d4;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO110_OFFSET = 10'h 1d8;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO111_OFFSET = 10'h 1dc;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO112_OFFSET = 10'h 1e0;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO113_OFFSET = 10'h 1e4;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO114_OFFSET = 10'h 1e8;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO115_OFFSET = 10'h 1ec;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO116_OFFSET = 10'h 1f0;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO117_OFFSET = 10'h 1f4;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO118_OFFSET = 10'h 1f8;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO119_OFFSET = 10'h 1fc;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO120_OFFSET = 10'h 200;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO121_OFFSET = 10'h 204;
  parameter logic [BlockAw-1:0] RV_PLIC_PRIO122_OFFSET = 10'h 208;
  parameter logic [BlockAw-1:0] RV_PLIC_IE0_0_OFFSET = 10'h 300;
  parameter logic [BlockAw-1:0] RV_PLIC_IE0_1_OFFSET = 10'h 304;
  parameter logic [BlockAw-1:0] RV_PLIC_IE0_2_OFFSET = 10'h 308;
  parameter logic [BlockAw-1:0] RV_PLIC_IE0_3_OFFSET = 10'h 30c;
  parameter logic [BlockAw-1:0] RV_PLIC_THRESHOLD0_OFFSET = 10'h 310;
  parameter logic [BlockAw-1:0] RV_PLIC_CC0_OFFSET = 10'h 314;
  parameter logic [BlockAw-1:0] RV_PLIC_MSIP0_OFFSET = 10'h 318;


  // Register Index
  typedef enum int {
    RV_PLIC_IP_0,
    RV_PLIC_IP_1,
    RV_PLIC_IP_2,
    RV_PLIC_IP_3,
    RV_PLIC_LE_0,
    RV_PLIC_LE_1,
    RV_PLIC_LE_2,
    RV_PLIC_LE_3,
    RV_PLIC_PRIO0,
    RV_PLIC_PRIO1,
    RV_PLIC_PRIO2,
    RV_PLIC_PRIO3,
    RV_PLIC_PRIO4,
    RV_PLIC_PRIO5,
    RV_PLIC_PRIO6,
    RV_PLIC_PRIO7,
    RV_PLIC_PRIO8,
    RV_PLIC_PRIO9,
    RV_PLIC_PRIO10,
    RV_PLIC_PRIO11,
    RV_PLIC_PRIO12,
    RV_PLIC_PRIO13,
    RV_PLIC_PRIO14,
    RV_PLIC_PRIO15,
    RV_PLIC_PRIO16,
    RV_PLIC_PRIO17,
    RV_PLIC_PRIO18,
    RV_PLIC_PRIO19,
    RV_PLIC_PRIO20,
    RV_PLIC_PRIO21,
    RV_PLIC_PRIO22,
    RV_PLIC_PRIO23,
    RV_PLIC_PRIO24,
    RV_PLIC_PRIO25,
    RV_PLIC_PRIO26,
    RV_PLIC_PRIO27,
    RV_PLIC_PRIO28,
    RV_PLIC_PRIO29,
    RV_PLIC_PRIO30,
    RV_PLIC_PRIO31,
    RV_PLIC_PRIO32,
    RV_PLIC_PRIO33,
    RV_PLIC_PRIO34,
    RV_PLIC_PRIO35,
    RV_PLIC_PRIO36,
    RV_PLIC_PRIO37,
    RV_PLIC_PRIO38,
    RV_PLIC_PRIO39,
    RV_PLIC_PRIO40,
    RV_PLIC_PRIO41,
    RV_PLIC_PRIO42,
    RV_PLIC_PRIO43,
    RV_PLIC_PRIO44,
    RV_PLIC_PRIO45,
    RV_PLIC_PRIO46,
    RV_PLIC_PRIO47,
    RV_PLIC_PRIO48,
    RV_PLIC_PRIO49,
    RV_PLIC_PRIO50,
    RV_PLIC_PRIO51,
    RV_PLIC_PRIO52,
    RV_PLIC_PRIO53,
    RV_PLIC_PRIO54,
    RV_PLIC_PRIO55,
    RV_PLIC_PRIO56,
    RV_PLIC_PRIO57,
    RV_PLIC_PRIO58,
    RV_PLIC_PRIO59,
    RV_PLIC_PRIO60,
    RV_PLIC_PRIO61,
    RV_PLIC_PRIO62,
    RV_PLIC_PRIO63,
    RV_PLIC_PRIO64,
    RV_PLIC_PRIO65,
    RV_PLIC_PRIO66,
    RV_PLIC_PRIO67,
    RV_PLIC_PRIO68,
    RV_PLIC_PRIO69,
    RV_PLIC_PRIO70,
    RV_PLIC_PRIO71,
    RV_PLIC_PRIO72,
    RV_PLIC_PRIO73,
    RV_PLIC_PRIO74,
    RV_PLIC_PRIO75,
    RV_PLIC_PRIO76,
    RV_PLIC_PRIO77,
    RV_PLIC_PRIO78,
    RV_PLIC_PRIO79,
    RV_PLIC_PRIO80,
    RV_PLIC_PRIO81,
    RV_PLIC_PRIO82,
    RV_PLIC_PRIO83,
    RV_PLIC_PRIO84,
    RV_PLIC_PRIO85,
    RV_PLIC_PRIO86,
    RV_PLIC_PRIO87,
    RV_PLIC_PRIO88,
    RV_PLIC_PRIO89,
    RV_PLIC_PRIO90,
    RV_PLIC_PRIO91,
    RV_PLIC_PRIO92,
    RV_PLIC_PRIO93,
    RV_PLIC_PRIO94,
    RV_PLIC_PRIO95,
    RV_PLIC_PRIO96,
    RV_PLIC_PRIO97,
    RV_PLIC_PRIO98,
    RV_PLIC_PRIO99,
    RV_PLIC_PRIO100,
    RV_PLIC_PRIO101,
    RV_PLIC_PRIO102,
    RV_PLIC_PRIO103,
    RV_PLIC_PRIO104,
    RV_PLIC_PRIO105,
    RV_PLIC_PRIO106,
    RV_PLIC_PRIO107,
    RV_PLIC_PRIO108,
    RV_PLIC_PRIO109,
    RV_PLIC_PRIO110,
    RV_PLIC_PRIO111,
    RV_PLIC_PRIO112,
    RV_PLIC_PRIO113,
    RV_PLIC_PRIO114,
    RV_PLIC_PRIO115,
    RV_PLIC_PRIO116,
    RV_PLIC_PRIO117,
    RV_PLIC_PRIO118,
    RV_PLIC_PRIO119,
    RV_PLIC_PRIO120,
    RV_PLIC_PRIO121,
    RV_PLIC_PRIO122,
    RV_PLIC_IE0_0,
    RV_PLIC_IE0_1,
    RV_PLIC_IE0_2,
    RV_PLIC_IE0_3,
    RV_PLIC_THRESHOLD0,
    RV_PLIC_CC0,
    RV_PLIC_MSIP0
  } rv_plic_id_e;

  // Register width information to check illegal writes
  parameter logic [3:0] RV_PLIC_PERMIT [138] = '{
    4'b 1111, // index[  0] RV_PLIC_IP_0
    4'b 1111, // index[  1] RV_PLIC_IP_1
    4'b 1111, // index[  2] RV_PLIC_IP_2
    4'b 1111, // index[  3] RV_PLIC_IP_3
    4'b 1111, // index[  4] RV_PLIC_LE_0
    4'b 1111, // index[  5] RV_PLIC_LE_1
    4'b 1111, // index[  6] RV_PLIC_LE_2
    4'b 1111, // index[  7] RV_PLIC_LE_3
    4'b 0001, // index[  8] RV_PLIC_PRIO0
    4'b 0001, // index[  9] RV_PLIC_PRIO1
    4'b 0001, // index[ 10] RV_PLIC_PRIO2
    4'b 0001, // index[ 11] RV_PLIC_PRIO3
    4'b 0001, // index[ 12] RV_PLIC_PRIO4
    4'b 0001, // index[ 13] RV_PLIC_PRIO5
    4'b 0001, // index[ 14] RV_PLIC_PRIO6
    4'b 0001, // index[ 15] RV_PLIC_PRIO7
    4'b 0001, // index[ 16] RV_PLIC_PRIO8
    4'b 0001, // index[ 17] RV_PLIC_PRIO9
    4'b 0001, // index[ 18] RV_PLIC_PRIO10
    4'b 0001, // index[ 19] RV_PLIC_PRIO11
    4'b 0001, // index[ 20] RV_PLIC_PRIO12
    4'b 0001, // index[ 21] RV_PLIC_PRIO13
    4'b 0001, // index[ 22] RV_PLIC_PRIO14
    4'b 0001, // index[ 23] RV_PLIC_PRIO15
    4'b 0001, // index[ 24] RV_PLIC_PRIO16
    4'b 0001, // index[ 25] RV_PLIC_PRIO17
    4'b 0001, // index[ 26] RV_PLIC_PRIO18
    4'b 0001, // index[ 27] RV_PLIC_PRIO19
    4'b 0001, // index[ 28] RV_PLIC_PRIO20
    4'b 0001, // index[ 29] RV_PLIC_PRIO21
    4'b 0001, // index[ 30] RV_PLIC_PRIO22
    4'b 0001, // index[ 31] RV_PLIC_PRIO23
    4'b 0001, // index[ 32] RV_PLIC_PRIO24
    4'b 0001, // index[ 33] RV_PLIC_PRIO25
    4'b 0001, // index[ 34] RV_PLIC_PRIO26
    4'b 0001, // index[ 35] RV_PLIC_PRIO27
    4'b 0001, // index[ 36] RV_PLIC_PRIO28
    4'b 0001, // index[ 37] RV_PLIC_PRIO29
    4'b 0001, // index[ 38] RV_PLIC_PRIO30
    4'b 0001, // index[ 39] RV_PLIC_PRIO31
    4'b 0001, // index[ 40] RV_PLIC_PRIO32
    4'b 0001, // index[ 41] RV_PLIC_PRIO33
    4'b 0001, // index[ 42] RV_PLIC_PRIO34
    4'b 0001, // index[ 43] RV_PLIC_PRIO35
    4'b 0001, // index[ 44] RV_PLIC_PRIO36
    4'b 0001, // index[ 45] RV_PLIC_PRIO37
    4'b 0001, // index[ 46] RV_PLIC_PRIO38
    4'b 0001, // index[ 47] RV_PLIC_PRIO39
    4'b 0001, // index[ 48] RV_PLIC_PRIO40
    4'b 0001, // index[ 49] RV_PLIC_PRIO41
    4'b 0001, // index[ 50] RV_PLIC_PRIO42
    4'b 0001, // index[ 51] RV_PLIC_PRIO43
    4'b 0001, // index[ 52] RV_PLIC_PRIO44
    4'b 0001, // index[ 53] RV_PLIC_PRIO45
    4'b 0001, // index[ 54] RV_PLIC_PRIO46
    4'b 0001, // index[ 55] RV_PLIC_PRIO47
    4'b 0001, // index[ 56] RV_PLIC_PRIO48
    4'b 0001, // index[ 57] RV_PLIC_PRIO49
    4'b 0001, // index[ 58] RV_PLIC_PRIO50
    4'b 0001, // index[ 59] RV_PLIC_PRIO51
    4'b 0001, // index[ 60] RV_PLIC_PRIO52
    4'b 0001, // index[ 61] RV_PLIC_PRIO53
    4'b 0001, // index[ 62] RV_PLIC_PRIO54
    4'b 0001, // index[ 63] RV_PLIC_PRIO55
    4'b 0001, // index[ 64] RV_PLIC_PRIO56
    4'b 0001, // index[ 65] RV_PLIC_PRIO57
    4'b 0001, // index[ 66] RV_PLIC_PRIO58
    4'b 0001, // index[ 67] RV_PLIC_PRIO59
    4'b 0001, // index[ 68] RV_PLIC_PRIO60
    4'b 0001, // index[ 69] RV_PLIC_PRIO61
    4'b 0001, // index[ 70] RV_PLIC_PRIO62
    4'b 0001, // index[ 71] RV_PLIC_PRIO63
    4'b 0001, // index[ 72] RV_PLIC_PRIO64
    4'b 0001, // index[ 73] RV_PLIC_PRIO65
    4'b 0001, // index[ 74] RV_PLIC_PRIO66
    4'b 0001, // index[ 75] RV_PLIC_PRIO67
    4'b 0001, // index[ 76] RV_PLIC_PRIO68
    4'b 0001, // index[ 77] RV_PLIC_PRIO69
    4'b 0001, // index[ 78] RV_PLIC_PRIO70
    4'b 0001, // index[ 79] RV_PLIC_PRIO71
    4'b 0001, // index[ 80] RV_PLIC_PRIO72
    4'b 0001, // index[ 81] RV_PLIC_PRIO73
    4'b 0001, // index[ 82] RV_PLIC_PRIO74
    4'b 0001, // index[ 83] RV_PLIC_PRIO75
    4'b 0001, // index[ 84] RV_PLIC_PRIO76
    4'b 0001, // index[ 85] RV_PLIC_PRIO77
    4'b 0001, // index[ 86] RV_PLIC_PRIO78
    4'b 0001, // index[ 87] RV_PLIC_PRIO79
    4'b 0001, // index[ 88] RV_PLIC_PRIO80
    4'b 0001, // index[ 89] RV_PLIC_PRIO81
    4'b 0001, // index[ 90] RV_PLIC_PRIO82
    4'b 0001, // index[ 91] RV_PLIC_PRIO83
    4'b 0001, // index[ 92] RV_PLIC_PRIO84
    4'b 0001, // index[ 93] RV_PLIC_PRIO85
    4'b 0001, // index[ 94] RV_PLIC_PRIO86
    4'b 0001, // index[ 95] RV_PLIC_PRIO87
    4'b 0001, // index[ 96] RV_PLIC_PRIO88
    4'b 0001, // index[ 97] RV_PLIC_PRIO89
    4'b 0001, // index[ 98] RV_PLIC_PRIO90
    4'b 0001, // index[ 99] RV_PLIC_PRIO91
    4'b 0001, // index[100] RV_PLIC_PRIO92
    4'b 0001, // index[101] RV_PLIC_PRIO93
    4'b 0001, // index[102] RV_PLIC_PRIO94
    4'b 0001, // index[103] RV_PLIC_PRIO95
    4'b 0001, // index[104] RV_PLIC_PRIO96
    4'b 0001, // index[105] RV_PLIC_PRIO97
    4'b 0001, // index[106] RV_PLIC_PRIO98
    4'b 0001, // index[107] RV_PLIC_PRIO99
    4'b 0001, // index[108] RV_PLIC_PRIO100
    4'b 0001, // index[109] RV_PLIC_PRIO101
    4'b 0001, // index[110] RV_PLIC_PRIO102
    4'b 0001, // index[111] RV_PLIC_PRIO103
    4'b 0001, // index[112] RV_PLIC_PRIO104
    4'b 0001, // index[113] RV_PLIC_PRIO105
    4'b 0001, // index[114] RV_PLIC_PRIO106
    4'b 0001, // index[115] RV_PLIC_PRIO107
    4'b 0001, // index[116] RV_PLIC_PRIO108
    4'b 0001, // index[117] RV_PLIC_PRIO109
    4'b 0001, // index[118] RV_PLIC_PRIO110
    4'b 0001, // index[119] RV_PLIC_PRIO111
    4'b 0001, // index[120] RV_PLIC_PRIO112
    4'b 0001, // index[121] RV_PLIC_PRIO113
    4'b 0001, // index[122] RV_PLIC_PRIO114
    4'b 0001, // index[123] RV_PLIC_PRIO115
    4'b 0001, // index[124] RV_PLIC_PRIO116
    4'b 0001, // index[125] RV_PLIC_PRIO117
    4'b 0001, // index[126] RV_PLIC_PRIO118
    4'b 0001, // index[127] RV_PLIC_PRIO119
    4'b 0001, // index[128] RV_PLIC_PRIO120
    4'b 0001, // index[129] RV_PLIC_PRIO121
    4'b 0001, // index[130] RV_PLIC_PRIO122
    4'b 1111, // index[131] RV_PLIC_IE0_0
    4'b 1111, // index[132] RV_PLIC_IE0_1
    4'b 1111, // index[133] RV_PLIC_IE0_2
    4'b 1111, // index[134] RV_PLIC_IE0_3
    4'b 0001, // index[135] RV_PLIC_THRESHOLD0
    4'b 0001, // index[136] RV_PLIC_CC0
    4'b 0001  // index[137] RV_PLIC_MSIP0
  };
endpackage

