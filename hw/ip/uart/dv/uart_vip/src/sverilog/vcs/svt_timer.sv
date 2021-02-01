//=======================================================================
// COPYRIGHT (C) 2007-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_TIMER_SV
`define GUARD_SVT_TIMER_SV

`ifndef SVT_VMM_TECHNOLOGY
typedef class svt_non_abstract_report_object;
`endif

/**
 * Macro used to check the is_on state for a notification event in the current methodology.
 */
`define SVT_TIMER_EVENT_IS_ON(timername,eventname) \
`ifdef SVT_VMM_TECHNOLOGY \
  (timername.notify.is_on(timername.eventname)) \
`else \
  (timername.eventname.is_on()) \
`endif

/** Macro used to wait for a notification event in the current methodology */
`define SVT_TIMER_WAIT_FOR(timername,evname) \
`ifdef SVT_VMM_TECHNOLOGY \
  timername.notify.wait_for(timername.evname); \
`else \
  timername.evname.wait_trigger(); \
`endif

/** Macro used to wait for an 'on' notification event in the current methodology */
`define SVT_TIMER_WAIT_FOR_ON(timername,evname) \
`ifdef SVT_VMM_TECHNOLOGY \
  timername.notify.wait_for(timername.evname); \
`else \
  timername.evname.wait_on(); \
`endif

/** Macro used to wait for an 'off' a notification event in the current methodology */
`define SVT_TIMER_WAIT_FOR_OFF(timername,evname) \
`ifdef SVT_VMM_TECHNOLOGY \
  timername.notify.wait_for_off(timername.evname); \
`else \
  timername.evname.wait_off(); \
`endif

// =============================================================================
/**
 * This class provides basic timer capabilities. The client uses this
 * timer to watch for a timeout, after which a notification is generated.
 * If the specified activities occur before the timeout expiry,
 * the client can avoid the timeout by stopping the timer.
 *
 * The timer also accepts an optional svt_err_check object at construction. If
 * provided, this check instance is used to register a timeout check and to
 * flag successes and failures relative to the timeout check. 
 *
 * The timer is started by calling start_timer with timeout value. The timer is
 * started immediately, and allowed to run until the timer expires or the timer
 * is stopped.
 *
 * Once the timer has been stopped or has expired, the timer stops execution.
 * In the total absence of activity, the timer will not indicate a timeout condition.
 * The timer must be restarted by a new call to start_timer(), or by a call to
 * restart_timer().
 */
class svt_timer;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Pre-defined notification event used to indicate whether the timer is
   * active. The event is an ON_OFF event.
   */
  int STARTED;
  /**
   * Pre-defined notification event used to indicate that the timer has
   * been stopped. The event is an ON_OFF event and is reset whenever
   * the timer is restarted.
   */
  int STOPPED;
  /**
   * Pre-defined notification event used to indicate that the timer has
   * expired. The event is an ON_OFF event and is reset whenever the
   * timer is restarted.
   */
  int EXPIRED;
  /**
   * Pre-defined notification event used to indicating a timeout event.
   * The event is a ONE_SHOT event. A message is also issued, with the
   * severity of the message controlled by the timeout_sev data field.
   */
  int TIMEOUT;

  /** Public data member which can be modified to change the severity of the timeout message */
  vmm_log::severities_e timeout_sev = vmm_log::WARNING_SEV;

  /** Log instance may be passed in via constructor. */
  vmm_log log;

  /** Notify used by the timer. */
  vmm_notify notify;
`else
  /**
   * Event used to indicate whether the timer is active. The event is an
   * ON_OFF event.
   */
  `SVT_XVM(event) STARTED;
  /**
   * Event used to indicate that the timer has been stopped. The event is an
   * ON_OFF event and is reset whenever the timer is restarted.
   */
  `SVT_XVM(event) STOPPED;
  /**
   * Event used to indicate that the timer has expired. The event is an ON_OFF
   * event and is reset whenever the timer is restarted.
   */
  `SVT_XVM(event) EXPIRED;
  /**
   * Event used to indicating a timeout event.  The event is a ONE_SHOT event.
   * A message is also issued, with the severity of the message controlled by the
   * timeout_sev data field.
   */
  `SVT_XVM(event) TIMEOUT;

  /**
   * Public data member which can be modified to change the verbosity of the timeout
   * message. Defaults to the verbosity corresponding to a 'warning' or 'note' message.
   */
  `SVT_XVM(verbosity) timeout_verb = `SVT_XVM_UC(MEDIUM);

  /**
   * Public data member which can be modified to change the severity of the timeout
   * message when timeout_verb is MEDIUM (i.e., when the timeout message is a
   * 'warning' or 'note' message. Defaults to the severity corresponding to a 'warning'
   * message.
   */
  `SVT_XVM(severity) timeout_sev = `SVT_XVM_UC(WARNING);

  /**
   * Component through which messages are routed.
   */
  `SVT_XVM(report_object) reporter;
`endif

  /**
   * Identifies the product suite with which a derivative class is associated. Can be accessed
   * through 'get_suite_name()', but cannot be altered after object creation.
   */
  protected string  suite_name = "";
  
  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

//svt_vcs_lic_vip_protect
`protected
90ILX;NC3ZAS>&<##U?a_\?W>=]@MK\1UVfX]HKEH[(^;PO?RTQ:5(+FC?X])8M4
eX\\V#NGU5[H8ScH(U\7Kc5SUa@;O^H@H;L(cXX=b2<@cT/EOP:c):E-)Cf(@b6(
BfX&eYb85LTa;,A0.Q1dEW5F_TXYTdS8.8a9AP_E8:[Ce(74_CEZ5&f:gJRY0,Xc
#6=Xg4c3DI=HU0@bdTVIV_A9D(IbJARPKS?JBa4^_H@OA0QD,M1E6=K:R-6\YP^.
,MW=G#g?0R:[7f0Bg:Y=^DSXEO9E_d_eK;ZRb@7d(14dMK,daTf6TeD<_=YO0SD4
5WY#/)d.]:/5U7P7#/&E@g\T2(H8,N\BG^7I_:eE/67g<0X2ceGaQI.0Cf,852BN
^##72;Mb82cIXQDK,=..H:fM5Ce[/a&9];Ja5N_fH/Ja+DM-=V#Tf4S-VNAf2EV[
:SSJEHIcLbZF<FMD,SA-.5bSC35bgJY2Y@<RKA-5&VZG2g,K)D(=7?KaYPFRC^c:
(RC/O?1#8=Y1egKA;[W/1]Kc04/Z[1ZgGVHG.gZ/#US3@&B-g[A^d_e/4RMFS:BG
IS0,VAP:E:3Vb?VeV&=9,REZ-J53HV)UFQEL\DLTW,>1WE16.5JcIZb\fQSR,bdK
KLc7)dfUM8U9VS0c&-]Yd>.-WCOUW2Xe)agF-\(^]G[cVHD[WW:bL-0.JbU;SB7d
=^=(:33#.]H6L&Yf.1N+,O3?ZQ]&P=_O[69f8b2cDVXN[H]=9c8TVSR6A_b;0MKJ
JAVfgLS,TCS;E?\VeJD37A:Ee1JfY2,2Y5eb4OeRTGMfX#H;I-VfN\F;)-R<0L(&
#Q&P&52X+YQL,F\@-Z-Db[)4;H8ZW5)\]ALJ2A,DV[1F7/cVS=Cf^5JbE()[]b2C
=ZF,R8@>R\FVS\^#)QGH7_e#7NTH_A8^c7@;G5/fN6aDL0E:c)M/AX;<gV5.C/UZ
JQMK9F?cEWF&4f4)M/5F9F;bc^XH/2)G/IKd/+Ye3GE+@de7JWZd5B/f=?a?ae,/
&:#H;B-5?c1D;\>;UOcC<,9#TMH8,I8NK-]gb&XE[=,GQBD68\YS::9f(+],)La(
82b^O7\QM/K3M)9OZ>]Z8[0cgGFfO-e/g]&-Ga0W_[QX5D#KEIPJ1G.[LZU,=D^Y
,dJJ-g]_3^_-eTYM5Y_7BDN_EBOQX&TS_c6I-9+9UK8/>SKK1Jd:-_=AFNGDTFg&
SeG(F9.+>?B9[<^PUEaLMUS\<;X=4[R#;^4OF:]WQ&U]b;U35F#T@ZMfTSe\DT9C
H6G_DZ]C@ddGJC;c-PdE5B=d6I)A].gK5\:Z30XfP=-XYZSSIcIUf9Tef_b)76P[
]gY(\LO013;6</;d5XMK62e8+-<J(95+P/_5([GA>/B&-<75b,(Q)#I,Y3>H52-g
_e\cKb.\@f6,7c;.&fC()P8BZ27MR:VK4f_&HTK27^NeeE^5/3MI=DU\bbU^L,T:
M379cT?aYWK>AeANZA]4e2[14S[CPUL8Q#P25=W^;:IfG2(,;BNOBZHS/H@/=]K:
G\@0U:^\7f[Z-GM&9D+aa>Zb2B8?#bafU>\Ag6&f[#NEadDCM>V[W?WeRbg>2]UK
)X2=gCBd@,G7D[&?\g:b?<74/S]R>?A+,572?V4USB,dV4c(>P_VgYf5,TW])[Fc
4YXW#WI-4Mf:NA\e]GKd7HCBJC;1;F@:Z3T-^cbA#7CM<N.&3;;?@^+:>R07+@OW
cI<85KJFS6O]_2(JQA[4Z4HLg8\51V&AYAD89WaYDF#Z=\OXA1WJU3U2S99eALQ>
AV&9WR?V@Q)S9YNfT+9<=Ed_98<P(-TC9&\VP?N,dW;?;B_-_NB9Z&)f.c4>.>74
@W&dY5aS\3/F7>Ma/)e8Ue>FGg=^#RC;4SXUT(BAH./ZER]D=61ACM1JR1fGPGOa
X^]JfCgSM4=?WI5ERZdIeA,>KF9cXRCB9-0f_7:MY68\S#7DD-e/9)9Y48DS1O1T
P6YWdEX+N[EL-Ab0U\O#Q>4BF&LA^@O(2:TRWAJ)+_)PI-E)eZ0b4RHP5g#U?+]+
W>B/bY7eS/Q;1;-AY5fF[6Y;--_69FQ(TJ/MQO-FfRW5)b]S40Ud\WdZ\Wa2[cYE
MJW+SE\A6f21&bN0aQ=NH@]d:DJ/[=0]2UR37g<7<S=M2c/c)^CZaRLQbB>\Z62H
f;7]F\9=2^[dF/a#D;5\WX.aBfW.T&41+dM3IJ=ONP>?TaK&<\9aS]=)D>U,80aH
#KbW=DI=fa,EF/<aGO@)7X8ZR&M==_/3Ha./S/SWR9aO=VF\RVWV.@Ta\NB(/Y&)
)\5#+eVLKX,\L#\@0]Q(LZaYP5b/N1J[RU.X+.cA:R=:<-/;;cP6_/EDbAbOMeBN
;A_g_/R:1:(=W:?F>OK/b<:0NG9IPNSDc^Y5H[#>EL4=;/TANObL6KDU=^CBF-)^
8YJX9bK7e3d9[/NIHK+&S_aTMd3@Z)7f[cPHUB9^.00V[3)GebQ7Gg\Q<OO\?&:#
K=7?<+9],M27,H05Y9f+TPRC#/[Cb2::E_=K3Z48fO]&e:4;B5?\&DGaDMF/TH;e
3c^J1X+R^[SS]J.E3f=7E20CPdYcZQ-)90SM2A.+@+Y_Eab9@@(+#.G9U6>16KJK
(UaDX_aY40EAIJgD4SO1SaDO<9F5g75/AN_A<^4S3CE]QIAA1VJ2<PMP+#CdVU[Q
AGeN/R?AOWG,:6eESXKNCbe8Tc,dCC12W_U3e\SYK.)K=4SR8D]14M?J64dP5?dO
58<.?XN=aVd<>-W0c=O6BG&9ZE:=^FC=dJ;C_0JIgdfJ;=cgZ)C>0@7@0.\b&INU
3Xf7T4R;+4CJOIS,c-90fJ)GGSIX2UJ<4:R#V3N<UAD4@]26>I&H]4,=e;=[b_)d
0(0,A&?7N=S8(/eQB/;O\-,Y]ddLI/T2MQC;JH1BcS3W?W[d=Yf_?4ZdWW#-15J:
a;>H8E=JaN[F2_7@B;IJYe.4QVK6aU<J.M:G\3Y@9U:]9e/c5B:8BZ<5@PDX4O0+
P_NAX(5cdM>fd,ZgUXg]C3XSSH2gZ;CN]V-33X919d5-;aR/FET(d>IaIdF3XgE<
GbVge-@B[FK9CCU5-OI_-MWKNH6D6M1&<Y.2Tf0(P@[g?>,@>[A6E/\P^39(I10.
[gOX_(X;SZJO-;]#M43V/-d0dPeA0a?\RUaKKQ:LT3U6CR_J;H@1fM_G(O-F>VO,
5>E1c&?eEK=5T_U\Y,7H\LDR@0gZVO0c=2P9=V9)Q&Q#<38J-M-3c^;Q0\6W6T^/
f88#QGHVMF2SA&d3&YONYGZX/>dYM^DS0>gB6g7TH&?)A,5]Vb6=[+<3AH2XES=M
#3^CfZBIZSQIXO7Y.RSf-LGSJbZEg(F-:CQd1,FW@LY)A$
`endprotected


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Creates a new instance of this class.
   *
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
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
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
   * @param inst The name of the timer instance, for its logger.
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param reporter A component through which messages are routed
   */
  extern function new(string suite_name, string inst, svt_err_check check = null, `SVT_XVM(report_object) reporter = null);
`endif

  // ---------------------------------------------------------------------------
  /** Resets the contents of the object. */
  extern function void reset();

  // ---------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Initialize the contents with the provided objects.
   *
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param log An vmm_log object reference used to replace the default internal
   * logger.
   */
  extern function void init(svt_err_check check = null, vmm_log log = null);
`else
  /**
   * Initialize the contents with the provided objects.
   *
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param reporter A component through which messages are routed
   */
  extern function void init(svt_err_check check = null, `SVT_XVM(report_object) reporter = null);
`endif

  // ---------------------------------------------------------------------------
  /** Returns the suite name associated with the timer. */
  extern virtual function string get_suite_name();
  
  // ---------------------------------------------------------------------------
  /** Sets the instance name of this object. */
  extern virtual function void set_instance(string inst);

  // ---------------------------------------------------------------------------
  /** Returns the instance name of this object. */
  extern virtual function string get_instance();

  // ---------------------------------------------------------------------------
  /** Returns the current fuse_length. */
  extern virtual function real get_fuse_length();

  // ---------------------------------------------------------------------------
  /** If the timer is active, returns the current start time. Otherwise returns 0. */
  extern virtual function real get_start_time();

  // ---------------------------------------------------------------------------
  /** If the timer is active, returns the current stop time. Otherwise returns 0. */
  extern virtual function real get_stop_time();

  // ---------------------------------------------------------------------------
  /**
   * If the timer is active, returns the time delta between the current time and
   * the start time. Otherwise returns 0.
   */
  extern virtual function real get_expired_time();

  // ---------------------------------------------------------------------------
  /**
   * If the timer is active, returns the time delta between the current time and
   * the expected stop time. Otherwise returns 0.
   */
  extern virtual function real get_remaining_time();

  // ---------------------------------------------------------------------------
  /**
   * As the SVT library may be accessed by multiple VIP and testbench clients,
   * possibly with timescale settings which differ from each other and/or
   * which differ from the SVT timescale, the svt_timer includes a scaling
   * factor to convert from the client timescale to the SVT timescale.
   *
   * This method sets the scaling factor for time literal logic. All clients that
   * use svt_timer instances must call this method with a value of '1ns' before
   * using these timers. This calibrates the timers so that they can convert client
   * provided time literal values (i.e., interpreted using the client timescale)
   * into values consistent with the timescale being used by the SVT package.
   */
  extern function void calibrate(longint client_ns);

  //----------------------------------------------------------------------------
  /**
   * Watch out for the EXPIRED or STOPPED indication.
   *
   * @param timed_out Indicates whether the method is returning due to a timeout (1)
   * or due to the timer being stopped (0).
   */
  extern virtual task wait_for_timeout(output bit timed_out);

  //----------------------------------------------------------------------------
  /** Method to track a timeout forever, flagging timeouts if and when they occur. */
  extern virtual task track_timeout_forever();

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
   * Start the timer, setting up a timeout based on positive_fuse_value. For this
   * timer, a positive_fuse_value of 0 results in an infinite timeout.
   * @param positive_fuse_value The timeout time, interpreted by the do_delay()
   * method.
   * @param reason String that describes the reason for the start, and which is used to
   * indicate the start reason in the start messages.
   */
  extern virtual function void start_infinite_timer(real positive_fuse_value, string reason = "");

  //----------------------------------------------------------------------------
  /**
   * Start the timer, setting up a timeout based on positive_fuse_value. For this
   * timer, a positive_fuse_value of 0 results in an immediate timeout.
   * @param positive_fuse_value The timeout time, interpreted by the do_delay()
   * method.
   * @param reason String that describes the reason for the start, and which is used to
   * indicate the start reason in the start messages.
   */
  extern virtual function void start_finite_timer(real positive_fuse_value, string reason = "");

  //----------------------------------------------------------------------------
  /**
   * Retart the timer, using the current fuse_length, as specified by the most recent call
   * to any of the start_timer methods.
   * @param reason String that describes the reason for the restart, and which is used to
   * indicate the restart reason in the restart messages.
   */
  extern virtual function void restart_timer(string reason = "");

  //----------------------------------------------------------------------------
  /**
   * Stop the timer.
   * @param reason String that describes the reason for the stop, and which is used to
   * indicate the stop reason in the stop messages.
   */
  extern virtual function void stop_timer(string reason = "");

  //----------------------------------------------------------------------------
  /**
   * Method which actually implements the delay. By default implemented to just do a time unit based celay.
   * Extended classes could override this method to implement cycle or other types of delays.
   */
  extern virtual task do_delay(real delay_value);

  //----------------------------------------------------------------------------
  /** Block for fuse_length time delay */
  extern virtual protected task main(bit zero_is_infinite);

  // ---------------------------------------------------------------------------
  /** Returns 1 if timer is running, 0 otherwise */
  extern function bit is_active();

  // ---------------------------------------------------------------------------
  /**
   * Set the message verbosity associated with timer timeout. This method takes
   * care of the methodology specific severity settings.
   *
   * @param sev The severity level to be established.
   */
  extern function void set_timeout_sev(svt_types::severity_enum sev);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
-cX=)<D<0]CZ@7R=USDVaP-@[Sa@^]?C[;V3c0eWP<(D-WaD7fM&3((^a4S;Sa;?
B?JQe<GJX]]##6ScMVB,L7U1Kcd]M7,ZRFO_F6;-LPJK<L;]D..+DSdEf:<E(([:
4bN5E&ZF@TA98R(89RU[R;<Y>++I8=?@G78M3M&<dL6^d;_N^T:e?D4[aVMD+Yd?
+c+IKYMgSK&W=#5T/E;^+YT-)fc-9eQNP_Aa\Ag4fb;UKag^?-d\OR7:SHXf/S7a
P(>2V4:R>@O-.2WID;(2L4gM-<-)6]PG?1DNRGU09aPgY0B4WYfZeSBD6HH8+D79
1ZDUCZ(O==g3\REb^QP?bef\D=;(ZKKL@H-Bb4OUN;Z=.]CZ,QgMN\3cA)T&-b,<
D:@,_PPW2ML9#40\S-?3,f3&=09fKMVDg=J>Jf:7+J0Qg\cPR3GI:#cUR@eYc/L]
Aa9+aQSRAVTA5DC8GFKMSfY17Q+0B0CN#ANJ_6GOf+2+c_>/?-,2Pa3=):^4T[?W
Y(c=/UgD\B@42(B1/[Y:WYU\QS^Y=,VbO?]JXGDPUNE\-25>J/b&HcaC5e])gP3=
O@1FbfITY#aGN&&0>[=AZ,:S8BK#[b&.RW((eQ9@N9M3&,IVZYP_edfd,0<Z2FNO
C3cJcR^(&Z2,AS4gQ+&R,[0#,KEC6J-C+VYD@M5KTWXOS=3;ZTAP,3E?QVJ.PNN#
_G4;\/_-K-TeF5S=Udg;Ia)=?ZdPRY25\)H-G>d:W)B594+-I<]5V,]0T]CC))fe
=[fO\CHQX#\&RP.]FHM=A;@5aV6\1^fR=.1^[cN944)67[b</UP7^b)XU1\&@TdT
\X7DWG7BI:0&7beg[E?OWb:e=M#+U[6MOQKFDWRA7/+1(dSC\P\QP-7_9a:CF]#A
(2)ZZ#=E5N_2Lf<XIS#8&R>S-a@a3G\P4),F#dR>U2<_QM[#B7MP_9?UAPCC?#2c
I1HS-b]X>RaY=.c/aO_7-@gM,6,Q^g1.^DT2Qg0g#ITL56(++;6J1,FK7e4Zd7N4
KGTFeM/IG;Q^J-RQ5F@DWY/C((G2];KDL4XK.@N2OU_G[X&LIJ]^G]N2S?PaE6gV
970B?4^\R_W(&aP87+X1R+SVXZf)7J7L;)/J[QUMY+3C^QEMXf[9=O3_b]ZOEZCL
OF,P@#\b@2__OI>C4=^ULe8bH4b<dP&.236]2/7T\/cVIFM9>)OgU<O;138KYVNF
K-,-[-QP624FK7P-X7Y0HV]dSF]Y+\-OfL3W<+^5c)W8e_Y?R8/XJ2WLVbONKK&Q
P\&5L;g?RfQSA)7^SRSJ&c.8^2Q7]CdZ;(0>/XRSJbfRNH995&C[MQ6C1/NB]7H9
N6Ud^=M4@D2<#<NNZ6#X&>_,G/]g0,Aab+bBI=ZfLaXg.<6@W[>M6(QZ?,<7d/Za
?;Z9O[Q#P.cM^J>(\HEce=B1CZcB=ZBQPU<f/3.@QMS;P#,)E#J8Q\;T-CM-/[9<
T;TW#\(,-5/SO_,Ke[GDN\D2N=;=E33CBQGdSNAfG=?dGDT8J<&PN@IP2UP2@cC[
3(7T.4?>=a0fQQ)-AUGXc3e8&^[5(e]M1Ec[#_Xd;A43LbY(3>B7#+K6@=[=+RKC
E+W,]La2/cW&bd-d&-,T_D.b[a/g.gS/4c;I.e>?Y.D&C^2=(6,MX>UUdZ/A.5F=
FCgg\PAI^TfHb\e)IHfGIG@V&M4M06R]>Q]Mc]S3H5Q[U#RbdQKeK.QZfP1VXaLU
_??1]I&@O_D/bUS<=:5>C\OF2^6_T1M8KME?UI_EX_7H7>&3(XR5?1Z^V_,3(gd^
@FUBAd326Z:7J@48VA1T=:V]+HYG9Y6Ag<bT\6JE5E]&aRV:d#1ee#[17c61&1UJ
aQSL#V/Ed2^GT8#aD/?(<7CF1Y/?8JL8E(,C8EJJ?3V8da#?+.^g1])2/V7CV[Re
:^><EFX\Z\^(QC5,6HK8.cLT<L+W(e#)Na_)d)Af/NXf=QP&&fIF/b7T/S&EL#9<
5TLX&(TX;b@QCT=[9SU?C?5);7K0KUG87e@B#XI9A[d6M13:0JK[PGc3BTS</P+8
S/B=[X)(S40X^V@^Ib1NDN(&]CU-V:d#)HK6cICR(&=eYL:1ec(RVCb:8FV_KbM6
:I31A)P/MTC<(KJ^=L[2b+R<Y)ePfB,&<2c^=dLc1R3FJ_:5(;PH)G)dBCD:a\AR
II=<L-3ee2.eO/[5G]D;CS95@4/H+=:WWJ36K.^&=51Z,-bd4,WUT(\/P4L8TbE(
D[)/6aKLV:;PX.VKHC1Y,5e8-OD0R+(9)TAKcQZ-G1,G_N6S=P&#dPd<C>P+IV0+
EAF73#7Gd^bb4ca-T4[4KOYA0LPS4Q[M9F0G#]\D.@D>\)7;98[5ff:OIFDc@0J@
9:C[M)MERVA(bbe=NS^g5@-_g7Ef,UQCEG08=&48WA20I)^-#+LCV9Sd?^Pd;&<3
^5CbKJBO(-bB]2@;Q;\JI6D&TXH0#K^/^BMPGG7N(V&>0IQ80#74aVe8H<,P0^XP
-KU&,.G->_G1/0\Y9HS<-.AQG-/Ad:,\4@DS\Bb39A8[F2adH-V09gU5FBAb2_@:
D?Q@[4=LbCW4I9D_L.V+Med/f(\f,Z6\E.8#H=0.,+)\,(IS7WY7-CBWJUeS<>J0
QU&&+5)bOYMS\<gP2VVMZ&IZb33fOAX5O1[X-\?LGO<4_bDPPCB70B:cY3^#a]8#
L0cH&+F:CSJP=XGZMJI-.RJM#A-DQKRa1]]27b2+IWJ&RC=&7BC6O=eaI_/)0c4Y
Q#E^1eaa]8aS[Naf9^3V;T=)Cf:A,EAW]bYFLZ0^e9DW=FK)-VQIF73E(1D:\=Q0
T+UGgF^a@,PV-^a]P^YJ<].P,UGHY^UP]\U[G^DK)7>J0/F]:USIF73FPcM7B)(E
>EdGKK^1)W@LeB2fW>SO#/2g63ZRe^Cd7N5LCYPBE6O.TQTfeM[?<eLVBK[_)@_Z
g=,3_.A\O]/c1EQF1?+cBEVOVP0-V+A>1fc2bV4Y/^CJB;K:C8Cf4]Q\g1]^JIZc
+B-EK[Ub3f7:DF-bd:)YEM&T-bZH[K,>FQ@cXe)^Be&L4H_)U@?+@^ce889[ISfW
U)U[A<8bfNZF@>E0b,M\BX(]A5J65EfR(]\Z^#L6MSMWRW#KL/Y\;#3U-/6OQSNA
O9X390[,+?AGG2EGN=8BfTSFQ4Z.)&MJR1\O<L\(O8e,;&_9/6?U8a9Q&WU.e2+F
2d=S7/G#A42)-E?Z7S?2A0ST2+cS9EJfSLB\bgD7)41Z]\/#6T-1OX24fe9(>1<Z
\H6,.HCNN]=#4&(017[.:I6BM>K/,eDEU=BVDXc=C3UU:]:^e./^V20/1:8N>,;]
OS>#c9K/R6fX-cD6:(],Q;e-NSV+\.MX08P9gY\<.GX[f#,T=,XWAWPDRSF\gYXS
;BU3c-5EcgQJP^gK>RY+f?AOJ2MP/536;::7RCTOK&OFHbU,=722J:D:3&_MV<Ba
M\2M1UGN_PaQ#ddfKT-/O,X1=CI#EM[0cP=/TF2MWb6_[YQc@_41^Q7ag<M23&8H
L<fa6f]e,Y\?eM+:AJHZ?>]ZALPc_3K:dY)NXVZF0&ZK1d419NSOOe,=be+g0e6Q
&-X_SeP,T#-IO8aaR[@&V<+D,@FV<@8TL;,)Q_ZSNa>&A)O7P41aYgARC[B=G?)(
#Z:B\+-TK?fc@9]/QVdabeDUgTDXLebD0XX=aXeZ9U.9-B7=<b\b;N/U=@^E-]RK
edeY@3)@YERSH)U)IG?3@,QK;<1N:c;/&)5-MY?Jd:N+FXbIP0U.[9YBHQ]E&6:D
^,>?&Z@MaMA4;^-NAeTVID28ZeF1gAPY&M_K7Z/SQ<-&([#D95;2YbQJ>B.H#GA4
PQ>1Sa/TXRQNWXKXLNTQ-/[_C]U=g8BR_aBe:NVF52/<UFR:be1HX>^UY_#W2a5^
Q1+e):a2N1^(C>I\S,5d1@>6<>&VbGR:0^E+c^IM3^d[6d6_AEdG3dcg]N1(E3T\
E,-R1:Y);Q7b^=XdD+f3B/c45ba?:;U[Q_O@Qg0Q^M2GF0@e)LHD)5HaHCSJ/B\Y
ADe?=>RC8/7EaCAFMAQB__<H[:RP9gE?f<NO1G(::NU:d/)YZ0@G[QUfIf#4g4.b
5WSGOV</GFRN5FgbR0&UZ64J&@<85VXG&5ZdK&D=?^E;3ASfAcQ?RA5+1gCHeg,I
ETc.Sf+A\.]DX8dP:2XV4.@Z]>[]Zda0E4]bU1f<(N(068HYF3]aCcc)L_KXKW-H
#-+BD4)f5SZ=d(K.=K8I]L^MHN4UX#JM90Q\^<#/Q>ELEe7B=BPRSJ+8RO+VAB-Z
Q+/f#\LZHN4E&L=7&(#Z?A4[5E;1.>#?MR,<P+O(VM/MB]aU;=Me[1G:6(QK@,-A
>ZOH[+RD8dE4_<X[?B0GXFI[GXJ;@=b2G6F,gMACZLC&<J0cX#fSg3_,)DE6VQd+
TKJeH[/.8-Vgd8dE>OGM5fQ8dIL5T0DI6.E.8W<9:b,U#8b13FPS\,,.<9;@81Rd
[<)=XII,b#Q2?-L6\([^W:_3E[21]5gIY-aLJZT^S>,7.DB,Ae_gE(Z>Ig\;GM?9
J\39ecA1&R\PH/QNccHD)c8M,?CZ\8ZfDQ;Y(0d1;9O?Q8RT33e1Z.?NZ+,TbB6Y
d20DXAI<dK3BN&P[&R[3D\+TA5IK^7711a><><_6P3X32Z0g[OS>J\QE<7((\8]d
eUgYCRb?c#]7&6M[;Fa)]Fd0UH)^GJ=<,W8A(5C5Hf#T&-]a/?,>NQ6<0?ZdRDTb
,4,e8G[Z:3P2N[\)(F+CV&6J]\PeKAY&bN+?f,aed&:@0&Pg@Pc=7b5QB(H8,JQ=
J#(L_SBfL&;@d;TI)9c.:>V(N=C;KXXBY;<YA<I=MV\KK9A(S_Hg21T8&@=<KM6;
8SO6RbIZYf>G/S>H0IIU1QY\/(G1+/=Za29WB6;JJISVgG&<gD_A5DROJ:g3f-RV
;M76Ma_A=,XZ<JJ+=65fdd(CJVVG]_Dd35NHVY5._H-V.WfPYbd#11?f1[0UeG3L
F),.M+I-)ZM/7fHLN/@LVKM&)2g/Q/Tad]4>_>&(gE<dNc+)PYV?/]:T;A:I0:_e
8V4.O]5=M]WL_+?TV/?H,W^HXZWX57Vb?K&C5Y=T7:eOa,gg;-C9.g-2gSQfe2(>
Q?2I?VP<,70cYcC^;,-5eZ(Sa2FCX4=AF:aNC9.9b;b@MYg,^:gU[?G\W5aR=#9@
.O4;PJ#?][ZZW\),O@f5eF^04bF.GXG+=eLW4DgZJ@CPZ<B8@F&SL:4&_TR&H[_6
VZBZ\Ef7)Mc5-&HQd2M+;@H_1gLcM0BNU<Q236SSSZ?-A(Bg<ZDf,@d\LH<-d3,.
N8A#]B3:EcNgFC/Q/Pb^M@+GLdXe<1:2HR8gC9??H]+GO,b+PQB^/a4V^3PHN8(G
PLE]LeMa87.QZK1\#=28?VB>53L@beB\aS+OF2Ye:gU:D-@Z:(]dX,./49UOceUb
P:A3E?;@)CdJGVZ.2-Z#3(Y;g@ST?G/<-5G9F22eE,7/14U.gaa6KdP]_JJ?A0(G
,f,Q5Y:O>XGK82gZJfY25gf@EOT^V_M64_<S,CE(NKIUe10?PU>_^U>+P)NZ:K4I
L&5.YQ#4W&][@Gb.I0<TPYZ1.+C7<9BbIfF\,^(]c?>Oc5OMN:8VJ#?MgJ.KcUK8
&e(9(H7W7&=#4.93+&a8-#2=BEP)K5Hc#8D2bDV+=9gAW-]&1JW[TM]\P^V[(>AC
<AN\23,IOJFQ?R;H>1=P?^RD_A=?O-JLI\GHJDV=gI2_MJ9XPQJg5bdKJ[U7#8a(
<NNZRL73::O[a1(cdP@+-CR;0A?)CIJ,_^\3-PT^@f+7Z42aFN_/-A2^@&Y\I:[_
C7PRG,S8^/HI=T_16WEJ^+?>J.X@D=TUW?[4HJJAM2G8G31LQ(f?@T823da<cTaH
(gC^\-M[CZf(KN].0XR4WQQ+A#H(XC1NKUgbGP[+\4W+#\U\QMc2MWfS7H.)<Bc5
WR[I9]U4OAHJ2L^_dg^b&#/MfMIF,FT?>C<T<A7,HacReG8J<Ea\f=b<MXR2;PLW
4,&KNV,09PN&b1\/cN??@#PU@=QXNQ8Zb2##[]2RMf(GWZ,R#cQJ<e>Zd=KCENG&
\G[EN[4RBP<XTFQ6/C(NUXE4eM)gI9:KeJ;@#FTA6?f8#9,<<^d(AK[eWS-2g+(f
USCeP0]7g7a_gc=W1WB4T7:FSed30d^-aIP=4a>4_Z;,\7ONC)CQ.:3Ud29)=35/
46=SHg2cBd&>\Sdg]KK0A:F9Xe#3D&Lf;OTEV/2F.9EBM8OU.:F3\R3d\DW&LAb^
C,Z36C+ZPL3Ae?C&&AI,OWegI5RO9b=>07]b6cV(.3cLDcI@Q+WCe;9;7C,AgSNA
Q:OP0B0K<6#S1-.[aV9C9UgVWd=SLf46T17/E?/2[>7<FNCNC>a=cONbIX,?93cg
4faC=VED0,D&V:TH)VV9E_;M:H<+)&V,0.IH2]D6K_+[R#aO#dOMX5?/AGV)T1<I
UG6b#7M0N,WZ]7MA:H6=8ONGFY&PT]68X^2GRH1E1Tf/0#/D-OR2g8R]=VJRF_f\
9K,RDRACV<VWeZDI0Va5F8b@\1Q;9_2[G2fN5ILVMA<DM]28\MT^TC[Ic8,0:?3^
)I_b/FV#/W=RBI7:A=F83HYW1Y3603&eP90H#P-4.d.>02K0N5(dBC/1JFg7O[&[
Df-]4J__DU:=.<YI^]>AM/Ec5A,>1QT5X@EH#5]8(QD5K[B/E2LTR)eAb.=3))\Y
gN05M#9OK:+7,DS1YBL5F-7U0b,/H</ba1ENLT(ZJ:RLO>dMVf&A6DCG,/]<;\S?
FdGV#S)>?J7TXB/.-D.[GHHbV@R0;cVOKZ,[OT+4?8ZfTgO>If>D^)#R46cP8RW:
>eL;=&XcQ]8EPX(Y?dDSG,)-20B4(>05@^JRS?I2.G^D@K+?;D;,K2CA)/2c_EB;
I<K+F\[>e0MS6DQ>;H)(-5B\>-JCW=>;c/c_]GEg9XSK=8-9ec[I>b.=HZbTYN^=
[,3UAWdQ.V.f[D<Y:.=,-WC6U7?HOUDO3ZHAA)g]EWD/?+VF&c+6;);2L^71aPfV
58YI@SP<;V_,ea:<5J.W/8eUGMO(?3e7]33&B56[-TDeF891IeYK6dZF)0d@585+
fC+9N=VQeY4PE261\\9&@O#HCB&FTWB&^2ba][+;\1?C^WZ(@1X#1AUEfOLRQK>/
/6O^=+G\f9N]R&U.E,0<6H\=7e6eML2cHTJ;L<TLF4?\.R>]&L_<P]M:3NLV)1^Y
&^OZ0C&P9\[B?^-\FJUBF:AL1Z+A<+@(I&-T\9:,:LV[gBHL#3IMJ[K4T3JL)/(b
K[B<c-\@2ag(</_FWS;_Tg4e@3aW;)-=&GU&@Q1fPQfMO#CAM<\D,UFBREJPIKI?
P_?HS19^Z;OU<.GRW(<d<&?&XX<=Id_<20a)-4T.HgJ8[cdJ>:9d8[&0cMSf7#7Z
[B6-(CV[4I9^0RDa9aH81;0S/653J8fR3#GL24+:KEJKQY_[W3IcT7-5:T@16SFK
\aSZCG7G,@gQ_85?^\c79TaULeJFVBT(H)g]EYA<ec&Ic.&TL;^XIgJ3=HECF/)V
Z4cdV85cNBU;FUR,(A-dZ\d;2=/OWT77GdAX1-d_fJQX>g;<>W9AT<f_N0-Yg3/Q
O^L3;+?^/Z>G1JNZEa5Y:-P;(_cLK-I4P^0c\f/ZV8CX^OfaH4AS8U+58Y<UT(X\
WL4a+WKRO2T/g8+K1RJ_f54;,1L,Q\RXK(+UD#-[fT.Mb2beD-[P/&#-+QX0:K_C
]Ub,U4#9&RZBIV0KMQ,]K#E9P,##+T.^#5I@8A\7#ON7aDT7PgC>#7/1CTQ&3)RR
PfQ-W[RM]0IgY<YBFHK#2+F#N25CP)>GN8ZDFed_@]UQ.NS6GX)>dU2(^TJ5dC+#
QCE#ELbF7,Rc77A-5W[;3\OVG-S4,YX&.>TS00:<K=KX81_9.&;HQ9S1/EGHH4Dd
^d<D2P2MSH+a2F,<#?_LY4Z/Jg6-3A(HHMZ@<&:bb)KX9M\F^[J_LBFYQOJKQ1cE
TANL#NS&HfHFYU6:4>OU4A#N7TNgeFfJ@G67X277QX)E55LB9=C=-[2<02G;[U-V
b5SFCE[R,TKT5YZ4We\S>fZ,c+98FLbZQa5&^bFLTPG1V7455a32JUI##=N97SBb
d+Hb:SLNf\/UfNB5A)#0A-?QY)W5cY214-fASM#7AIXE:JKAT+D4P;c@Re7#PQP<
M+.\Z#PC7CF>XHH]BQ^AC1J-aaLWN9.<WI2eb6>0-Z/:2J0.b]ML)b+gN6g?e=67
9a+66VQ0WLLO)P6[SE<TQXGce]^H6^ZU)GN6LagR_.B\GE=(.#SKW7T-ZXT3-K]K
JHG+[R65X]RS]/M#9OL>W(X4LJ1L4:@\KS-?:8OW>H^>+,@7FJT7^R1,@W=O+Z)C
MSV+)N2/C\cBJB51E^a=d4.VG^;@G#CJ59c0+aQ=YO),GeD#^cFN8BZ),P.Y6+NY
P=[1A]QdCQFSOO6E#8Wc&d(FGJ5/<68[a;-)W\1gXL\-T=,Ne&gI,e,&5MI]+4A^
-&L;J6C_X-H]e;4:\MZfNA)0K\,0QcfZT9FENF3L=K&\W7gVB&^-_&)D-#BU\V8:
MT.9YfSVa2bT_];-<_S+6Ca[26954\X4H\BKb)\)772APfFX<EeQ=cFFVVZR>845
\3)IO8^@:9P+fb+BHL=\Q&ZdVK:H1</<>[E4]3>3],/^bQ_>.^N=FX7EU?(ZbC>-
K]7Bd##9:2B0:J_JA?KL=RD8LB<2-2?KU])@D_[2#JG@=D:<>D_<Fc7J[c_1[<PX
]dQCg06SR)Z-;(Vc=[U43Ge<KA></TP/?@XHO9<Q#=b6S@P>VULG--7\_,a3dJ@B
/11ZX0;^be&\?^AEZLQ<#CV-g\)RbX.cL=.+-C;LB3OCUcf8?3eQ7g@C8M@C7/+Q
WZ4AO:GcZDPb,R:Y)J4.,5B<<2.U2@39b4M#JQW?9B@?dIHGN]B6HA)5)#&ORcNK
YG<EY?PXdg#QNAK3MYAF-I=(WZ=AVaR0,W00XFD+0/NJG]->@L4#7+_W2Qa[Bc/7
?3+a+R<V[Ub[TI\LdXD9LMb_@K,gC2]PHBZ9WK4++3UXgZ410-CN@GY&aDS1SQQX
OXggL=[5cIEO_.eF2;TNMO13,[GA_eX1:g+M9P98)WV,9)gKa0-OASCY2b(KND:I
>_FKHa)b:G+?H>HN<6&7DEHfK;-[fBWb)1MTSC&.J)/67^]Md--0)BKXe<\929P5
C[M7.NFg?)RP4,BHGG=G&29_/O_05Cb593662NTT+ECIcZ>C&E\Ka(X74?4)+;=W
Z<,8#-72XA,/>)e90DX6f6_EFK0a^0#9O+eBDJ[YI]=DI,8Y8#)?+OAV86dgdL4[
A;STDa&KRURb>V/)6K^dfG\a/^LP[K,A#:-BTH_8NObZ[WTR5d5c)^SOV/EYI,LX
GGD\(-L-S,L7+ZW\XH(bT&GH:c(cNE-gWc.0V7=DWRd80g=^L9W1=Cg).ZQR[=#K
Y:<;S/#CZH\gGGC2@);X1cAedG)]=8Gf3=DQW5R3fK5d,Y)Mg(D0dP)=TK9D#)]@
L)H&d]>N\+g^X#6gK;#9J28bPAT\]/Z[4g>VLIcXFN7V.<S_[ag3#0)BP0:/X]XD
3/-NKK+I06+^^LW84,V037/KL&14g-^[L#-95;(e:a,eATbJ;0DKOTW.f)3TBJ?\
,=#VH1e[a+V+Y;MLQ[FP]AX0Y6)J-&\@b2RNXVIe1H].^L;]bc<=dN9,&]E>/:+;
KIfE5,S6aZ4MOg;#a:2.EXFdZ2]4OR&P86;#CN)1J]DQMLbOc9c>2>\g+#36,A;_
&CdZ47/#<ZL@E4GDA1P\)R?O@_RV=3FD+[-eGAN+2P,cSD;JYgPF>3IV1#0_;CTf
2+gUVREE.>K2K,-/M+Y0A;^W<11GYN^&&:KIJ\T9+IIBS?fW9OA&AS/Ibd+;\K7[
:AINFc^,(HA9g8K2T[7/UWL6_dA.E[F,bgIB@XR3_UP.g^<]SFYfcg,7eg5;dJPd
Lc:]QeY_;?;35^4\PX0-;KN]bZO2[))c6Q&f2Y>-O_T)I:039&NT8SQLTc69KZd;
GZ^P>9L6K&a@)&7_WNDLFQYI4-9^RD)e252I,:fZZB^8/GaZ5Q.dPR9NS<:BWRV-
T[[7GHb6cJf;/,eAaXEYPH&01-L@-Ufb8QeENJG3:a@<X<R\;&eRJd/6g7\Hc5U.
-ef-@?b5ed4,X2Fb=gJ7Z/Vga.8-D.Gb/BE8/#AdZee>d0Q:LM8&-BcWFDY674a]
07#7[,(5+?3C,G+;489@XOQRW)B/c-AH#,4P9\50,ORd<QSWFa7F7AdILE#,9@J]
#A5dI18:H=P.MW>:<D(0IVAE+6Zc#1[J>W/Pe26Y&,\5C==g_g.<RgbH;+C0^I8B
T\X[\H&8UZM.Tf/fAPfUE6J?D_D-+]/[deUOG8F&]JKUEMX8BS5CbgMGAB_ON_#b
5O:Q([Pc@Y\C7MZC2dN?NBIM45A9TH/KRRDWRSe;a3ad+_b;JU=>>Z7^@gJdKd2.
N]I+O)VS;M3+X-\9)Y&TA+S-&..AYO,+BHQV;/Da6#6d6X:KCKM#NUC&RbX<N1IK
7fI0caT43.[11a^XeULEQaN.@Y7c:IG7L@S:aa)Me2#Va6#[Q-:c.+A-#FS>88?1
aXW\;8A7,WDD>JJKIHGT6YLTS>A-ZX\F96LE/JBf>W&fB[5bK1aR#C(QfUP/(?bK
ZR4]FT\NLN_2;EN\@?+J+0S9b]CEGF]>g,_<AdZ-?L,/c<6IHTIREH)W-VS,+f.K
)0,U.E4UOV3A0_31#CP.<D[GdFaI2Z1;?OEGF?fJ>^-c/G^];4205[IX]ES0IRNY
+XNB-e0Q1,90/G5?,0&OZJK=Q0Q9Y3\.UH-6cP9P)XHLV1-:S0E.1b[HDe_?4-QN
aNA8\XS4AbZP]E)6<&U@CIA&e&>2=4K4aYTeMeC2,^D>_<P@#QLF-OXI@J:[e&K?
Q3,(&2+L3(\U61La;NUK@H[L-9A(;7f^);SO,16#U;NAaL/=@O.bT?138aK()296
0^IbacUT>J8^9^B\78F9SZ57T@@WM)P_475V<DJgGN;K;C#(MU9KQa\REU/R8^)c
b8S8VJ=U3D\/K?MPILA0J\fd7:RSSS._4VZabgG)4B0F3_#+eC^6STccA[+3B9TB
YC)B\SG0I[BW-@+dW,R^d3K+4)0.WVfHWbGgC0#ZdA)L#9Lf:8-]=dBg>0ZH]UW2
LTb_HNgeUCJM1GQZ.OIKS/_F[7_Of_f0Y[0\TF#4dP<V#SM)Oe;O)Q:XHN[K3-?)
;I;a<21b79aZS4MZ7@/bXEF5DQGW6TQJe24I>cHWHY2/(b<T[S2c,9>7V^g3)S/f
B]QZWS>I[9:IUVOE\KW[(58VL)W&HeWOM:<d@eg&QV;T&^&N<B._ScK:4]cU9(5=
I:J-M-BP?I=9.S:B,XRQLQbVL(R2bbb>GUX.WFU((U_cS2QYH\=Yee6>5#FBXR#)
KJe+Rd69R.7PG0&G3&9>G<D6KWZ=7^#S?;GK:\NRfX?D/QA-,J^V=3[gJKJc<C70
;We>29.-Ne9XC-EdYQEC5fA\79=\0E\g)S=T=M-1]G\\UKcW/BJJ_YB4-=FDI[HK
9U>f6c9#]FV._:8fKF8<VBS=gOIUX40(g/QKH+@DLe&V\.+,JL>9#8B#Y5[[L>><
b/]_[],LT:,Y7&QA[WS1BX67R?(:UI892O=Pd@AK#KMH1G.T-:KN4Na5E:b:7.WM
EIY-7U#fZfVG5@(?PW@PR>XXR<=0YF8N>_:\[EOE58f9g;@]IB=&M1;<X0DVB^61
0dc;XHcJ?BPY_E@SNfY;0ZVXBe2>M<<FC59f5UU?W/aWZS5U0D;MVX(BLWJH(5cf
0SPHB64(GE>eNO39[O=/G_EAf1)_C2aRQ2X1W>2a#SP/6[.g]S/1)2XF+=X0237,
#;W6Ie&1CI55g6Y:JZU+L.6SA?1U-ANMcgQHBd:9^d[(\3:ESXNSWK8L6U?.W,g?
\Q/O]aZ]]^,MeDa9<Z8P<-YAZc^E]B\\1W,A2<3YC;]&e+0AaXegaA<S3b4S>SS]
1T=SHB_]]=4S64HKCdS&183,#@T#EZYYRYT54,>.W\-:UZ0Ncf+4Wb^3>c?<cB_+
([BC6?f[ABY0K<^/P5@?VKRD/:HB?@&>NTZ;dWf91=EN+O4_@&9Y_[]0L]JDLb/#
:)4EgAfd1+4KbU++]&(S-Z43ECH5_708(2UF]=3K;C9f65R]N<..M9=05D&T6D7U
X.6e-Z_7TZ;cL,TB=GN<;R6d2bg7S8\dU0DF22b/U400gW-?R_dN0EIS:dTDd,aH
YJE&6:7aSMK-eTVZ4Df[,S?-VU<dbT8^S9>d/]W>??gTOWXVJC817WSe\8>3XF)E
B+SKVYHT2e-I>+,,-0-JQ:L,aH>-?0:5Bg_(D,71LP?Y+fXB(D_W5:3XJfaFRBLI
5cT&BM>8F;,=)DMWfU+IAD>=M.cLQIZ_+A#R:06VODW48g)VQF\,#:T-=D.B07H@
\67.#>DfU16KD@T/EA9)W\=Wa>&:7>\Y.g6^@<&bN:5fBWR\SHf4+6ZQVQ@[F#Tg
C0\a,U,KNEP<D8I:6IEV+eJPP5,Be7T.,/M599VKXb1DL5N4&.8F32HU.BXWP8J&
F6XQeQ@V5EHG\f#OPM\=AbLVTJ[CB^aLCE:W-_8>,H//cSe3aXNWU8UNC6,I_._8
]8:Q=LX][[8IV8QB&K=BN&^+:\8JLRV&f2Og-OR9gGWPA^+8[41?O<GEP(]N]>3L
=Y0#:F2/fCdW=#Dg);e=Ve-C^Vc-c@FL4F9cH+2cUE.=]2d>g\,b16Q7&-(C86VE
]MZ7OK/?g0/[P:^34QOKgYC.;RKgJ(_[9#P0V..8L_1QA1AbD(^96(RFHT:P0_CX
aL):,7^:SH_:e+&X-8PNLPBC=:PV:&2^JVM5WM6=NL?&d,^NWIYNK^Q,8[a4=LI#
5KA93AV(I(Pf;JKXMSY#gB+gWN;NZK<R240=HKYeB?<Z:#Ydb#;N5&.d>9O.?(+[
;EQ]N2S)ZT.0@d\++<P61fZBU:gS0(cSEEPZ^M.MG_::SGeQZe8>LX+OIB-=V4#X
6(KF-GE?BD.5dB;_VJ>_?PQ2a=b;Ea]]GfcfC&MCUQ,gRIXY?T3J4F6e_T<R\]Vg
)F]>AR/RFI-FB/AH59\A7DMeed@B.Y05X]bU,N=B)\cV+E8@/7K,?bX5VV=MF>Qc
Z@P&]c/X]/\YP=]=/H^?7(&ORQCY?YIS.@Q9ISK<.LVO/eGEb(8HB;B7N4(X&Q<b
99+dZ4L=T<2&BN\XFfPIEO7MJ5H]a9_bZVe.bDS##L\1_&^-8X-C#A>8\H0F6_Y:
S#c#+[<?Fg</.XX?QD=]fW;ID/;KSWNbIV1;JB]H5+HC]UcWM0/P/T^eR6_S8_D\
bW//1(a,SW0F<XPA:Q;O<QZc8LL[QMQX[NQ4eE01ee9(PE<\XSPM7H51O:LFCf4O
#>N<]9Z;N58P[(fVY.<6<BM&7Z<bZc4_I;dR?WQZ,LffZLZ=L#T?M6dE,>I&.J);
.\[>KP:G&6-H7]a#ZVD0L1X&V_TR?a2(R]LSYY56R#NQ]&/@/O)S6GW;2[V_&QHf
E>gU[de;BWK&RgCK#aCd5aeO@X&Tg<^8X22g4;MT7WEe.fa:/0L^eFgc0>SZALdO
eGYIf5-];0?/6X>NeOg_K:L_Y_Gg<UF1RLU=(bDD1S@M0OW4>)@1FCd,ST-PB-?5
D-BfM+5N.=gVM2;/Q7#;E]>N-Nb_(WeG#AS8:^U_N,:XF?R;\Q?.3G-?0Xccd?QY
#@EDM_]E[V9a;CV.6F-:C/#Meg3ER)YJNR.2,U@QYb\@<ZQN7/_54N<?<W5RK?<C
UZcW[gReKa-a\QA10eCU/IJNB@3J]Na@dAGKJ;.-F@=d1/gQPE&Z&NZJ>P,47K@a
_HR+J],>WfGU12EO-(-^BEe2YG>OS>SeGSBDB-99E0ZIKI5S<TR_3C9XJ+U^AaOZ
b,#d#6KZNcZ+W4S#IM.GL=,4JJ7cI6M;)WT+E,\LI])URZVVO(RN>AIC>P:E3BI+
^4eE,YWEP4N0#ZafSYMT8.+;>>\_8?H;2UUHX_03DKUFQ&CE4S-9.,FJ?Vf,6,X/
Y\VENCOF(Jbb>d9cC2)bY@FSOL9NF>f^4Pc9YJ<ePA0P)b_UO@W0(FAZgG,X(dP&
Hg5V?g<\@10/+?(#V5:YL+\F.f<SW[-L2YMHaTA-F6ZS>=7I>:SI?RbZa-C[OGLB
C)e#KV776QI4_PBEPEHb-L)Q.S(0fc3a2W3JNb]g.552U^F1DSE<3:81F0O1\_TT
AH:RQ&[LT#_><S9->&a.YLPE=90DgP)5eSVH<<d)N)Gf<C)Fd:_3FMaG9)?UOY-4
T[(]:@)@H(-b5(a2DW\4EagWNFWX#D7&Red==6:,ZW690^+<H<7(^S31<cJ)cGaX
Dc:;fO\PKJ1K,_^]<XHP/EP/.3?D=1F5O[^HHM.2E;&+:9OdPMTa+0A<MS(UVX[M
L=G;R@FXH8,-H#DH.YK+;^]4:^W1FQ=N@#JWT=c.G9)-SDA(RdZ8BCDdbQ&=BZ_O
E>g)2gHB,EF5Y0[9F.1&1+TGWeQ?-g_0UZ2fEUbbJ8XU;=dEC.33I(.8)LV@=,6+
TS>DN5@9C.[8UE(,C:eBV3#&a\.3LSL,9E(?Gf,]FDO[MKEFBG&M=J;7.BWSR7<Q
\@fAg]NCLZNFdcN@XU5AY:/Ob=^HX##<@9+DH7>_2-3I;ZPL9G5LPB@2KVI>7GDd
WWF>C9NH7A0-[U0O=K0I\Q_MQ]EMSQ2>BB:M@_Q1+.F4MAVIGgOL-gK3Z_3dE1,Q
&.f@=W9&c-C&MJM_Mb:,++A<?J#3?V8\_-K4LGd-g1:MPdMU,7)S<3#gGfbQHB8D
?6XC[[<F8Y-PGKU.=[3&>=\:A7ACO88V2PJ6F5^POVO25e:9G/Q#[a200]<^K?JJ
W-UQBcJXD&77M;4O[?Z6(a3_>K[\_8:R@GUHBGFHMM;E[^:HSW3G@gCaVa7,;bM)
H_@QT;JH\@IF4\HZb_A^bgZN7\IB/-3]>USE:[D8,:9,ZMRD_Mb(#81OT5)UY>KB
Xb:=QdJg];UDFg>gbY[#8E_,?CIVVX)Xa,HHF4&,2-AO3KRX\>c<)6#KD_6SfML8
/-JR.GHS6FW)HB\QAX]JF:1A=DI=TDXJ:^LX.Y[@U<2&]<1BIXLe83I-,^/N/6K#
-)QWfO1\/+2Af#[ORF<,[\_\-#bCAD>S&#PQE3g&NC\ZgWOHU08.Vgab0P-d7D33
7&@QOc3^R;6@H&V^NU)<S2J(-+e??KLC?d45bLSD]E-2/TKNDV=.S^LNSD1c-eQe
PcfVf:2Z@MM\B6VI>F\DL2dV]1;LJYT_B];S][O8D=ZK]YbQLT8QWH[\L^.;G>D[
a8c7GJHWd_MH,N,T10ed9)DSQ</TE[6d[f==^=ZR(##[?e1[?/c;VfZ.L3DZ&(FQ
]b)<SBB?8\^eH,f1SLFVU([4)Je<gMF4)gWg].S,_4SSeA:LAD(]52eWSHXX6P<>
ESE=-]_d9YV/VS:E/.=4OR@D;N((-f-6X,cLA_+4b4/[g1&&WNF3WX2ZAR]MQf=9
D]^UMQ++>0f#f@XLQ]#5Xd@1APGYe4Z=(,9bM=<6/T;Se?YOH-2E_eXORgad@W0S
I0S0O,f.4/>XI4#ZDCdS;.WAWU[>2CMC<<PV[g@A2fGbB5^?VKE--CEUcV_g7-L1
:W84FB02f7F<0)V[a-f_bLcWUJ8_>VdcG[A)_c;A,Lce&J5b4@;8MFV3:^+C/>BV
@+P3K[CW&9T^T:X5].3+)6P1?VOa+LCJC(B<84.3/+9WF0g\gY-AcYCA@\B]B:=J
6PJR/1VMIG#Me-7H/NNHQ,S#Y4;H^5#[?0U6Bb1e#VcOaJ5K<+8B7gc6K2I-N@[-
e=P5U8\bdBe&@4LA[[&K3eA]U82/SY.3b.XKW#\PC]=L?&=H0YDP097=Z^@P0a#[
ZIa=C@b4P(>,;=JH@@6+GN[E?_@.<X8UH#&T,FPC-3dG(2.Sf\@O[//_.Bg6\F3;
^@I_cde/YBK/C.<@\PAX@G]X@0fL57=JN6>9+(C:?=<Feb_aLHB.\5H;6ZO=G5[V
dYSJ;MG<7HJ/^(5BbU4FU-L:0PO#=?fHBP)7^@?fP@cF5G9#V9D.47HIM<:dD;^N
49@cYcA)45a7_ZN;)/g[R>0]J[)P6G=J,A=;7WBT;LRFQQ_-97?-;\T^&;O&)c3M
5W+4gQBVMaEP;VcO@K6Z;eE7Z=Bd710#?@FK;+6AGZC\4f1eA6M7XE<a#c954+4A
FfIV>UW.L06CH:/;N@P9ZR^d&1Z8H)798WBEJZF^f&3B@+0[,JeP&UWb&_ReF=)(
=KC?NK\26^,+2ZE2bXRW>4180,8,66B[_>,SFB96,?#e5WC/-J_C/I+&)N3)=_9:
a&GBb42_11IG&>ef&6Y(dFRKdXVI/_EVF#aAfZO.E/T9,L::]EeZ_A,RMg[;<P7T
A84&cSg/V=a3L25Fb9>C);f=T;.L;RSfbNWT;<L@</<.@=&VNQ-R;gJfN>=H7#9c
e]dTa,@DGO34,\].M=GR:_V6Q5MAd7Cc\8_>PK?VEU1c)[16Y,Md;:]ZVPg,/OaO
Ag<P\9A1TZ.^[[NANQFGPb39J)=XG1J9L>;W(OP=CC)(f&FP+3Fa&@8A+XgA)DZK
BF0#&FPY>=WY.\AbDIH+4<V#EV8_a.VO5[:>1:=Vf-753&/cfHg6F&O[7R<D&,Ca
A.,M;SH1ND2Z.SMf4)J47)??Q&(AJ(fAU>-/L8O&[CgE&Q]]T?bTB]4R<K2G?2R>
J(6P^./V+52\QYe\JLf9S5U<KE3DgbL\aJ,X-6bCcUB<A@QAA8,./6\59.\UMP0,
>8f)=<d6G<R86[2aZ+Sg[06(,C(<?^GVLUeMAB=Gg.G4W?FW)1JC[Z&+(:D4dCT9
a,.ME?Za;\dR;c7EF7\C33<<JR[bPf;J@7NYA(,Y2HMB8CVW^8T09GBbc\a3YDdQ
+eYMe[OZ+GCc,)@+g1SdcTN+\E7K2#5,ScPA#I]4-?OV:B9C/#)B(7YfQYYPedWU
SV+]X]T:)e85NIY6>Z?05=Y176U5MQU0/<W#(d\a>>eI&Q>;Eg<7BQPI65HeDJN/
JPZ#PMMLTGS[?c&9N:LRV/<EZ:de&JGTZDV&FGIPTH5.H6<X,+#=C&\G>I+Zf&D>
XIE7fJ5N[C\3QC4R)4/#d82,Z^RP)VeWF>2HFG;3RFKLN1RBEM.;b?Sfa@-d=&C9
f#5#3_I61QE9:F.&CO1g2eK0B7I/BZH921LD(PGK&ebGRAUc24f-3./)G;X8L_:N
K-e]I(Q?^)Ua<=)2eR77>1BaJgSUdI/e5=--P-d,TLAL;(<D?3]Rb;1]Z-B2U#T+
.3.BH4b)HEGCe1T5FSbfg+_KS,)40Z-^N7Ga#dXV;,Sfc?^<ZA-F>BH5.L^8b9I,
WLB6?=e;g11]#]?@C;4=c?_GSf_/C&S=A?Q843_fU)a,:,bDC2FD<\8BYd-4LXLX
f=MBT:(ESD3<=92fDdeKE<C<EIL[H(0;6-(]:J[<agNQ:Ke&>?<3T>6P->LB5<</
>@-)@<\R[<7;7egb^+dLM7]+U#HB@^M,49R?e99G<Pe=0H[ITRHcKOLWAVEN)^S4
>E@7L)EO[BTGM:-eXFY8g3=PbFb1]HJY.G@C3H#2N?O;1+R3a+-f6YO>TEaUF=1W
#\6PTR,F1F[Q5AQ?^=?4Q5#M-d\g[--@>2aLN.JH[\MB_4ZJ9GNg61#.V8]-/@Pf
DDFbA\ZcO)?Q[9NFW5H[Y)6WAcRJD/4YRaG63A9E6e7@9,#T:dBG4(Eb&/P-eT3^
5E##ggQ^7ZID[N,a<d4Y]:M#A#U4I&7CX/J6M=[2PIC.?dH9P&3c61]=e(GV:c]+
-YaQ-9<4DR(P@Mb(?^E+#7G?]M?UYMWK6&gF(MX4JPRZ)V(+-W@:ZFAKBI-S2/74
&??/EaP>Xb9FX04SKR9SPFK6A_eY\VR#L1L.]SFa9TY^V5_JP]MX:\>K61=MY[Dg
2]SLecO2&-689SdF9,M&VfcYKBQg<HOT;XHWY\B(eDg2V6Td]Ha@A;GIN+^:^.&\
Q&9+.]#.:E7A.dZ]@2=1H<]80H3>@]UFF@&&[>aH]3J3]8F)[^CaYEa&+&BD32GN
)=<a/bFB9?CK16b-LE@9FPU&Td91d^J@(5YTZ1f(40;.T]GO[9AD]_H>>4(6+^EF
@f-NfC639KVG4Xa[Z)SI5WTW+/+5+9FVeg=ZCIZ)#R1aQT&)LXD:9aGF(?>e>eeO
K4AF]IA92,@g=b^,631gT#TVAABMf6L>8DIQODZX5)X)>e,6]S:TH(bdd>V3TbJ@
dD<X(02\#&_Z6GO.8Q-S)UFe4F\N(e;4\L9H;VHV_QS#OF4#TOD<bHYRLGAYN6b/
DU8R>bbA^BY.K-IS@g5gD?25]>cZ1cR.Z(dP+I)(a=GgM+9\^2BOC6KO-T:C_SIG
>/G?L+0I_b9f+264]a>72L]VI52E3>>G_EQK1^^b=PP3;MC9,b1V&Y8IG&Ua+MMA
U=B2_74K;.X9:FZZ5[LO)dHD;6(=IdI]CUJ_T_9G<+8<+8?SU;=@91bR^Z8<CM8)
]g)VZL,NeAM&,PU_@7-#X+H;](]B-F>(0[@CXeS1P4>VRgGN))@V&ZeC:N-<R,?9
M5]=C5CQcVeYH)TAfRf2c#bc1.b53JJeAbdd?CNRe2.b,<-<DLO)JDJIR2HC.N]N
NC]<[>b,F(WQP[Oe)MJ8<M6C5Z(OcV\,H^Wee&24EM_+>Dc;^P08UJ3_J>VFC1G)
6G;5Bf6_=F14f+LKQ8_V60MV6d;]&Z<V.36RI=(WD_R.(GWT_@eY]d.G^Cb+OCJA
,?L[7N[,A1HcfU<30.WARQEQ(X)B70@EFaNJ]KP4eG9FUdB\X->TW^UF_F^=DcC.
aa:E=PgH^P^8]XbT.Y++8P&D5Q-BO(;Mg]3SY#f9W;Q#Z1+aCA650U?9S_)GX3^+
C>[#A27TRYDX8bNK/43X2./bYa@G98YJ52Qg4U9>^bBH(f4XRfgC6V(3T7.G2M(M
LQ(&(6(T:g5:_,R&UFTb.WWeCXJ&b[-;U/WG([VbO#E&V#&5?_d]bRPG^TYZGG)3
]ZWcPS&XEK@.PUS@eZ)+EB>8-/U<:U:(DAGQ)T9f#c5FPRa;f:\><FZ+&VHHdd:I
^V9>3&2O,OKe/0TS,##B_.ffQ>,;e)d4@FN4NPC^&Qg[-CUPc>BNE<P]\.:[_B><
NI_a:)M6NSGb0#,\(IIB,7IEAB60PVBMAA5DMI8d5Yg35g??bF-TfVZ]5M>W&6#Y
MS/AK2ES0?^a@+GZB.N#IH0fB,)BgEd77KK=e4;89#/[S.7CZFD_5cR:PaABLUIQ
#RVg.?We.7P,-a8E=MIF&N=gc9PUE6f2?<G12Sg^F)fd,CeCWHdV[>X(.HA^U&KP
:0&5I[Of+T?Q[<6,]-.Md5[TP9YeM:Vb\.MX>L(E0CdF)S_(<NNX5Z2g^SIRRSRS
MAfM#J]#\;WD&.S(\f5YC@6<dPH/^&:b1OPb1Hg[X,&,V+fBJ4PO1a_beP9U.d=4
^1c,#UPe5K2?KRF/(H:]136Z8)c)IM+6(6:RG3,(cY/B^9]DD4O_eEaf0(QN52JH
],2-I5EV)1?GFXe8e\f&FOQS<TI)2;XQXc6)2H5@:)8AJQ+bAB-;b)K]8UX\[U?U
79].D=8c\(gU2N9V]PQ27<@a0G+O]ZK20(aWIe)gLLM.eH09eZT4YW17A36L:O?[
/Y9)S^EGBN<Ec_H&=G8W<,?69]+KPb<Z@Vea/(#.>,V7.;=BMARI+f2#cGXM;EMH
,SISb0Gb6Vg]_?;W#..KEGUR2?57Haa^[df#1MdX)BC0F+37<[]F+=B_2+,2a).R
L&V2?TZ+U[YL+,W0F9LFVO+QI@&eB5#b7I:15@BYb^N-U@SCY3EZXR3-U9RX70(<
GVR0,T)R,CZWY0.A7N#dSJ,W=I1ca-7_F6)ea_4&.G/f66QC-ZYQQ((,]P7Wb^c?
R.3:?<XSPFA#T3^7WeT2A5[40=K]>g)V0,,70b;).LHULX.66e58>d>MP9)_OD[<
LPQTa^/)La+9O-6Q)Y]A>]Mc17;c&)P97fYAU+BaFe\P+T#1,0245M4[\7ACJ;Wf
WMJdME7.AV0N(2#c8X@6\E[g.GReSK#)@4W=S3.JO+c]#f6:+]A?,KMN?A0S=@L4
U/;]GP@_Q_GbZV/HO#]+6_;UQ/eFEGSW46E0XO85_:H]RY30CFJf/]_XG,<a3=/2
DD\L(fXR]P&Y00d];-+/A:\d/1aAD/b=f=O_)LX0IXDaEL:L?;S)QCJOJ:NW<,BN
@g<\Ff]@]^SD(LV=VA/a>cYW\_.CbFdB@7PdE-SRf@_ZPW#,WeT(9=bEIBPeB]Ke
X>?,L^,f23NaO00263&UW1gQaE&^3be_g63.F3^aR9eZc&7\PG\4[0-0Y>V-6f3Z
H;N0N9\c4XY7_NVP5__R8/0(F_b6)TETcbK]BLI[2T)?697dT-YdS\g1.b.Rb]3S
+8FfRDa+.&^c_3A-Y9FF2(H4\bH:O<AZ1d2);VV?O\@VWC.V>J5g@I9B<?OQN+X^
&TU587Ae;RCYf&8<?..VI\0SPTeYT;G.a;U.c.<a\c>J+H+-TF550FA<U[GG5OYE
EC6-[G#(/?DZ]Q8.>F<cOUVV/S]#BcBe(&M?NVgK/M)_-F)#-H;_>,BIXPHN=9J,
Q?Z)G)Z)Rf4N0S8G(C=XFeIgH]O2YA6K3c\#.2eYdYZ+(,?^AYQSE5;<c>S4J(6C
T8<&8aC[\G:I8[Z0W?;EJ41#AdD<)]M&=(,I>U;gGRc=<K6e(ED92S0UF>\(^&ZO
[.OePA(#^5BLLW=DPWXSAaP;U&NSZgdG8cGXX&2EL8VQTM^LZ2+T\YUBeYR4bJD)
&F/BT-4V-3J2,ENI^,(O68H,4d1FVgI(-(a5:5RZ3]AE,L?gAfB)I2NXNb#X^WUC
Bba0;^e+&)U8]/#,AO#e@JA#Z_+FI-e8?eTK3.<f2<SC[F8Q-08E4DdS-;-KLEee
RANDc=X523P5?g/@bIL@(KBd[b&=&ZYFbHT>8RNREHOEYA_SJ_M&cNH-fC\dJ<)R
7C3VGO62g-eL-aB<Hfac/[V@Qa&Ke)Y:DU)1Ta5[,#@Kf@C-ILDTH;[]ZQ2/YOEC
(IV)EQfH<M=)^)1T.HZcfG3ZYb_&SXH>[=HgH5ce5Bc[KdT_N))VV??J56)6YBb#
f:EKfUZEgJg6UFKg#.51TLf)8<D#GG_@\(fe;+,)<AD5UYW.eE#LA@[a\&EA-Lc=
F3^>/PFa==J-=T5>#d[LFZb5)1J4R>c8adF13<fa#A\Hga85.<>C6E337+>:0\?P
_-^\e,FH(DWT&6:O91U3V:&1AW4O<=K]HAT;gFFX6MV>1/YHMT(S4O4\UMe3eE9]
.,4Z&,;aM@7@4Rgd<L&,c\KMS4#18)a2D15PaDN-,4GCd7X,1EN,aZL5Y\;?GUf8
\;]-T-MX>U2I1:,FP)-bdU+<.WIL_a?EPHV^4,#:&#ICa4Q[F<c]:<N]?9/G;_P-
4&-MMdB#1B;4PY-<dCaY_V/[GW9X_cG^A>;LI#XCcI&RAFP)CBdX87BgQ&MQ4CH-
GU8PQ-SSQcLUf]Z=<:/F)HfSKHa4H5Y6dWW2;<4_[.e,S6?c=ER43#L@X<A+28&B
-6KZ-VI18MWD3;aBg@KH3X>QCeaZ6(5g3>IdRTS]bMR^8:M:(X,b^@):T>9FggZU
)R^-9099G(&+K:KA<H>RFWgPff(7DP\)K&YK(Q.b:7@R))4a.C:1S_Tf(PL2QF6S
,#XQbP?7LTcO_^bHI00V-PdG)&abAL+?M[X,N>@<KBCZ:ea90(^^7)K>_Qf_XS52
2e\QB<0/cKc_ZabfVe2d,RBJ]8&RA6M;:#^J5&T((<URc#0)D_B>=Q]@d?gQ:CIV
,D&ZM8U1K>YFJN]Lb:SA^P(C_4?#\,aOW0(,fG]C/.RO6^@]V6?fWf[6JbQE:\=+
OCB)9bS<b9f+3:faF=cfBKFP_>&3Zae=dM4A4>6<NgVL<[PMTc8FE+f,,E6Z9G?[
KgV6AF#[V4R&)7&Q]Fg<eU-9g@+9)K_)Ig#)EB3bC&IVI4cNU;&C/:I/NE7eYMeZ
WUBGb0)+K]OS\NNN;M0\\,V83e[LG4T(#+DN;INaC2-B145Kd,<>3@+6FbV40N6+
=&JY+&+08TL8;>bL..?+2c[)=JN\,23[B?bH5/bEEH;gC050L+c/WB>S<J-9PNgV
F<2:VSJ_=D)b9<.@XCOXH(SE/5MeCZfTUdSGF7[1XVO,Pb\;:B\Z7Dd_5>1?)B1U
MX/,PE5=c5^-XQB/<D-@]C7GH_#=,O0_C;6-a)=<bKC]E&YP-PM55bEMBdW3>bNC
J1WeCKL\9<dCNI(P#IDHL(T>9?+BUD-=gTb^KA.;J@gVK#eC,Fe/E,9M/DN4YbG@
^U/GFIaQ(/9T-E6CY:25^YMF((b?^1/JZ+-AA6dP2J5O,QfHg46OaScZ6O]FKa,D
@;_UeF@I;[NN#@DSbeMUa[M3HU/93&>PU&1K_RS;OcDYP6\[F3FcBCP9dQX,A-ST
:(70T;c@<PK[\WUK\:/,QM_:CFR[A-aF7OeJ5ND<)(>Je(IR>1)I,&MXIR4KBb1G
d239b>,]8KR3)_2Q>I6bfJ-,</+QW>6GG0^LW2MG[PC;f0PVZ>&Ja/?6ef;\V[^=
SNV<?X,N;>a]FW+2]S/TJ,LDZH/U@640HO>af#MY8<cY3\_;^7fH=L6+>E3=^1(g
^PeB4cXZGd7&8?\)RL8<O)D-_3@K=[D?TMf89=RTN<@Y-FfJ]^Z.Zc\g1G<(@^=K
).8bA[BNSUGVTg>H>a74C3/S&YJ4EQG&cTaLWCQ3G^M8N,4c&S>eIBZ46Y0YN,W^
>DT(Q\g94_M&eCS0agF/?&U[?6[#(9DO(D\G=WY[KLZIK>cFdPKg6@YdHC3>I[J<
RKE^)T<\<P]-Oa.bf;-IQ2)1cY_F1b:Z1B+P(-O&=QaH4(\<&H?->-[E-+V>=DI5
LeET9X?NNP;2)dL&/.T:6Vg1CRV\0E[B(=<+7c+f\Ba#37(&B4;P3f0\1Od:#TU?
<D+)PNP;BYWBC9_c#=F<XTgLZdS+RUc-DQ1H(4e;4QF=R(Z;VJ)A=CTE6_Zc@cAH
->(LIJJ#<cd-5WRe<KeB9)FMOF1f,_.>1-Wg6cY(5/O7^GET9(D#?2314^X?^(/Q
XXI;DLIK(cV\^b8<TcL?_RUP#BaAY9+]bgD[<92^AM,@0B.,JY]eN<LDQ8:a0^I:
SMIE5aS#S[/F?eYUZMXa+IR]dQT<gCA>KQLe.+?.QT.bJ(1LW(Sc+,QKQ=(,@6+,
9;[&C4>0H(fM&:.c/ONeX8]1EVV5.f#J]M1^M2X\W2SGHL6UQ\d;:AbcE9.)RQBM
)99C.d+fO7JeXK6T;6Y^1ROYSYG.cJQWa8V)X)>LJG=c#M_^4Wda1&df[FIg-bbJ
H:58:]AK;@][U@R3(aXEa^d<Gc>2f8)R3;5/fWe)TNA37<dFG;G)P/aQ>ZOYQS,D
I\U6T1M9.@3O0TJ>9EZU2AL@D;b91?[>K0_^Q]TIATc&Q]XP]S6<-NO-b36E?b-K
8FCDc6)C00d?^:(4<76GOQfE)WZUQE/I/&gdGZC_9A3CSPEV#<=Bg/S&a_cHB<9/
P+-7=VA#e5+Fd4M&)Te#[[1_NL1,W3TCJY27<;EdeQ^7Q=XP]H/dBKPPYV+O0Y0_
[&7Ve+_Q==(9c:7H1V:YYgYGeC/)GP=?F:P;<8fgP7JK5Z&034I&e<==NHdEK_S\
<QZR[\6Yf9J9A:JM0N\KGB40=bW9G?ZV,^R.(QgYSA8+aS^0fO>KRP:@R?:<Ca&:
N<f760EWZ<]2<_7(7a=/)[PHNd5>J7M#I=Rg=@EM-=:LH5\GL52X_CPfHG6HeaSO
FBJ8AR?Q=4EV?YHf[C\H?0=B8\:;3G+[,U;4#T#IFH3X8K>Q-(#IY+MIbU_XI5+[
=(<?^=QT60I9>(D,U&?O62?#HPE1b^.Z0?O_ad3,eO(/PL;+9_.2V53&eST0;N+C
GSZ9KM+dIcQDFf.:IL\W8JfV>?@\9@UN<JXJ0XA,(SD1eBRfSb6d?4U8C)>UPZPB
?^+46\:W^0]P_-F;b=FO>Zbc=E4+6-<eY]9+g5aL^DBc9C+9#]PX4M7&ZdQO>80:
&5N=^[./_3Ee-VR/&6+YZE_>+8#2;0Y;=EAIA85^X:.B@/PGIMY@PdbC8(c>MZG&
cLRS&G/<V8(/CDMIadU5^a?_JC9c=L)ab-TKWC+^@\6^6XEg43?]e>&D9F-+BdO_
[E[9.0TR)4:Y736WRB9d@JJ7Vadf)b-:eNb5&(;b#J#T:9#J2Q<MI@3f+]d+GcNb
6OB8K@R7gVVMV]1fZg/g=)F(BW#VQSS\6&Ib[>(^bRaa[./AO7(ZWW.O\+Cf[&P/
6(#UA+?VLg5Fb]T)P[MD)fdBSZgMG6)GVT+[eH]WcAWRa9PWZ>(]D1B46X[.+Y0O
/II2b[;.d@U7bIE:I-OQ)99^3)Cf0U-FXU@,.(X1^_N(+.QSUF0eeD9?>,0&T8@&
@R=Yb7-]P-:Q<URTPFWE,,01PUYJQKRIPKW0J#Z;@d;V\b+dDeBJ6C9IW<9DU6e#
#;4^^K0cUJ2]<HP7U[<56P=I:49(?\QAWXfTR_P;>;A&S.=PaK#<^P?N\=abVEC4
4H_HGRR4-:GE#+GHOg1CN,#/1UecfFa9[N66I/=?+U(=3UP(TB.X^)b>W81ARb;Y
V,;F8)S(H7YB/4WG,.bIT_N;NNA-6<,H]<VH3Af8Zg?J;V=MEXfTA)V&fI(#9CT[
?cG5@8EMfDYGO[g7MB8IS(Y#;\Z=A)2-VOG0[XF2=3U3IdDI5cTPUHQC5c7N3TP[
;d-UT@(=.cZbFDc-2+NG#?J))>YGTO>@+U2.bE/C8P5@)S-I:.fTf)S+fY77O,+#
AKT>?9:&+GA4P7>(]SDXYPJ_A0:44_JS#3DK3fCb,&8#G^R)TZV+R#,V/Z?Z#49^
JNMO<SQ3,S91eRX49;Yd9IMB2bDBLJZY9Q8YH?9O&Z;5H(-0N+F^-W6=3cNJE1G(
O1]EXS##F(K]ZcQUBJ27AS@1LO8AcgDP=c7#5:I81f##\6;1DW_0)UMb+TB4[9EO
WYE;08)4D7:J&bA1;O?ML+9aV:+V?+R63B0bg660;K.NE+U9??3GT(EU4>15:DVA
FbE<Lb(&)(EMc<XU7<Xe?2^\ZE)[:/_2B/Q]PFg1TXYE6PZe.bEPa@cRaLS&,5_5
2^VJ/9;Y;L;e=F5bB#cF+.K\^aeS58YbJDR:XCF:H]cA>bb@\.(8\gIDYMcH13<0
)&Ac@Q.N:SK<@C6A:P16[@LY^Tef@>9[.;071];+.O&Jf(H4KE<<]XWgAE(Q4\KV
23:=6L,F=JZI&6MKcOd.6C8Q0)CB<>I;Z[@A[b5T=,(FY@^@SgSe4YPN]aU_6[IN
Ac3H_NcK?Y3GY#2P0cOU-PY@b4)fEb8bFHN:03-NA6SK))+-9]AZUGX9DbU9ZSHC
LGKbGL7(D+=df=2+TI1XL,d[>4_9]E,f4g-LM[\E:R9SKf>8)M[#J(d>WbE>0H.V
\F?;VJ]ST9UdE:+<bQ.2_)g=\gFG+a:)+X5.B\XB&GaJU9UI72WM,6]bCT-QS-.>
MB2fKP43#DG+IPWJ>58:/^UJdV5<dC3_5/DV4>&WIWS#=BH8,;>:I@WL;JZ]],]<
<PF&:e@T^[V-#/IJJMdFRJY@+U_5d,JeQ#N8AP?\>0,,&1;_Q3S791H(=DB8H8/F
T::FH:85LHY9Hf(&,@&4E-#26.?CF@?C-(V5Q4bOLXGE[=AC.25++aM?(TF_/Xf^
f,9G=DL7D0^<X4e1AZHMbC8MY9V-[7-PH:D5eE5c:VGS632\2ZU9CK+fTA9KJ1)J
GI??B[846[,_&WG.N]ZLUcH#U65JUM,eY.MVd;=D]7]X1A/)V&NM=J2YH&Y@TJ.\
[JPTO+JNL[b4:Ze\\K,N\aE&Vc+b&M?F+U13X9d4.^K(g-e/\@=cZGNcdD9,]ESS
PgV<d:_75SVHT07L?6Y[JY03KTI?e</LbJ>,;C[9U3W=bRGYBZ=(JBPdcCK:<I\@
_NN_6:;8^_#-]a3+=-T=g9?0C1(MX\5>Ra\ER.[YeLB7/J8IB9P+XM9-3:gBJFO>
>K43L(NUbMFDC71e3RO2aT9ccY-4-9fSM+D2V;8^.2V7Z>K9(C@1QATK4]]07?:e
ORJ#[Xa<7<B@FOMH^3AMX1(a1&UPSXYRd,cNMZUPM[5JR-IO@f>>8E+JfX-Lb.@F
UAe0@BKI4<ALLML9AOQaFZH#f)6FEB_/B5([O.cE44P]+?e;A=EWNfXW^NNNI6L(
0:fQK&@5QK&)cC01aeE3]GG4F<f7@7G?.GF2#A@]AL5CO,3KKLPJa77JXaG>@CBM
d9Vfc9JbM45>X1]N\M_GGVPBdQY,d+DOa^\L_.K.33&)A>T>+aYL=:;82Z=fTJ+U
:a@\ZSFe;8Q[f.Vbe+C:3Y1:8-L\ZXR#&&M<@P^&<YCf0ac>/C\fcRG7H@DM2:&_
HTV#I74-@Kc#G<N#OD24EDJYX0JaO+MI<U2R]]I<:b0Jb-64MS3J^NJ/X4Ng#]ed
BJ7=#T5Od(#^NbRe\+Nd5PQgOaTd#FJ(DA,g1?Q)0S?9^g#f[(9O+6cJ969cICO<
g<7)Q\WOdP;J/P+c>7b]<5R;UK5dHGCBE^W[/eVTeSRNfA9H42^NPg4:6Lg?I7#7
:(a1aXDITAI089e]-HJ[;AR]-N:CBOC2W7b/&SN;EO4+-S[H-^#,F_2<0Q;9HHV+
G00^V::\,]VZ\0[.Jd,FaY&\eCa/+d[^A5UKZ\W)SN[NK2=;<:27961[F;+[;7,c
Q&M)+JS(+2eZ/dWDYab:TEVbZPPd:;S:_B8.MIY4b;7-S+4)_7PJ,OER(e??,.RS
J)e(_-8@/400/MT=L/1I\bDW[SFIB(e\R@U@=GN,/FDcLeA7bCE:gDd=Uc]e2>ZC
LVO/e>RdQ@7O-,K8BRaA)e?]78e:+JQPE>-EV>T:ACe4U5=\0^+&cRXKYM_2(IVU
120,M_Fd>;E64A5+]^7bbCW:[]WN)6U=62EVRa4+gd=CG=b678g+;@D;&0e7aTOY
762+bd1MdCba1D=a&.>=a+-F=HdE_&6QO+WT<QdRA_eV87&c\V4BC=f5eK9ZDZeK
SKX?=><2<(7J#)434#&-RM?_-^Xef+W:-WdGdRFG+]Mb2-15RI:./5.9bN/?\,UP
L<c50a1@dB3/XYNW;fLGL[4@7?(d];c15[4-PV:.PY.3(59/eBQYN01&@:X_\^Re
C_YfT90]G\?dO+HMU=8c:6:CZE>WEK?f=3^(TcE=bFe\=Y0GeXcIgA[bJ1D9;=_P
/414O((dH4PCOfH,D1HV_C&\H^6.(e-AEHfJQDV86^gXRc;=3fPFK<U/6)6J+b?2
[#7R2RDNM-NFY5<b:B)QB<MHN5Z?eM\];34QE6e<++#,dYF6@d;?T&-T.>fa\fP?
:#a/C11&90gR:[UN3A[)K_U2XP.28-&<?P+FEA7K=:H-cM1&WdJ/V:S.U=2-_V^:
dS+Y;MFK-<(E?WJNE-IM.0=44F^Y1c-85E=,.K>/T5g/c8CBSW3.Q(L=+KbdBBYU
G,&-VUc95cdT=I<BG.-\W?RCYHY@-4S(S=+:^SgWO:]M&1WL8VD-d;5(3_1eJeT=
OEQF775De/bT-$
`endprotected


`endif // GUARD_SVT_TIMER_SV
