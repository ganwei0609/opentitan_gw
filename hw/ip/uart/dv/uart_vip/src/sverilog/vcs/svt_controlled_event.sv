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

`ifndef GUARD_SVT_CONTROLLED_EVENT_SV
`define GUARD_SVT_CONTROLLED_EVENT_SV

typedef class svt_non_abstract_report_object;

// =============================================================================
/**
 * Extended event class that allows an event to be designed to be automatically
 * triggered based on external conditions.  This class must be paired with a
 * helper class named svt_event_controller.
 */
class svt_controlled_event extends `SVT_XVM(event);

/** @cond PRIVATE */

  local svt_event_controller controller;

/** @endcond */

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new monitor instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name
   */
  extern function new(string name="", svt_event_controller controller=null);

  /** uvm_event method that is used to trigger the suite specific trigger */
  extern virtual task wait_on(bit delta=0);

  /** uvm_event method that is used to trigger the suite specific trigger */
  extern virtual task wait_off (bit delta=0);

  /** uvm_event method that is used to trigger the suite specific trigger */
  extern virtual task wait_trigger();

  /** uvm_event method that is used to trigger the suite specific trigger */
  extern virtual task wait_ptrigger();

/** @cond PRIVATE */

  /**
   * Method to implement a conditional check to ensure that the suite specific logic
   * which is used to trigger the event is only initiated once.
   */
  extern local function void activate_controller_condition();

/** @endcond */

endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
BgUdSH0UPO;W?W8.UV,;7G&4;#ZD)61PHX#0#U;ON=\NYg/XT?[53(BdgI/(4\M+
+Xb?XY#KFX)N2\b.N.5ZfTHK>;Ug1ZST4ZgRW7_D[_3WE8B0+2UaF3H-,<KbfX-P
XC?2X#\;bR=a5>.FJLH=)2^@VSQXQf3/D0:M_J4]_ZCXfAV]]/03Wc15+X]Eb8#)
#O>bQ0)AN-GHeccD;&J:6de7f[\)X:bJa@1LUf:3SAPUe+fd==4O@#bH>B.0G(DC
;H&K@-I)R.4F]V(X3,_]2]c4fdP)Lf);53=4&7HZ]R5@81DAJ#<.<KB@HH.db00Z
T6=RX/@>+]0;)57J[cFB:ZgOXH-bSeR_O1+8Kd)XPcOc<0<U9UFYBFZ&B>YH6Q6X
bR>)4_Q>bF>K)J9BcBg_3;AYaL,ST][WO-fO&,\gZ91JV@,3cSQZ&NXY0)b2HA5E
N7A.(SB4[MUEF\1,?@]?>Cb(;?C;e(]Y1]HXC:8/ENaRaYg+TdAPTVJ413;e869?
L=W8E2Ja1e=O\efDb8?LJ_O/MM<D@f9DLR>XP;J7Q&YTYdgI-F6Z)L24=e_G8_#K
dJ15,FSZ<K]G(Q[HX[0gbc0L8_IICUC]a)?7(8:J#gLMFB[@0]#^e)EAYY7ZT:)T
U2O>JVIW/F6KfNGW+Y4/?R.G;Y-E>KQ,V6C)UOB/bS1a=,7JA1WIRI]ON=9S)\Oc
R&bQ]bBAJ;XS5,IE.9NZK<P7)^d0A47IFJfSOE=g;d;DIB4GIH\H?H;URGK#7,Ac
M(OQB&,WUH3=@#bC659[DFc<0&W/RY]Q\F>Sdf7:aBUg>HEUE8SYc/V-U4DO>S=B
cES1RJ;FdU##S7G7.\ZYA6QTOVE+^_f6#4655R2b3Qf=[fa[_@+V8MRH_<JK@><E
&Ue:I-cO@K]0\ff^(S62>24g)U>If+GfU;J&e\S9S5)P/U_^ePcSUI]Z>_dW8c,-
-A&X091WW8=P#]:;Q8?3\1Ec061_=7M;7O<9^@a5CcT9H_JORdebASeWZd,LB&\=
ce87DBI^aC.P8:dV^OR.?PbKOa].QV1#RN0UZ9B,@a&;cC/_;(.=/4_LEM_GF(e/
(\(XXL^]eO-,J,I9+Ga@^X:MTIe,:6C5H+4XgO(C6C&d?d;&cg^TIX04;9[XL#DP
W1KO7_^?I;J&115>2)8NLK:XFW7([J<MW>]51+P);Z)Y^J3<Xg0MX0^_:Y)CNC)M
+?5c<IMS0e9X3\&45]dE-.+F:fZgc6=-0g=VGfHQC=c9<+Y+U<U\dTeDHHT1a\L6
]DYW?IR[/457&J4gW.e6S9Z<(4b4/VcM+_V7O+ZWVL:8gDY<P7cBBE4fU+5WN+I.
VZ/RWO652cf=]Bd[>0/GHW&J1TY>IK?>2X4gd[Ae#XO9C&=6#>[3F?3R0#BJ91(K
aO\J]_bG53e(.&_#fe>U+3Q?72O&9#Y42@DI.&VBRP)F0FNL<]#T=,gd0g^FH4U3
QJ&T&7_c/<7\O6XCg6NX?1WQ8@B@9XDaL=RI#QJL51&f6HF3Ga/-<\WP3#C49b;2
.a3<B4>f;N@bZBWYDI:K_]Q\N0(7]HSMETT_EV#DD=&=>HGDN^?8U+2c0?VdRGJ_
;<R-:dHeMAOB&(7=1RM?R+YgIEQ8c9XU\4bM_(Bf_#KB9#cT=QL-;05MBc=fd,=3
1)[J.>6/QDJ_[[9VR552EI?0.VF]2Q#;KD[a7cL]dE2T21GZY,8V\W6/0A9b0BE#
#cgGT/,+8.JT:_>5<08a\J(+,KZ0U1)JJN[DX-)A[aSFZD2U1<YDUNe5^G&PORH)
U_+W/ZEN,7,9^F).E-Kb0>f)C&S/VP+3UNg7//#CR4V<dJaAED:KH6<AOL\00<:e
@&^^[d9WDBP_G;c.O<Lb(NME;/@:FE2L-L4E:A@@ZLA/OGR]Sg[@X-Cg[dA]VBGD
]Pf^[fBS,2_PT&cWEV.a1ZY7D[YcM^LVb?N,O@:ZDU#L:N>;eZ5DU6)F[=1ddKR<
P.8b/V4\4/Z1@QF0B#R6e7a,A-7R[?S4+,XR7?)B-QEY@+&(IJNK+R6#9BGda<6K
5[_B1)73fB8<Q@64R<3.=CCR\2Ce_^A99YYP>/^^-)CI//-U?gLg5CCXaHRJdNO1
AF?]d@R,Rf&IaaGTB&3bJI:f;W:RC)_1UM]M_4SNe[>I(O_KfSE-[1G@HSaYZFaF
7)VPCbY;b=P-RQ3<5>(HAY>Af;]RE5fGdB-@=-#Y7dBLd>X26NKI9LM>;5E)\J6:
<+?P]LZdJY9_DLLYIJ_?E_Eg(#fOfXC:8Y3Gb@0092+Me1dF2JX>]\:]Ac:RT,G]
U5Y=b0&49>&D_dd)@aZVWCOfOUeDc^0d@)c_.JI2@^.Kg=S>.g,,;A+DDSDbGdQ9
J_D4GZAI8,_R?JNH:0WBLJcP+PEOLV3=0a]R#)4U_W+Z&e)T7DROb/2aMBES63J#
P=M<+8.;_Rc^S4(=#4X:O4KJ7FLUTc;G>$
`endprotected


`endif // GUARD_SVT_CONTROLLED_EVENT_SV

