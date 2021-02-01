//=======================================================================
// COPYRIGHT (C) 2010-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_TRIGGERED_TIMER_SV
`define GUARD_SVT_TRIGGERED_TIMER_SV

// =============================================================================
/**
 * This class implements a timer which can be shared between processes, and
 * which does not need to be started or stopped from within permanent processes.
 * This timer is extended from svt_timer and otherwise implements the same
 * basic feature set as the svt_timer.
 */
class svt_triggered_timer extends svt_timer;

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  /**
   * Specifies fuse duration, as provided by most recent start_timer call.
   */
  local real trigger_positive_fuse_value = -1;

  /**
   * Indicates whether a fuse_length of zero should be interpreted as an immediate (0)
   * or infinite (1) timeout request, as provided by most recent start_timer call.
   */
  local bit trigger_zero_is_infinite = 1;

  /**
   * String that describes the reason for the start as provided by the most recent
   * start_timer call. Used to indicate the start reason in the start messages.
   */
  local string trigger_reason = "";

  /**
   * When set to 1, allow a restart if the timer is already active. Provided by
   * the most recent start_timer call.
   */
  local bit trigger_allow_restart = 0;

  /**
   * Notification event used to indicate that a start has been requested.
   */
  local event start_requested;

  /**
   * Notification event used to kill this instance.
   */
  local event kill_requested;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Creates a new instance of this class.
   *
   * @param inst The name of the timer instance, for its logger.
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param log An vmm_log object reference used to replace the default internal
   * logger.
   */
  extern function new(string suite_name, string inst, svt_err_check check = null, vmm_log log = null);
`else
  /**
   * Creates a new instance of this class.
   *
   * @param inst The name of the timer instance, for its logger.
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param reporter An component through which messages are routed
   */
  extern function new(string suite_name, string inst, svt_err_check check = null, `SVT_XVM(report_object) reporter = null);
`endif
  //----------------------------------------------------------------------------
  /**
   * Start the timer, setting up a timeout based on positive_fuse_value. If timer is
   * already active and allow_restart is 1 then the positive_fuse_value and
   * zero_is_infinite fields are used to update the state of the timer and then a
   * restart is initiated. If timer is already active and allow_restart is 0 then a
   * warning is generated and the timer is not restarted.
   * @param positive_fuse_value The timeout time, interpreted by the do_delay()
   * method.
   * @param reason String that describes the reason for the start, and which is used to
   * indicate the start reason in the start messages.
   * @param zero_is_infinite Indicates whether a positive_fuse_value of zero should
   * be interpreted as an immediate (0) or infinite (1) timeout request.
   * @param allow_restart When set to 1, allow a restart if the timer is already active.
   */
  extern virtual function void start_timer(real positive_fuse_value, string reason = "", bit zero_is_infinite = 1, bit allow_restart = 0);
  //----------------------------------------------------------------------------
  /**
   * Function to kill the timer. Insures that all of the internal processes are stopped.
   */
  extern virtual function void kill_timer();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
6]P.2)9bAX=[JaH/CDY)=\8YNQe=7X+D0;B-Og]ZP/D:)+8Z?CdE1(H3G+dc7-X3
Of+LI^BYG\54U?7A/?1?\XB7TU:Z3I0_8<c2X;6M<f,K_+#]/PEdB<#=],@326G.
Y>B^-FV#K^gTS,g;)91A^[H25fGg6)>Z/g]XG\=_0]-GTgCXV+Y4cDQd.La9[VF2
1DI&TF<WEOYGAO+.A8d(\;R-/^X7WFN)HQJe533O\-J>DH9D10T3?<VIZMRU>Kd,
eFeADcK<)3_0_W7FL9K9&\/0/gN=LA^>A\UHAYW8_=FVTE&\NKEMGMJ529AD3.fL
/1@gIVb7:@g&BE[/P4)c4,L<L51f8Z5dK<L]S.H43YK28JP7=cO@823e,Z?/(]-B
VZ6a(YCKZF[fWX&IYVKP.]4P@7E1=F;Me2WIf]Hc:f9+?4F]D8W7eQ.6L[^Z[]\(
B3DbVcSaDB_OO47JKCA4gf]3bR(B_R.D:Q)R70+;\.-.LfE4V<RfDd9;&E(=M,ME
MRR5bbZbcB?bV/2,:TX,;FdbPSd;Xac@D.(_=cLHGMU;D75])C4MK768#<HE#O2_
@eL_4RT2>>Ff_/fJQR5D#M]N[a.Ge5dbd++?=[\G&(LG1FX_]#\Eg_aUgIMNP,-J
?=_+&R727AL-,([UZT@SYg6gNbDd_HP90^.3Z</V(YJ-O0F;HL]aIacZ]0aaef9D
[GQ>1[Q@<T:Q?B&R(fd^M84503P<XM#(PUROQYgf9W@0=0W>)Y-3g.8_MXWIT9D5
K[O[gG3KeD.Qb-VXgOZMU:V]6g>&GAZR;dT+NT4=?/HVEF/30JO8[LJGENIJ(=\>
3I<,Q\e0WV_9K&5_6=\,)_T]V\0e.68&NK8(DV4G>cM=F?g9XeBdQ11F[e,X?)53
I^^_9HKPL7CfHBW]_Nc8J@_d@>/>[A)V<dNI(I&+S/0<X>]IDBGIb/#R^R1;/><G
6P>MdW8(eK?,:P4+/.HLKeg\1#V4]dg.(&W3DHH0#:.76cMWFPNB+M1=Ra?3LK?D
/3)a](beFKHcCRaC3H]Tb#FeVZTg)8a@^(JRLIRPb0(N1@MN\UII\8[-c=[^-8@&
2[FE3H<BG(0gaaCPWAcK]U(HV,89F\a>XU7d5BH,5V3U>GG3@@d&eY]d8W(+O0Qa
7841&&/@=a6T;BUTM3a+\6MeM8g9H]]/#3I]&7X,839MHD>T-T659.NSN+D3=W@<
L)^GE2XMg7X1g=DP&K4cRLZ.-f^fD>@^W:U&KB(G.L1Gc<>D2Hf9b)&E<+<3.AbS
,Vf6BB2Jf-f1gL=#R<?P@5#_g(A0Ve=Z6SeRT+A/)a,6@08Ua6Te4/#^E;XETM_I
U4AdT8#9U/@T@>YYT](DeR5TIG#P-[2=47DTMCDc]B6E0:R-6CBP&F<:IZ[HG0QF
>&+K[]/JBSQ38@<UG:\U/KA+,AbWI-=T[VHKU8^@bXPZFLITa_a[E=aH)a];FQO-
<f^CeBA-]bYb_OO:#8YNKe/O\Q@WNZCO:\C2Z#H;da2T,Le35_?f=Ve][ZD_+-B,
P@dX1#RS]c>)^#g^75)/36LT9>6UaOK/ILI52=<#SL):;bL7#PL27J=JT,4+.YDF
OWg>ZKd_cZXCfPcSEBedA[MP3,(?XHeK8&C#AUe4U#fG<6N,7#)WXFa@D@B[;<+H
bSg?O=.[@eDf4JTC5OQH9Dg#9LWf)J37U,cO1agGKf?3[RdRMC^aHd@I/);;MYUO
@#7gcQIJ9N)1^EUMBEa&T0g(2^J+VB=Ae-d?#MCRc1FDH>^=c>4Q,,XL&K?RBAKZ
0^:JX?[_WZ27fCVWO=DSdWQd1F^2L#J(Ab<\<]DRScZWS2>I&/5W+-^EdfF@\DPS
B0G(2+Y+K7R+fbIRAG/@/<.#M5aWY2@W/LI\W.M@aff+O?gT+0<Z@fIAFY-?7KKH
R[Se^FH\+5^1BK41]+&(+Gee&8+@d/R&Z_.;&a:4/[7FgSGS@CK-<]<>-WU7RXG5
S2Z(fTK9]TC_QNZ:?eeF?D&9^.DXVgNLE4XCb(P>+EKFZR?_aA.@1a,WHZ16U)BR
JM6Q0P8VWe6)+[BYgZ6,]2?IAIF<I(Ddbaea10eROXHD,eB6EDc]K)B)@:1S_NXX
FL>0F1&\IKV#6d&G>[^S-L2fSD,+XMHE^-G?gbSUQ>Q&a(M>HQ723M\cNK7R.b0T
f#\7P6SC?+RR7?HEQf^4aKN./d=P?YM].S)(\;adP(O9<9=UI>8PgRW1HG;[/Y(U
]OM:=Pb4&^X:YN@L@H7;0]R,QPeT,>FMQ>dOH]GZ<ZI9E$
`endprotected


`endif // GUARD_SVT_TRIGGERED_TIMER_SV

















