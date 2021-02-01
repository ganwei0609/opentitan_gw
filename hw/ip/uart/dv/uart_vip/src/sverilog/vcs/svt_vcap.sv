//=======================================================================
// COPYRIGHT (C) 2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_VCAP_SV
`define GUARD_SVT_VCAP_SV

`ifndef SVT_EXCLUDE_VCAP

// ****************************************************************************
// Imported DPI function declarations
// ****************************************************************************

import "DPI-C" function int svt_vcap__analyze_test( input string test_profile_path );

import "DPI-C" function int svt_vcap__get_group_count();

import "DPI-C" function int svt_vcap__get_group();

import "DPI-C" function string svt_vcap__get_group_name();

import "DPI-C" function int svt_vcap__get_sequencer_count();

import "DPI-C" function int svt_vcap__get_sequencer();

import "DPI-C" function string svt_vcap__get_sequencer_inst_path();

import "DPI-C" function string svt_vcap__get_sequencer_sequencer_name();

import "DPI-C" function int svt_vcap__get_sequencer_resource_profile_count();

import "DPI-C" function int svt_vcap__get_sequencer_resource_profile();

import "DPI-C" function string svt_vcap__get_sequencer_resource_profile_path();

import "DPI-C" function int svt_vcap__get_sequencer_resource_profile_attr_count();

import "DPI-C" function int svt_vcap__get_sequencer_resource_profile_attr();

import "DPI-C" function string svt_vcap__get_sequencer_resource_profile_attr_name();

import "DPI-C" function string svt_vcap__get_sequencer_resource_profile_attr_value();

import "DPI-C" function int svt_vcap__get_traffic_profile_count();

import "DPI-C" function int svt_vcap__get_traffic_profile();

import "DPI-C" function string svt_vcap__get_traffic_profile_path();

import "DPI-C" function string svt_vcap__get_traffic_profile_profile_name();

import "DPI-C" function string svt_vcap__get_traffic_profile_component();

import "DPI-C" function string svt_vcap__get_traffic_profile_protocol();
                                  
import "DPI-C" function int svt_vcap__get_traffic_profile_attr_count();

import "DPI-C" function int svt_vcap__get_traffic_profile_attr();

import "DPI-C" function string svt_vcap__get_traffic_profile_attr_name();

import "DPI-C" function string svt_vcap__get_traffic_profile_attr_value();

import "DPI-C" function int svt_vcap__get_traffic_resource_profile_count();

import "DPI-C" function int svt_vcap__get_traffic_resource_profile();

import "DPI-C" function string svt_vcap__get_traffic_resource_profile_path();

import "DPI-C" function int svt_vcap__get_traffic_resource_profile_attr_count();

import "DPI-C" function int svt_vcap__get_traffic_resource_profile_attr();

import "DPI-C" function string svt_vcap__get_traffic_resource_profile_attr_name();

import "DPI-C" function string svt_vcap__get_traffic_resource_profile_attr_value();

import "DPI-C" function int svt_vcap__get_synchronization_spec();

import "DPI-C" function int svt_vcap__get_synchronization_spec_input_event_count();

import "DPI-C" function int svt_vcap__get_synchronization_spec_input_event();
                                                   
import "DPI-C" function string svt_vcap__get_synchronization_spec_input_event_event_name();

import "DPI-C" function string svt_vcap__get_synchronization_spec_input_event_sequencer_name();

import "DPI-C" function string svt_vcap__get_synchronization_spec_input_event_traffic_profile_name();
                                                   
import "DPI-C" function int svt_vcap__get_synchronization_spec_output_event_count();

import "DPI-C" function int svt_vcap__get_synchronization_spec_output_event();
                                                   
import "DPI-C" function string svt_vcap__get_synchronization_spec_output_event_event_name();

import "DPI-C" function string svt_vcap__get_synchronization_spec_output_event_sequencer_name();

import "DPI-C" function string svt_vcap__get_synchronization_spec_output_event_traffic_profile_name();

import "DPI-C" function string svt_vcap__get_synchronization_spec_output_event_output_event_type();

import "DPI-C" function string svt_vcap__get_synchronization_spec_output_event_frame_size();

import "DPI-C" function string svt_vcap__get_synchronization_spec_output_event_frame_time();

// -----------------------------------------------------------------------------
/** @cond PRIVATE */

// =============================================================================
/**
 * Class for interfacing with the DPI code that reads an external VC VCAP 
 * test profile and incrementally returns the data specified by the test profile.
 */
class svt_vcap;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Attempts to check out a VC VCAP license and read an XML file that 
   * defines a test profile.
   *
   * @param test_profile_path
   *   The path to the test profile XML file.  
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int analyze_test( input string test_profile_path );

  // ---------------------------------------------------------------------------
  /**
   * Returns the number of groups defined in the test profile.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_group_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next group definition and returns the 
   * name of that group.  If there are no more groups, the method returns 0.
   *
   * @param group_name
   *   The name of the group.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_group( output string group_name );

  // ---------------------------------------------------------------------------
  /**
   * Returns the number of sequencers specified for the current group.
   *
   * @return The number of sequencers.
   */
  extern static function int get_sequencer_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next sequencer definition for the current
   * group and returns the instance path specified for that sequencer.  If there
   * are no more sequencers, the method returns 0.
   *
   * @param inst_path
   *   The instance path of the sequencer.
   *
   * @param sequencer_name
   *   The name of the sequencer.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_sequencer( output string inst_path,
                                            output string sequencer_name );

  // ---------------------------------------------------------------------------
  /**
   * Returns the number of resource profiles specified for the current sequencer.
   * Note that one or more resource profiles can be associated with a sequencer
   * OR resource profiles can be associated with each of the traffic profiles 
   * for a sequencer.
   *
   * @return The number of resource profiles.
   */
  extern static function int get_sequencer_resource_profile_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next resource profile for the current
   * sequencer and returns the path specified for that resource profile.  If 
   * there are no more resource profiles (or the resource profiles are defined
   * for each traffic profile), the method returns 0.
   *
   * @param path
   *   The path to the resource profile XML file.  
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_sequencer_resource_profile( output string path );
  
  // ---------------------------------------------------------------------------
  /**
   * Returns the number of attributes specified for the current resource profile
   * (for the current sequencer).
   *
   * @return The number of attributes.
   */
  extern static function int get_sequencer_resource_profile_attr_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next attribute for the current resource
   * profile (for the current sequencer) and returns the name and value of for
   * that attribute.  If there are no more attributes, the method returns 0.
   *
   * @param name
   *   The attribute name.
   *
   * @param value
   *   The attribute value.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_sequencer_resource_profile_attr( output string name,
                                                                  output string value );

  // ---------------------------------------------------------------------------
  /**
   * Returns the number of traffic profiles specified for the current group.
   *
   * @return The number of traffic profiles.
   */
  extern static function int get_traffic_profile_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next traffic profile for the current
   * sequencer and returns general information about that traffic profile.  If 
   * there are no more traffic profiles, the method returns 0.
   *
   * @param path
   *   The path to the traffic profile XML file.  
   *
   * @param profile_name
   *   The name of the traffic profile.
   *
   * @param component
   *   The component type of the traffic profile (e.g. master or slave).
   *
   * @param protocol
   *   The protocol for the traffic profile (e.g. axi, ahb, apb or ocp).
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_traffic_profile( output string path,
                                                  output string profile_name,
                                                  output string component,
                                                  output string protocol );
                                  
  // ---------------------------------------------------------------------------
  /**
   * Returns the number of attributes specified for the current traffic profile
   * (for the current sequencer).
   *
   * @return The number of attributes.
   */
  extern static function int get_traffic_profile_attr_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next attribute for the current traffic
   * profile (for the current sequencer) and returns the name and value for
   * that attribute.  If there are no more attributes, the method returns 0.
   *
   * @param name
   *   The attribute name.
   *
   * @param value
   *   The attribute value.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_traffic_profile_attr( output string name,
                                                       output string value );

  // ---------------------------------------------------------------------------
  /**
   * Returns the number of resource profiles specified for the current traffic
   * profile.  Note that one or more resource profiles can be associated with a
   * sequencer OR resource profiles can be associated with each of the traffic 
   * profiles for a sequencer.
   *
   * @return The number of resource profiles.
   */
  extern static function int get_traffic_resource_profile_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next resource profile for the current
   * traffic profile and returns the path specified for that resource profile.
   * If there are no more resource profiles, the method returns 0.
   *
   * @param path
   *   The path to the resource profile XML file.  
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_traffic_resource_profile( output string path );
  
  // ---------------------------------------------------------------------------
  /**
   * Returns the number of attributes specified for the current resource profile
   * (for the current traffic profile).
   *
   * @return The number of attributes.
   */
  extern static function int get_traffic_resource_profile_attr_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next attribute for the current resource
   * profile (for the current traffic profile) and returns the name and value 
   * for that attribute.  If there are no more attributes, the method returns 0.
   *
   * @param name
   *   The attribute name.
   *
   * @param value
   *   The attribute value.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_traffic_resource_profile_attr( output string name, 
                                                                output string value );

  // ---------------------------------------------------------------------------
  /**
   * Moves the internal point to the synchronization specification for the 
   * current group and indicates whether or not a synchronization specification
   * is defined for that group.  If a synchronization specification is defined
   * for the current group, the function returns 1; if no synchronization 
   * specification is defined, the function returns 0.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_synchronization_spec();
  
  // ---------------------------------------------------------------------------
  /**
   * Returns the number of input events specified for the current synchronization
   * specification (for the current group).
   *
   * @return The number of input events.
   */
  extern static function int get_synchronization_spec_input_event_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next input event for the current 
   * synchronization specification (for the current group) and returns info
   * for that input event.  If there are no more input events, the method 
   * returns 0.
   *
   * @param event_name
   *   The event name.
   *
   * @param sequencer_name
   *   The name of the sequencer with which the event is associated.
   *
   * @param traffic_profile_name
   *   The name of the traffic profile with which the event is associated.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_synchronization_spec_input_event( output string event_name,
                                                                   output string sequencer_name,
                                                                   output string traffic_profile_name );
                                                   
  // ---------------------------------------------------------------------------
  /**
   * Returns the number of output events specified for the current synchronization
   * specification (for the current group).
   *
   * @return The number of output events.
   */
  extern static function int get_synchronization_spec_output_event_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next output event for the current 
   * synchronization specification (for the current group) and returns info
   * for that output event.  If there are no more output events, the method 
   * returns 0.
   *
   * @param event_name
   *   The event name.
   *
   * @param sequencer_name
   *   The name of the sequencer with which the event is associated.
   *
   * @param traffic_profile_name
   *   The name of the traffic profile with which the event is associated.
   *
   * @param output_event_type
   *   The output event type (e.g. end_of_frame).
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_synchronization_spec_output_event( output string event_name,
                                                                    output string sequencer_name,
                                                                    output string traffic_profile_name,
                                                                    output string output_event_type,
                                                                    output string frame_size,
                                                                    output string frame_time );

endclass

/** @endcond */

// -----------------------------------------------------------------------------
`protected
BMMUdTE9-#=VAF?bES+TR]2RG),BYU?Mg^#R<6FGKJ-:+gHR1.HQ+)0C<QZFb<OO
Q=SO92[E0d@dO:OPL+-=YE\ULJ2c>KWc:Y]Eg0#9BPON<e<XKf<D9aYQWR3G14]:
c1B[<I^>[RWPALUWW1e@,CQX^90CLQ>0&@FPB&@[KK7M[?C:H6LB_IS>7B?ad6)T
Rd=SbLC)))M</X>KQ+B)9eQHWfeMa9,<9]Wa:^7aS<,0U@ReEY5K;f6cH40d)S#(
M?dEd&RZ27_+RCVF+EQ(H&g^DR@R]@4ADD-YV79E/\8P)0:W6YFXKB6D#RX3^cQN
-E(A5J@:H\A,<+>^OLeXG/;.JZUN\1A<S=3d8L]8T1_=^.X+=_#8VE0#?d/^:/N7
bD<7d_18J\f?^OJ\gTLbS9]8P5\WP-A:O6.?ID<3\)24#\G-]7FAX0CW(f>EJd+1
E5-<bUWcSE32FJE@\T(:KPbO90H)Z:@bP)g4gcgDI;?e_0Af2]MdeN[#+H5V1aR-
b>NGfYR<\aRCQ)_/GEO(ZbBB.5UeI<(>JHYcQ6PU&<_O/Xg;+HR62#>BMTL3,Q[F
Pg^+FWG=P7Z&R7.&C2YJ^W(FS-7K6MGeRTJ7-//Ye[cN?c><da-3=e;eU9fEY.X-
HHg\\V03Z@GD<Z</W>-\E@b?cW3=/Q3eH3Je6/XC?.S9&Z^-GA;LaJ<\0L9a/A]X
e6XU45;N2aF14D+3e@064WNM-;<DRV/2W\Od,+.6S(BQ-_[YfGd:5TbJ-OAOO275
M4MQ#b&_+6Jb]6E[;eQAKZZ=2\7=-=479SI9YT-QL>G^1c).)a,aFR#G,VTL]<RB
@^?Sd[E,0^=dfLPE;69&-\&_;,7FR^LHdT4RZ(>ISL17>eO7L-ARCCVa)QZ<_8/I
BOD0_Bg](6a<d7(VJ<a<V^1]O7&D&f^74?Gg0)b1\H>B^\UW6fVAa;JE_^+U?e:J
HYZ6[6[P.:U(dWPcH]?FG?A&bD=,#cREINR9cHEWLWF;>3V[+6J:.8Y46g<&Z5>/
,P#9:J9,e2<TcKLTOa]#V(GY8Z[HQ^2WL2b33A;3WDdW1>OX6XAR?[Ueb1(K<_.C
@PNBUU8][O.J@de.=._]R<Q/.M0J/,,CVZ85S:_ab.YF-TP+RcXBX.fWBY8](fJV
63HW@WO58SIWa.N[J-NA70cL0LJ5JYCS;^dYCV@N4)#IbA2OT4?JN?P0VT407&M2
O@JX>e:PLE:2R[>,ITE9(52+E-MGO=2L<0R4VLN]C>R<:9O:?aVfUCUN[.U>@(?U
:UX;XAUKMF4_9IS=c\XALLK;CK6C5=Z?1E#&F<<a+3&ZE37&?2.L)>RA25(ONI08
P=_?]\30WJeUD9N8:@cc5-??YcT@ed\8cL3PCZVbDA1deN3X2QU#=+\;[<K=]eRE
e>-eU9()O<MR?2N\/,V7V>-f#JB1]S?AP9X>BUJ;(Fc4O#C9:.Z&=U_aeb)VMgG+
7TWM&MJ?4E^9E4PTC4]FU2R?Se5+5e&#]:G1F0&V,@NA91TAJJf<<2N<I&]c71J5
gDTZ]WEdKg.9GQP+PMV\U1KE50.PQW[-3-^3@)?dD28^_0E4MKS)]I6^O-QA,22N
UZ&LWG7CXF^(=JE9YNd2-7[GZ9+MVbU+HDL[5,P1NB1Xe9YcFPK8AA?-@=01BSAD
\(<2(VZFK)0<dW5W8eOFX5+Id?//1Rf]U#R@MJEE;ZK^85Z-dTgD-E#-9A8e6J>3
WcFPCM3-<3Mg[(=Y8J/;OAF:]F=eERe2<?_.I[NRV07Q]LCCBD(c@PK5eKR9[)?-
PVTcTM=_.ZV,9E8Fc4&#ET@B?<#>:aYCQMdV;2IWZ,]3@5,4LY-.=@;:]gbT0FI3
[Z]Z^F3+f1#:LW\PIXPdZPa<;D#.#4Z@E1HK)a7OCHX,V@GBYfDdN5RB.Lg?VGN7
(W\Y,]2#Y07DQ10CG3?DD26G&9US25GIPC.:8):?ca<<g_^X;(cU:]0.RFH=?V;O
8gVMS&T5aL(NLeAYFG2.4(G->@e[(H6ZN.<-@IO<T_d+<)\?e6WI+@1\#GF.06S/
dFEM;8?2?QCgR9[@T6,X/80B^a)+S-8&&@WP.ETgGg=F7g+RHRY2eQ2.B141D<^J
M@17F:c]^a(a2b#0K1L;O)PGP2Nc(?c?CGgG1g&L4>6B<CHW3R118,+LHW<Z(2HB
IKUE1CG0/+Zdca2ZINcIgGZC+#7AB.45_ZfTECOW&CZ8fMD<Wc\fESQV<2CZfeR<
__@YRI@gaD@569:=/XT.A3N&GaC\WB4b.,S(4?/,X_C,4?IFHg6\0c<>@T6O[<?1
LK_9Ye7/A:C-c_&2I]F]dA)T5+Y,:C,MT.=_-)N#\=]K4V.8cb&T-A>4W75:-)_\
Q3\W/\/FO=:W@Y:AW=a2B++UCM2[GW0I\2XJX)SN3HS=d6&L_JND&-cKC7W.U&ZE
dDM-\BeRAR9b>D/)OAZ_C^_R.5O(#\>,EIQ<U/\/E0-KX0<T^_/@/Yd(HbbHEEYI
+8?2BQPIU]^J+aN7<V?9AZITY=6?fVP(J<;<]>9@A34SC2&=D7.aW,(SgV5]LZO+
48&I+C<?VV0LISG(+]a[\[C14>:McNG1^ga1.eN+09+O622H1G>ZaSV+>^QbAbI)
0#0ZHJ[Q(<_:3/(S_D/JT&:U^H;(T_?Y(.GVcBBWEO+FRf)9R.NAd9#8E>5>O4<3
acb;_E3+a=?B&2=LZLQ@86U0=UG(PPbJ8V5LV(?XBa6;/PLfVE7L1TVf^S1ZU37]
66I0++:6=M3-<@G^^/O?2V;3<Bf(g4)cO:O4>A;QI+b\UO0U./3B@RbNHUgR)@UL
F]_DO=3;D@5ZOW(L4@a=Z_7_Hb8\SI3&[M1-PfWQE2=_N1O?_WZ7>W)dTf/VCc<O
We5F;M@5[IVV/4,^;7EZA6gc?A5eE+NUA;MP1>GaWU891b]&/K;UX9FOXe\C7JT4
:^8Q9;SQSg[R.]+SgdG94>-7\\#<c0:MT@2Y8;/T\<Q;V-FB0-QL8XUZaIZ^1f;4
;=MaH8K/ANE=7+&F_Ba9#O?9gZ8)9PF\HOBb3ZGg4C4Xd4d&/F7L0;D\\@Ne_BEb
e@>S)-7BgFQ--UKa^LGDL,IQ6&@@C[&KeSY<a[/8Q\)H?MWB[b8[)dI,N-=OO82]
5?:2BG4UL+37)7BA0(Z&4,[>X_]\Me,/Y;];:OEdM4.D-5YK\Z8T<O:1W@9WQ<&R
aWJ]BJBJQTc&g>IFGAg^6/fT&c95/H6E2.=8,T?cHb\FNP0TR;(]0J9#ea9APBLZ
^<0a5+P(H,,=ME>96O4VB8VL8eM5IYCBTcfgUGQ.Z;g+H0TMEAO-&[W,edZcS4NF
F7HdZe#^K9<#IG<CGaF60H33KJ[=B&J2L:XbSD)Q<6=>]K=W(a7V=VH^5+_#702C
?.Pf-\K>6Q(-+Q6B?GOCY\HIde_bbgc6d\IINR1YPONI_R<UQ)NPOGJG0g.FIHe.
5?Dd^?@K&8)WP;e1e1=C67f221CBCe+35LW[2AI[4V?cW(;-?[YZ-D<0Z-6H@7f[
,ccJS34E>,bO(&XT@@I\SPC#6^UZ(#QZ^I3f_WgE.087=c=KeFH6X>aO3#OfCRea
.M/VFJ4QV72I(Y][6\f[,X)_)KNQ+_EO&5@_e_I0WLg/3,fg_<f_5LWIfW<6=4B]
geaSE45O6Bc1XTb2PE7AZYZ\?c+L,AHJPH)A#Y03F-WNc.dd^MU8b/(<3SX=--MS
2(NeD?KUY1OgC6LU=-D@6+gVSFF,^fgE\\9@4R.F=E>AOV-NR<-XAeK>[)MQ>-;7
:b_D<Re:(K,]b;2FT>cZXK[9C3:.D?6JIY3^\7BbB)SNDWRA[>+0cHILMa#9TIBN
U[6+X>F/UQ_:0aARE(?KX.9fgDRJQXc\Jf@211U:MeZd5=Dc0M-?-934T0>VZb2X
O#d#<[3=O<Fd1Hd&?JbfDO/Q=AJKU^#=28<g_]O:F^-JFSO#420XD1@/SDVI0LCU
PS21^#+M:IJC7bPE-DgeD>&4Fb08Ec#SEY.;=2V7>69[_Vec_6aG,5HK&,2gU&K[
V=[/#;E+4<4cF,+f-BQbcJZB>WCF+13[RUCVXf0,e=Qb83N6GLcGI)NUMV[DD<5c
EEAG#&#,W2[7\BS]cc;BNbG?X[(N1[?_f66(XK-)00E6;9:L+J+;2Hg.4LO7CNW8
gUA]gNIY8K^aY4SPgU+Oe,gF>7gcaE9<@=T0;0#G7-YQJD(_X2<XR:_A3-G>7aR>
f:gb;D,F+;5\?9&=JJ(9V<Hd?Ya.DUaI]:g8]^U^.<M_Zca=)KZ59+0Z1ddaHAY>
P]92?87)a=8eWacZEQ+;X95I,d^[UE\X-98(Oc.?6Ud@CYfZ-=cLfAXg6:L4b)cZ
e\=]Q)/PC^&/AI0.8Gg7VPB:-a//b\\J[_3aQG142OL7[F6DTZaH;gTRBH+Fd5_3
V:.BC1^eYT65b-E4]^7Y[e5H@\Of]<B;fKVc:D3?P&3_LGW-O^^Z-]L5dWgWc=1<
WI4&/U[L&G/=@XYKbdT;\.g>c7BKCRDXJ<FF\J.UdG7[ZOMFQ8:VJW.MLUbE+2b5
I6-bH8B.KC>N11WR^KB_1@@7NKT,5R+I0G4^UJBK#;6.17(1[T(LEFeO=LG@b)@d
NJT#::H;aMg\35/[f;fc)Y_S(:ASHIRN;JFE_I[Y:G<e[UCN?H5fO[5\B:DR>L&U
9EV/OKTO4-7,8+gA)X-+GMN8AVK3ZKfJ]>d3#/eY.5IFca96\e?UUGH(+Xa;E\>.
JH3(/A\B.K6d?LKM-BeJQZ<2/ZA=M9P,RSgEB&F^GQg98>F1^^L[&-(ENKVL#7cd
419I\2.Ub-gM(OULX94JWIAEKRG8H2^/0ZI)&6MTF_X4XF?1UXO-G0-Jf?J,NH[M
4MIH9UCFf].1K&(#9@XMg/173&cfK,f+,>D4Y,4g+Ve[,d2?MT1d)BJ\B.1=75BQ
>3,B&_f>0Yb@N:c@01_<<7[(M/RXPFVDC:)/AT)&TL7[IUDZP044VgAVaI_+\Y@Z
5N#BP)WAHe;b=K_)6cUFAFaZe+5<B8-J>T(bX;5c1b^X6Za.DZNM-NS3BW[_SOV+
cN(]F[SI<S;M)+I7<^Q>Q05@2T+,Gcd#,C-YG?TK-b:DJ0F8?/;C=16+:<SRCg86
aLP<0S90@HC@NU,.P+3b>+/#:DGY3-NRTQH2(=]\+K_aS4:::a?[cU=4L@#Y1<@B
VI^MA-B^Mb5g,_U.Ug/7GGB2Y[^>d^Z,Q.?ZP><-#aJ?3^MK@(?I5U1Q0@,0.LG/
WPfK3V@W1;\-TQ,7N1cS[K<cLJf.N<HP);W?DQN>)Y9K0R#]IV>a/_<L+>OTcCHH
-]^UY:=R?)FA\,C8?OJ_MW?9XTWLXOg?^=^C]7&0^[<P8La413(5(]WFV1bYdGGD
&5KB&g3^NI4ZFM:?&>bUNIfW-+Z:]29/4dgYBNE7f+(8P&Z<&ZL[IAafFZ4OEcH,
<?/-A6XJPbbD&5@4;(65=3;E/b2<A<^eD;HAa.KX@2AcVgc(>+5AFD0A\3@VHgH9
/-K_@T4V6B:;EW(e]<SA?YX4[C5Wf-1dac@>5eB2_O7>aM[ZB3[aE7JNc0H5e4C=
CD#:<f^9<aYXL(da9KI-Z/@GWQHQ\+1R<(_@/XddX+dD3#?(Oe,NGXPC@JU#<?-9
RM#I67<Bf4M\?L:g19PQ@[_<I:T4BaZNF-AJ4,a\0@d#=:5<A&E=66G^1+]F7SRJ
b0U8G:ZOL:)<C8I.CPA1E(@\f7VM5U^D.XXL4OHVH@-(CN46A(+aN>0@HT\C6Q=#
<N_3gS<F&>EB4HK[_TK<(bAR6N0H)WLbd(,XYHP)TXE9-EfRQa1a56AY+X_X_/:W
F,c[]V6/OMZE-5;f0HV?ZI@7UP,8>5H-Sg8;+/\7\G<eT&)9WIMU\JE\Q[B.BXF3
;H.XYBECNBX_EddbH(2QS+8B8af>aFcD,eJ4&)<8T0H/6;&@+NFKDB@#cdC:,Hc.
.FLNE<8@X)-L\ag^E^8S1)egI79(;C8EFaU]RO^+^<e0g7M3NP7.Qb,@FUJ?=[EY
A\e#4N^Z@-:O/RCF]_[b(=M==Te:f3A=7b/[5X5ZD5.Og:-K9^6JHg4A7IOd-Pa[
X3T4LR-c+KF;(S8_4Q\X&M./37LJP/>U9^d,0MSZ3HdZ2EY8YF(F#F=6#SI)bWX0
_31_4-dEU1/&;H5&90JY\F_1NGAaN0_@/A)C-2>J7I(AR;V9PI?;3VX+F[/HaO1=
)W<XA341((ZS^6Q>3U==QF6TJ:\@GV=_9a<4C+#UW.PE,/BRfX^:;_3/Q;<YQSB#
_\_-RG?bO3)-MPS1-W[C:5_M?MP)_H>g]-OPBEDOgVD&0CX2)VNe(/<d/Q)5]NN-
Z8INZ;H^^8#cQPe?ZJ)#:YVd]a.E5g,U;DJIT>>KK\UAa2),[42Q4W+46(cKf6b,
0WeW/5c\S3ZgUQOC+L4F&A7>MG-,H6c)])BH].&C3UF1MICQDa[F(NdG3fYP]=8X
fXT/bA;0A0Z?@>&0bBb(D@(;fEASeT3&N_E?[DbQ?_1/6?>_V50VAKG#NdV8J5dP
Be10=68]2\^LN@3T<@43YNcc1e573^(=THRN&Ne(<9H6XcQbV/NI?1D<:D7-H6EI
Ub\Cg(\aDACa^O&1F2,FKB9[XQb\KACMUbFE9E#U]5^2cA^)/bbURSafgRDZ5-gQ
?OWA,249ZFDBRP=bA3Y,gAYBCXQN_SUdBg0XUE9GEF<6A8#@2L3Ua@B/QAZ]PE1#
1-a;EfY2D=4@O\caH;]_fTO9@PN[5\9bD,ZB3bC067.&Q/b[c2JTb-F,Q3L]H7TE
?7DN+d&eG:1;JR/TbTP/DCEOK48I=QK1=8<5/)UA79:bP(C^5_cKfcUb]LT0W<50
B9Pa74?7b0=bbO;PHd#ec;K8<_R]S:(3V>_IgBPAc^g;A-4C(VMd[RX:#OeC:@\C
6-GVe9#W9XAaXFL?Y3-9:HJ1TIYUg0ADY.IKH0[7e3<,#A,Q7X>-PaMR>dQ1^EBd
B9)@UXaGe45WS[ZMH=c[.U5V#db5\;.R\QK1CFM:(U]),@U(\D64b+3F.2RK5RN/
3QEBY4d3dY?^Sc0gGb(AK56DYA.RWD(JZ&<;+[P?PV(USIIJL(=:82HVcV\)FBEc
aV:)8D[XFed]BNOa0EY2/8dSf;681R00O/CTHLTZf;K9Q+>7CE3&_X4=bYAdbSY?
Y&=GaT+3SCN1].3L[cQU<5^P:QLEB/S1OBgZI#A&Y\JPf@MaeJV?0K@[K.A#;E2P
#2KdBa.0P,;[f^:E#KD#\.Pd6cZf9IZ8Hb=G5g&A[=>gFP=(S_bTcd>OUQIOCJ^E
]3@O?fVICLKZY]7B7Ce6gE#(PD-9FVJJ<GbeJ^B8?)1\3aNYKBTV\2DB=2+Q\?6b
G:6T7Ya]F#cVKfIFMQQE&MJ/LHgbc@5?P]-1></4.g?4,d8EAC-9fX[QT2I9f]Ac
1M,Z(4&O-P=W2S.^]ELB7+D1<Ia[3aCS]^g5MWb\-CG7-e0EAOg:fVO42G]A?g52
bZNVP7,--+6e]VReF&K.Ja=55-##+(A-fGX,SVcTcE<\CdC[?a?X54N(T3F+JPgC
6LIWAFSfZ.-4MU1F,OQA,GB;caYc+WZ1D5FPRXGfF;dX,\.?(EW-+((@&cgCITg\
@9cVN81gOJ\D2#N9N;M#^X2GC:=,.-315K<#&>VWLVCg\J8]Q;Q1Ec8PCaQD?@)e
6/ZZ&27gM3-,&GOR6\(B)C@(IIT<GTJ3A(WB<Lgg)WE2fdd5,B.4E?a6e6c/9Y3E
5@c2RCQGQ<b1TeIY[bZ>J4+b,aR4N<CBbNAaYT_=1/a(<M=4.7/[Ra@@9K_NRf50
de(O]DeS4OGd;=Z,O2^e2g>=Z=4:^S6IS8C+RTG5&I_X?cfK/GAKGNDFe4G-EagS
Gf^U/+1^G:&5[JTORH4-MgN1C0DgEJ.QLR2K03J6caDL2_SG+9eI/G9)DX17&H;,
E0@21-N.65,G40::]1?FJ)8&Y0S3^,CG+1R0.DM8BD]8F6L\D-Bb^a437\GLNG&]
),VTcK3?>,SGKf5[(I7aO6SGZC+6J7#X0C3:Hg7EP:SgDHF.FHc)L]GKY(.W>^BL
E?+BQY;X01^9Y1]Ub6P&#A8]Ga4V5=5+XdGFeUaaOB0ESP60@<Lf[aGQFgdV7#)Q
?ag1;_d,A(;WUEd_U>H_eeAcKS?-+C9X4Rf,U?a3MS+5HV]48D#^V@H]AbBPZ,,O
+@Z5AMgENW(<#@\^T>;]YDGORQEP3AVfCVNSI&CJO+^,]^#TaQ,Q<F.QA4:?VN\L
PJI;GWZON2a_GZLXaRA.]^4@KB?^CED;1M;KMS.A#C&4g[8Q340+f>JXB+/=@MZQ
gV0:K#d&^^IKcB](Z2_FQWY+=PP1Va\X#a[7>=cPNFSf[(MAG];1]@76X8@b7>[O
.a=,c?A_?5bd<LP@)>JgJ9/&D=Y/4Ve9a+#\<U9+6J]:8AHD-7;aUMM#?A0g.<9W
S_a.(D2@O,<K5L-^N)>M[:UWIJ]#\3+^Q;9PZNWHg1N?OLSLa))S/J30]P11]\=^
d7eQSQ)aYMZB50Q7(;7a@/\,:g1ggPQ[H\3;A()7O\68^QN44Y28P^2](g-f<-59
c&&SYM3aY0M<N^9X9HD<>4LA(ZWX9-=3:W(;2H.GYG^S:GG3+X@a(5><Te=UFbRL
PQ.f\LfYT.]92H)?;G27.KCQ4I9:L+WdLYZA:aL[KPXS]LH2J,&:\cWV+;57X<3,
?\)fM2_DPVW<),:>.52bB72RNA0CdQT<XQK9cLe^K,2?U2#0E/<Za]T2RVPe_ERP
:&bF,;3J,DNB,D#baPVL0FK6fD:&T\S:H_W60:)<S4g,S7a7^ACgeW+NEa.5<QNV
Z>f^G\^II&#L8YJ^SC3b=c(9PZ:O4)\-5#eBd/9X:&X<,WU)d.1POf2LFSW+@4H#
O+2aNW5@8daO4N/-KLZF3.H1.,a6X83QNMPSSU9QY&&@^HTY1ce;F&2--[-d]F?6
&<RMJ3;Zf13PUCWD7LNGY1TEBP<MFEI1U2SPfcD@C^Y/ag6\1=4HC]ST1Bg9Bf80
OBS8:=B];KUH75>-T,/4B0:]JXM\=<R<e<CF=(<T(S/>(<5Adb:1ZN)W#:-7bG(Z
PRQ@_PQ?#VC:<e4aFL^)^?R_c;J#DUP09O:L^6WP2G7<LVQX3J?&&ZU,5MB5KWM#
5^_/@+HbdeT]eA;L/BA)J@(V.UIdMc(USFW)=Ge,HN5G-VP@C^;6f7D#e)O1;bB<
W4NV\-76FeW2N=J3_5@gT31DSfB\)Y7(Q3[2XO4^@MR?I2.E:AOK134L;;C9+fP:
0f3]46?^#X2]+^=79@T5+YbJI1^2Vd4_U/0P.6b9P;b:Q;>A#b01@-?GP.dSP=\=
-4WfHV5ETSZQYVJT<#FWORaV_->Ba+ZQ]ZReK@EIH)D\<W3/Z5M4PTW7IV;a>JCC
^:?dV=SI6:=PMfIWdX>AbL,A2.XdaE355F4ZUdHXYV9+.G9<2/J8+[H>g8L&L5:G
1/gA4^]dS.b.:=0gX++K(a,bZ()PX;6R@8e,K?X.d/]Y=/Dc3:g)^5)82<C:J_P4
D;@\3XS:RJWW1;KXC+LUa2=/)=<e;D@.gHP8MG3Z5=_E/ZISeW?=UR8W31>RDTJZ
CZK:dKAO2McZ@N<YXIS:b-K)39-((gfc[;e<MUEb_]Jc7\F#=T/W3SK:HWU^C#)9
T_N.E.1-O?T=&K.:Wg<6Yd>@QC-(2U#2dgBYbX]1ILHgH5c6cId;WSU\KK??SENT
C)4SK@P-(<3Hd0BV5ZZLBV\:UJaRH0c&^DN:0^)(3\O]J[;[ccDS]TGD+SFL?TLJ
Gg(@1ATg.agN#M>QR(TbEBD_Ef?N:5F]LGVTG9KKDO]O^\04F&MWEME^UN4:c.9V
R\UWGA2419(a]I426NU;?ebYH@3PJDK=L5E9YJZ;MQ-bM4.=J?e9YK&.MM01H+\+
(M6ffX7caTO]M-VeE=fST_4[FT[\ZO@JaIUe&[J(6(AZB:4:)&W25JO?^Y9HF\YU
&5@GX/@12Q<UcHc;(cU#,V#6.(DB)c;XB458eJX&IN1@#PVc[91J+[^3ZZCcA)ZI
7<SW7:d\NbXP+c1)&_/>EUSZeDO=W(R;g3N4&MAAP&_)HXAY(G6;Af?26.UU?;47
,KFaNCM-&(fSY+[\F1PD@MKCKUgeOIgA&SWY-=JAQ:_M[-KgU9#@2I^@8:UC56I7
e40TXR-gJ(79c_4Tdag&E#b6.b@F906KPXC>F65#_KZA-TWQ(b,Z-T:8c)HQJOPG
B-HX)I\8RY4I25&8K<Ig78=RV.dUWYX,&/LNEO3KX&fY0SL5(TFY5#g&-T1^Va0V
g[/E4bB&+&=WU)TU?1T,;-;eTVR2#2XAM;B,eBZ9FfHdK@>UG^,>VL1Bd@MWS8FD
NEd(D:LNI-+.1c3EcZ_aS9PB2:#^=g^?=2]NS6LNMb(+Hc-<[D<Rd&fP:eL3V5QN
6S6U,Q1)3I&N=2,M:U@@R^F7#F3P+0^Rb43+I<Pc1d@&MVFT+[N>D4g#W2gH-,+b
W)VI:/E8)B1<ZQJ=M_LL21b;<E:1[SOK?$
`endprotected

// -----------------------------------------------------------------------------

`endif // SVT_EXCLUDE_VCAP

`endif // GUARD_SVT_VCAP_SV
