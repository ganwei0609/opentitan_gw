//=======================================================================
// COPYRIGHT (C) 2012-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_RANDOMIZE_ASSISTANT_SV
`define GUARD_SVT_RANDOMIZE_ASSISTANT_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(O-2018.09,svt_defines)

// =============================================================================
/**
 * This class provides randomization capabilities for properties that the
 * SystemVerilog language does not currently support.
 * 
 * This class currently supports the following properties:
 * 
 * - real values distributed within a provided range.  The value returned
 *   from the call to get_rand_range_real() is controlled by the 
 * .
 */
class svt_randomize_assistant;

  /** Singleton instance */
  local static svt_randomize_assistant singleton;

`ifdef SVT_VMM_TECHNOLOGY
  /** VMM log instance */
  static vmm_log log = new("svt_randomize_assistant", "VMM Log Object");
`else
  /** UVM Reporter instance */
  static `SVT_XVM(report_object) reporter = `SVT_XVM(root)::get();
`endif

//svt_vcs_lic_vip_protect
`protected
>#O&WE)#(\-A+?DC@?50#O[1&)e;B-7.\#e+TL:TTT[/F]W:XBXe6(XTTc.bA+VT
d6OC7,+4@C6,FE&dKc0Q6[Y5[gc#ZOX9a+^UNBH29YKSYLN=FX][@7JHNS,_]Z8a
(W]1eIYO,LG6,aG<VP?\[&1GRJ99;J1>0E1FKM@OT=&8Z-?]V_EY_g_cR-:9#UdK
G/5R5-R^^1U3)A,L6[;2:4A-,)^J:W)#\8)6ePC/5Q\L+04GO;/Sf]ULYTFE87=R
NCN\MY_ZWHG3F,IJ5@-S\G&KIZP.ae+21@,C6.U31+J3[H<.D<8I]=bVZT\/02:Q
:G^R(3-.3)H)W]c#ZF\aK_0df?(04.,U((M.f]L7_:Gd>=OGd:M3L>.))Hb/D83W
^=?K58ZSEdK2-PI9?cY;^6O&beAQR7..>4]eg#<@d1K/JIg/(RgNYW&d-E,P)bSR
&<FJ]Y[M9gc\e<Zf)E_N9N^aA9X7&CF]+M@NJ77[3<_B/Q:@FMEMZD+JT-15gH;=
XaJ.MULI^^QIV(97fW98a\@;<Y&ICe]05=&4^4?>LG_1+\X:217O^F=&8YT3Z0KS
+_OV5,7W^/Q>c8ff15^+Z]N;YRHCFNCV(IE8Z,\1NTFLffc5BTScg3NOH8aOY44L
727gIQB;#34W?R#7\#(TgCTNH2T2:/a^(@F/RMIZU8K.?0Na<)J(D0a&>N<PMLNd
^g10<]5V[2#?a^&B]8T:EdQ?M5AA()5N<4D+;,D&S;A0G\R5f85a8B;9D+KUXTfJ
3&Q[>PS^+3NU2?^,6\;(V2N>_6A<C02)DC2JEcbEdA_]?5T67<Z-\\DQ=1fa=9a-
,aQ\<-<#[?-E1=a:G?Z5>Jac5+1dJ+JX4#aJJ+ND/0cH#C;bXIN4^@2+#6>]6.)@
>S@JIDY+23=Y^@HGYb-N2EM0Q#TaF;R<:J383Og8YdOI86SQJ4R7)PJYPVMdG69eU$
`endprotected


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** Constructor */
  extern /** local **/ function new();

  /** Singleton accessor method */
  extern static function svt_randomize_assistant get();

  //----------------------------------------------------------------------------
  /**
   * Sets the distribution control for this class.  These values are used by the
   * get_rand_range_real() method.
   * 
   * @param max Percent chance that the returned value will result in the maximum value
   * 
   * @param min Percent chance that the returned value will result in the minimum value
   * 
   * @param mid Percent chance that the returned value will result in a value that is
   * in the approximate midpoint between the min and max value.
   */
  extern function void set_range_weight(int unsigned max = 33, int unsigned min = 33, int unsigned mid = 25);

  //----------------------------------------------------------------------------
  /**
   * Returns a 'real' value that falls between the provided values.  The weightings
   * applied to the returned value can be set using set_range_weight().
   * 
   * @param min_value Lower bound for the range
   * 
   * @param max_value Upper bound for the range
   */
  extern function real get_rand_range_real(real min_value, real max_value);

endclass: svt_randomize_assistant

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
0HY0X<KN(QX]#O7/+;cS&6OCEIV]eZ6NHF2T=@4B[,cF]DLGfD\C)(g]DF8X?2F=
@.H[@78_V=\+=G.GO^)[E[#0^0)[)dBM/aC+^Xc6g78ATXG@,<bN5U2.<gSZg&fY
7>GeDDLecE[YH@XTa85P3[@@cU0_=Qfd9THI^3IXAKX[8EXaZ8.-XKZc:C8Y27b\
D(#E\3_)W9<AA><&Y&5+)>LLaOTZ0).BFW6,+KOWV/^AX^UE0Y;cUe7FSVK<NJNC
1Z+HH)>Z/@]_?NAcLJGXgGS/d+TCgO(,FgdMMEMAWN/F[HYAF.1JTGdC,g?6]\dK
]:^6^\>QfNB]_7/UVDW6Z5IY9Ied..:\N_BC9N+>X1A/&:N,Zg6\P\c#R8Y1H??G
6R,HWV[]ODV,^A)??gOJQUc]F;DMD6F0:6JQ.@9^PE2Z,2^M4_-M10UBMYP#>M/)
U6:Y7^Ac5K,I3f=4UAC79XaTS9352QB0_U4IYSQHbLM8f@#E+9R>TED,3-L^NAZ9
;[Q(2Vc3b(FTGX0T[Y^<2R&J(DbE.)PB5A2C4@TN]<fgW8M9=f;U?+73-\[SaBPM
).L?F=W0WOV:^.G2I;I+#Y)^P9NMcH<H8,B<Z/Fb.D(B7LTDa)=Ya2<SFfDa#,S3
78^T+Y31P\GF]EX8LX@1?RQTW.2b03,S8K\O#H##D8\J5^.EP))Y4OU1]/HGX0NV
+VT8/6Y#6>^X9W]56Z@Gc_4E-U(0.a44Na)f<OFBDRX_..54APc8?:NDc7B5V0+4
YGAc6</2+COMKVLPEQP+\CU[\4Q.>[E;e@)G]&OA=5?S@+&25NYPBQVcIU9#K8GZ
=82U&9W#?&>YR9<<db,Q^9W&#7?R(7:Dg+K&\?7(.?+L)B)-[UJbUaW,W;4MMM/[
E+Gd@/Wae.d]IG1\V?[)HQ9Zg^QE2U>aGXS-XND-223/<-V(ARC36CG;NOE#?(U+
Y<,[b.3Ff)PF]9H)Z6d&9QJ&F+/46VNfd_\N?I;YV#Za6_XNEA?H_F^V?1O85U\#
,]Qd#M,d5K(Ka8=2fY/W0YJ0NQ+T2gV?TNIcJ^P_:BDb1WL8VNF;U<8dPC(=9BUZ
SEA@d=TKc+a0&_c(&:??./^EP=?B+YZW\a#Rce;e+bZ9^N-E2a-G+bdS>D<Idg&B
=[dacbZ28O7JG[WFA#a7C<ZgUDW]JNfO&,Y0URE-,Vf6ZV8I8[eQMB(@Q&65.[7O
4;L:<;Db1Bg<B4]RO<5^FJ)f5_X74)/MJ9E\28P2=C3C[.3S.@SVG7FK=)NGP<YB
LCUTEBEA3PL+_]TMRRe,@@2=PZZO_^&<7bI3Z&EE7#ACRO_S@MIU;L\T]O+V<>_?
.3FP\Q7GF8Rf)VXN^_S,4WZZc;YaHONED_7c5_9bG.=/QU(cc[/=_Y/6-D5SR<^2
a7]0>.<8@HUV+1<^LILSSbd2^(V2OD/EJOP;G?8FgEW8?5MNg10@;(<XDBQ:FE2d
5C/+)BNEI3H0HJ(WYKV5S78]/aO,.]17M@,+C+KEQV@3_>2<Q#-0_7(?(D&+T?4_
D-OUK.33VP9SLX;LUAdI2X^ZOVcEL.,ZN0?6SG]g_;ba6.-=L^Y;N\K,6d<bFgYB
F^XELe].\YYP.G>,@ER:#JOQ=H1c>\5>90WaF:\G][N(Q\SdO@a71SR2V3NYQ+2Y
QO9Kg6HA7]S(<8&7CTQ5(E/&2O<07_M:\4P(gg-SaUGMH7[A6XNE(dVV0DTf<;_?
ddZe21/(1#(#;_:>&[INJ/:2QbMAAGQ=JdRB<0H)8RKdEA/,1N.^,>LOgX9>R\LZ
HWV@\#XDXgb48HAN56/EJ?C9SL6P1##I^<TKAg.P5=:TNdK+_Fa##W5&3\D5,?:B
W\FX(AA3W4eW9TVW]dd]d0d;g;CYLCCYY:eEg>M9\70=Qd=a(bX0?L&Y4719cPJ6
]XQ\G./&b2(Q&4YP_Z.K<g^BX_dZ?6bOC#R0(4e^@]&=D$
`endprotected


`endif // GUARD_SVT_RANDOMIZE_ASSISTANT_SV
