//=======================================================================
// COPYRIGHT (C) 2008-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_NOTIFY_SV
`define GUARD_SVT_NOTIFY_SV

/**
 * This macro can be used to configure a basic notification, independent of the
 * base technology.
 */
`define SVT_NOTIFY_CONFIGURE(methodname,stateclass,notifyname,notifykind) \
  if (stateclass.notifyname == 0) begin \
    stateclass.notifyname = stateclass.notify.configure(, notifykind); \
  end else begin \
    `svt_fatal(`SVT_DATA_UTIL_ARG_TO_STRING(methodname), $sformatf("Attempted to configure notify '%0s' twice. Unable to continue.", `SVT_DATA_UTIL_ARG_TO_STRING(notifyname))); \
  end

`ifdef SVT_VMM_TECHNOLOGY
`define SVT_NOTIFY_BASE_TYPE vmm_notify
`else
`define SVT_NOTIFY_BASE_TYPE svt_notify
`endif

// =============================================================================
/**
 * Base class for a shared notification service that may be needed by some
 * protocol suites.  An example of where this may be used would be in
 * a layered protocol, where timing information between the protocol layers
 * needs to be communicated.
 */
`ifdef SVT_VMM_TECHNOLOGY
class svt_notify extends vmm_notify;
`else
class svt_notify;
`endif

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

`ifndef SVT_VMM_TECHNOLOGY
   /**
    * Enum used to provide compatibility layer for supporting vmm_notify notify types in UVM/OVM.
    */
   typedef enum int {ONE_SHOT = 2,
                     BLAST    = 3,
                     ON_OFF   = 5
                     } sync_e;

   /**
    * Enum used to provide compatibility layer for supporting vmm_notify reset types in UVM/OVM.
    */
   typedef enum bit {SOFT,
                     HARD} reset_e;
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

`ifndef SVT_VMM_TECHNOLOGY
  /** SVT message macros route messages through this reference */
  `SVT_XVM(report_object) reporter;
`endif

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /**
   * Array used to map from notification string to the associated notify ID.
   */
  local int notification_map[string];

//svt_vipdk_exclude
  local int notification_associated_skip_file[int];
  local int notification_skip_next[int];

//svt_vipdk_end_exclude
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * The event pool that provides and manages the actual UVM/OVM events.
   */
  local `SVT_XVM(event_pool) event_pool = null;

  /**
   * Array which can be used to VMM style sync events to UVM/OVM 'wait' calls.
   */
  local sync_e sync_map[int];

  /**
   * Variable used to support automatic generation of unique notification IDs.
   * Initialized to 1_000_000 reserving all prior IDs for use by client.
   */
   local int last_notification_id = 1000000;
`endif

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_notify class, passing the
   * appropriate argument values to the <b>vmm_notify</b> parent class.
   *
   * @param log An vmm_log object reference used to replace the default internal
   * logger. The class extension that calls super.new() should pass a reference
   * to its own <i>static</i> log instance.
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
   */
  extern function new(vmm_log log, string suite_name);
`else
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_notify class.
   *
   * @param reporter Reporter object to route messages through.
   * 
   * @param suite_name Passed in to identify the model suite.
   * 
   * @param event_pool
   */
  extern function new(`SVT_XVM(report_object) reporter, string suite_name, `SVT_XVM(event_pool) event_pool = null);
`endif

//svt_vcs_lic_vip_protect
`protected
b[,ASHL)Y9+[Z+)M:M48:,Y(Y5:9^5QR-?-<:Zb8:EM]?3R9aTcP1(HMc:,XDK/I
.,Rc/3Q/P<)I?bb.bO0EY:/C@]1/e,1=g6.Y@DLT0)AdN,Q96e_NeIJ9-T\4LVTF
SaP\<Kd3L()R)Q,+NOCA3ZEe+GTR5/N56U;TNOI12[^N4(1=B@d?I+2d(<]<L(B/
4>=,I1GKB.RM0/=K;/X2d9&TY[0^QC@Z,3fRJd]OD-D358E;a;bOS,eN-,09cI50
OU9R0cRQDgA3;<L11AZ2_:fBOeb.gP<bM;a/:@UIg9Ta9[:4W==FS3bJ>Z-OU:2B
.)32c<ZLNK5,PSLJcJ>:AG^/O4c;=8[5S<484)6NO5AZ/(UAFa(AWP0TGT_(,=S6
aYBW,^>-XJ&>PRF>c?NNE[D/(cNG&SR;-?;Ga>:;d?UTV>C(WN(4HFOeDK.PYe3@
/>g,>53?IE9<K9_H)d=P1)TSD&XB9UU_MWHQNdXC=bENe#K5TTD#&:C.:AP]A^G<
+:H:^MccI)09NNS<&c<I+GgLdHRD9-?1UCTD0QS7cX42BMYO=BNOT8fK>aP^6:7R
/FbQgT^161F5Tgdb3@GZMHV>:^2G3LBbVfB=(6W+&Y2WD69B63NH-QNeGDBe#=8H
#\f&fIA/TO#:LSVRbXO\@bW\_FbT7+aP7:7Mf>X;T=.CB+9\B[]JOACIEDe[0e)A
@SBG7W0X<(@]KK4[4ZZ1OeY+Q(UKZ3)gY>Q5E2W)GY:N9D<ZF,X2O?-_G,QQ;>TC
UX,[Q_FBJGLaJ0E6OC9@^<C^QbgKBGFXbPLBT@D,R#c^eP46>5.AJ;f5L0f2Ka>N
6YK4KfG20._8(feL+U,^K?AA96-8^(T4#PGO<)5CH^(T)9deBV1PX0gY)[SGe;F_
Q=2A.Wa#0BS>7P0Q-aSc]gT@SPE2b^<56CTC-((\^&fHK0K\:b#f7<Fd5@ZL6KN9
/.9C+Y<58V<>c,;LC2&EL3ef;;13Hd[@d?-I;@VBN_E^R[F2bDQbS(KIg]V#AM13
HA=^CEGd<.b3DH:gJLf]1HO&Y52<S14J)=&ZJd^WRT2^E$
`endprotected


`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Method used to configure a notification in the style associated with VMM.
   * Used to provide VMM style notification capabilities in UVM/OVM.
   */
  extern virtual function int configure(int notification_id = -1, sync_e sync = ONE_SHOT);

  //----------------------------------------------------------------------------
  /**
   * Method used to configure a notification in the style associated with VMM,
   * while associating the notification to a specific UVM/OVM event. Used to provide
   * VMM style notification capabilities in UVM/OVM, tied to well known specific UVM/OVM
   * events.
   */
  extern virtual function int configure_event_notify(int notification_id = -1, sync_e sync = ONE_SHOT, `SVT_XVM(event) xvm_ev = null);

  //----------------------------------------------------------------------------
  /**
   * Method used to check whether the indicated notification has been configured.
   */
  extern virtual function int is_configured(int notification_id);

  //----------------------------------------------------------------------------
  /**
   * Method used to identify whether the indification notification is currently on.
   */
  extern virtual function bit is_on(int notification_id);

  //----------------------------------------------------------------------------
  /**
   * Method used to wait for the indicate notification to go to OFF.
   */
  extern virtual task wait_for_off(int notification_id);

  //----------------------------------------------------------------------------
  /**
   * Method used to get the `SVT_XVM(object) associated with the indicated notification.
   */
   extern virtual function `SVT_DATA_BASE_TYPE status(int notification_id);

  //----------------------------------------------------------------------------
  /**
   * Method used to trigger a notification event.
   */
  extern virtual function void indicate(int notification_id,
                           `SVT_XVM(object) status = null);

  //----------------------------------------------------------------------------
  /**
   * Method used to reset an edge event.
   */
  extern virtual function void reset(int notification_id = -1, reset_e rst_typ = HARD);
`endif

  //----------------------------------------------------------------------------
  /**
   * Method used to configure a notification and to establish a string identifier
   * which can be used to obtain the numeric identifier for the notification.
   */
  extern virtual function int configure_named_notify( string name, int notification_id = -1, sync_e sync = ONE_SHOT, int skip_file = 0);

  //----------------------------------------------------------------------------
  /**
   * Gets the notification Id associated with the indicated name, as specified
   * via a previous call to configure_named_notify.
   *
   * @param name Name associated with the notification.
   *
   * @return Notification ID which can be used to access the named notification.
   */
  extern virtual function int get_notification_id(string name);

  //----------------------------------------------------------------------------
  /**
   * Gets the name associated with the indicated notification ID, as specified
   * via a previous call to configure_named_notify.
   *
   * @param notification_id ID associated with the notification.
   *
   * @return Notification name which has been specified.
   */
  extern virtual function string get_notification_name(int notification_id);

//svt_vipdk_exclude
  //----------------------------------------------------------------------------
  /**
   * Internal method used to log notifications.
   */
  extern function void log_to_logger(int log_file_id, bit notifications_described, svt_logger logger);

  //----------------------------------------------------------------------------
  /**
   * Internal method used to log notifications.
   */
  extern function void mcd_skip_next(int notification_id, int log_file_id);

//svt_vipdk_end_exclude
  // ---------------------------------------------------------------------------
endclass

//svt_vcs_lic_vip_protect
`protected
U/?V[a#Q]]:H,YSB_)/QB<D)5_>F)C,fT(>&cW#038[&Wa3CA<,G4(BIA>DO>(W+
,?1KQ99Q5Gf-b688YUgG>5KHg@N-JIbA>OH;P[WD,E[VXU&5<YOe_<M6QS9(c:R#
[/67/]V.d=2KUFR#AF6V:f9DK/USGO5bfTfMG;)LG@=K4\3;0M8R/?caR;2C1eXC
\WLCKfe>)C779LUY.gJ@1LDOM9VgJL-70f7NJFGV0#gF4@AQ&]S^Q0f>FL;-.=9M
0BXYf))#RU76dVBJ@C.6<BLPS^W#N^R;3MBNB>L&FTQ[]>?>7(eD#Z/3G(MUI^U5
b.-4Y7E]KCDff2M7/U\=?-_@f_\MP,U3&0MUaHTb/GfH<#Q:J4d5SL,O(Pf&.?X)
7FRQeTQb]^&GO,V,dd5_Wg^KS2XY,V+cILdP4]+f#F21HVIOQL[29YPB-@^H:5P>
)6V=6#/Z)-?a(gAZDUcg_1L7G\/9>YUM;]Nd;M7#]f;X[+bUde.)J\XH86-fQZ,I
YPE04C^N)HE[I<(&]^:GRbGFP0_f6Z6/7/^K(dL,&YQ/M]S>)]3L.LJ7[>Q_G285
6S#V;HdSWRe;LJDVKA-a)ZFM/>W&:0QbW-WONKf8E=\KM#AO_)S\>2]>4/WN>JJ6
;0DF@)0H(1Q-c:&\6JY):gf.b\0I/MZ/<?@cH+.@3+bG@;&^-YNUF?^L9@AIAB-T
+Y+(8S:SZ2dd:YabbdF(,f0X<eOC3D5IE0MOc=4D:.WP,:(2C9J;b9Ofe)<,77TJ
#)&UE0EVB_g4_[T?@C;JSK:]-8)#a=,IP,1JAc:,[NK[]D+F[CJU=;M\YQ:-1,-G
&)T-B4_#>(Tg(NXKZT2bb_15OY=b:VN8@S-1=#P>C7O:ARD8NAO:<_G/gM\92N2g
edL/[C@D(?5H=6BYe9F?_SXEgY//DGA_HK3;E_USK&FKT^U>Z>[DDG<T7GB(7A/3
WbNEBbgd.S]:HN\gECXB@UE6NT&Yf,+NBA\L.6>+97J6Abg,V,?7-<TPbY=IcC?L
;Q@NC;,V=.fRAD9]eM:SQOBbVHJH0@a;8HGIfZc>A^4OO#RTaY(KfPU749Y=8Y,f
>3,eddL;M_L#DL1U.cYSGMV[P;K&\QE\8F-/\G/DgCONa(\H1KGc/Q];0T:+MT-?
[)CX7/?(dC;d-aL>0_G,8G3H>M^.JIYPbXQO/fOg-X86JS<B(WXHPGRfW+=)H:#E
LG0)09ORa0_6b6d>NeQ)d1>b:eeT?Vb<QN1b/AYETQP+^AIVePPA>fba;&??QP,X
JN05(15@H/-aPB9JEV:d(Cgf]2)OV4HLI<dfS0/AIA,@(A>?LSJRWB4&=?a-f#ZC
;6.NDM=:Sc)@aLAJ5F\X,UEg?:f11SF@=7.,U,.TLLaFV?2J[.VLY?5O3a)BMJc&
(?[@8dc,VNR7aF^K-ILaK7/.Vc(15;_L1.;Wb;A84R)f[X3,PR_6D5dXIUR?0/6G
\Q?+@XCbP(5147;UVP7Fg:XHLZ>f-ON)Q[V)3aA(_=SGBS0IZTB7a=SDOVUEQ?[A
aZ/(?2]TVM>T3P0TgYMM=]AgXJ?\cHOG3S7UOFW1M>[<(XF:V;.[)<1^W+c?4[c^
BA_/T(?11SA/eXSa=2g?0f99RaMb(a\ePL[YRTg0gU_g0H<8HZeHX(bR70RNL\YY
.A+#_7+W(16Hb;dcBAG02,Nf-#16RSE4YBU_\8IL[=DF&T(@UdFIR,;(RQcaZ8(Z
83Jc=\MPEdY?G/(IU@:#40(U.ZVgSF<:Fd5DP(?I<:46_b8?aA9_JOg[TVK,@85I
))LB?dXP9G#OK5)2&3(dSdMV#@^L3Z?/5C(P?3Q+NFecB4\F688/TPaROEFd]ZER
5]TXR</JNUY&K6Y=19=KAeXGFEE&3=,BJO<?U:5FTHP-^/VGc_R(0Cf:?<X;,^S;
XTYe5>eT\OL4?Ce.fAGB2P@<f<gK6D[RUfB92D-UbA#-KM5S3ZG59.0?BTf[I\I<
/),@.MP3D6C^+7LPQScP<(G>&NE>CE)#?X@KE[PbB)/3D2=ZTNJE-B86^QJ3R_L+
dI>2.e1^-@V[gP]WW96Qe/T#g.;G8SgcA:<W;+>=8,0c1>7IO8gYa&XPDJ=eG<fC
:-B3ZJJ<2VBb1_XaP7WO>HYf;eG2dB_H^geb>V4+cF3C0EYPUVV6;++BG2A#G<L2
Yb)(X&7CM,EOK1/9gX^<XbHg?Qc#Y[F0#J0X^96M,)fb&c>Mef[1F>f[K3bRYM.L
X^^e\MU?=fC4BFW[CB0W76.?c>@+Tc97\U8[A9(N03.>T9bc&@4VDeQ4+R_MD1;[
K_UPc#(?g(K=C]RW0@FLFJe?]<85Y+YVS_bOW0DY^V[F93/J;DUfUAA,JHFXF7)7
W[a=?9DcKIPO.8J66WGZOQ^W0^_VKcf.T]7dKR]#e,.WQH#3bgZaLf:0;>JLZN.K
D/TT&(?BYWbd4QfJIG4I3[254c,\T_-OC5H;5ZHF<Cc5GPL;aa8V8UP.PB9[BecN
^4R\^bT<<C1U1TK/,8372XIGUEE:A:/CCf/1EJ]+NG:[@^(3cQ8/S>=JJGF,]eC9
>R>NbFKD,K0YbDIUIdB>C#g3N:-59<2;)FX#3Ia=?<SPW61@HY(cP[A<G.,_4579
1#_NbRTKEZdYF0#=_FB35V5G[e+_Vg\7V\KbL?d^&fCgD8Sd2^@XZReBR3OG1dfX
YTO]HcV?_?L5R9D2NEFB26JLaJT=d9;VdKPb=C1@?M@G0HQGf0#_0.6HT79&JB4]
G0KL1Q-dcCK?QRE=.:(O^?]:NNIV[Zg)+Cg1cC7E-5L&9I4&eAW_bd[S3a9LW[1I
AHZf+,]>>G,64JE,HaV0WJ(\fIAb6S-D&MTd,J70gY]^-DD5N03Z9&b#E2]R,M+3
X+[DU<&;HA[.Q4bSN5NJDU9b-2fS(QU9b5bJ[PBW:0;_90BA/]55XMBbJ;7g/9ga
[6^b__TbRfHWee[)H5.G07LJ\0P\6AH]>QfUG2H^ER9Mc4=.]O3D4S&H7=7[1++N
>+Q1P2AL,BD+#<4bOK?J))DSZ?/\4[IdQ],a=U+bJ;DCNG6BJNPXAU.J;EMK48cC
B_<c]3\+gFM/A@-]TSAc/>T@\-S7T[D7[P28.R)NSX;d#ZA8[SJETL6gF6?7-;SR
fKG6UfRR]RbJ(eNIZB>R0/J0-7;]2Y<=B)g-)?ZQY&>_H/5MYO.);EOK0)e9[0XX
/(#(JZSXR?O3YR2-Z-(Lf&S;+(dW5,/NQH@BSH;JSJ3L0>,;>##2EaI#45ACNfc,
ZH,48I6UCBO096FI;Qa/PV>(@&J4f_cQZPd96+/GC>bC?D_434KS<e3Uf+L-eK6Y
EP4C+(@&IPR-@>0SUCa/PJP)8,fgd9=0aRKU,D/O5C>)JXZ?b94B2JJ7D)CJ=0+Y
bCf==1T,@;8O^g:YNTI?UbPW]C&,@?4?(>?AT1Q)@V1aM.Z/ecD>aPOgfU94;4J_
^A8^[3NGZO^b7QTZ<GKE9aFNdPEXM9c>ZQ4CI3.7fL_R9,HX;[N=:&;.1bQQ@L8Q
HJ_.f=4]B++W(3W0F#IR(4;HP.Q7P<Obg<OMVUKV9Q.=KIcIF4&\BVB2V\d?-?X#
<g0CPH#Od5G[c&bH<91:Q2NS^,K/f7;e(<[C[,JbU#TH@&^,U8T,U)ZS;c-XOgg0
-d;5=A:+ODBb^Q8aT3).8T=eUE1RUUg0]eXMgd]Z&30&3&-XMPI]5(Q?CR9RSKMd
MeV-fLWD).6c8,(d:-Mg,)]I-=3H&N/A(M:>^_9:1BAK3)JXRE7#1//&-5FBE#=1
dW7@S(15G8Bb>C2dFDV7L&1H^60gR-d[87J>OKSD6_KGQ1CZXcb_,1IQB[VG9D;9
@BE<FH:1ZDPF9?aYb.5;P/M1&Oc63[QGX2J<,IR7:^7gAf,Gc1a6>=._;S3&2Q1.
O5QYU-^0R0=PJ]&UTPO&Me&3XR<.[(S)0a.8dfN^2=,X=&8@BB:+AL,BFW=MFT#[
C9X2F0-E+TT_XP&=RZ/\;MF/[TPA0E7#Ba>S&VDD.^QR5PbFA_MW5U4Z[&DXE^E]
Y]:I=gN<)=O-=1#E1M=g)Y#d65c]1/;]197:3A\5B&M-KN)L:AND+7MP]X_?^^EW
g;]6EdHBb[&_030_2I[MeV])ZKQI_VH#+1XQV<g>YA=5TS9Z/5-H@SE;R?I4/^A(
8XEZ]I\f2CIWc+b3=[8&#R(M06^+Dg^)00VLbZ7_&3&;;801M=9(@aT>PgQC?a7X
#D@?)GW^P2HL#W\;6#7<2b78dAXbR9K>gdBf?eSJef8[8g>NLQK]c&#(;(0Rb8?H
A0a(JD(L&B6e-)_PYEP+a@JJ83L=H7J:#DY;K(RNdWX:75^WGD(X1KYS7-\;E,+F
X<-E\KLLN2C4D#^Q,=#^CBeJ0:HK0MU=f7O5Aa6XX?</HL(9T4WaEGL4;DJ;VQ2]
#ET(&O7C(F]MAVP?JGK(eeCYY#\L,HVFH-?_aW-<O)EfdG=5]M(X&(X6g=U&_;\N
@(_dJ>U:Y47ILU)?EfP(&,1@JT0]g9cVdLXMJ,KE3QMEB];Kg?=9;;1N#+5<VcM@
+)[-ZXOQ<Z->I[,R.D>e4KRQD;F_QWNNgTFeLTP[A<#T>WF>Lfd@NK,\MY2eU4cG
-V-2O9(B,#WcL90Q\=4C.60a2dcTUOd+O;fH+T-:+KM).6<+YD/&gUFL<(B.HR>(
?3(Y[7O:L?W]9OcL/:,=_AIN_ec@E=3(I)41\67ScWg+?W9<g^@0,DGe[V^];LeT
,#bIbKK)Ig.>0RaABE>>UU2MfY-G:.E2]5)PLR8@Mb\X;NYA@@\>8L8B(=88H7]A
Z76>A#>]L>QNGP--PI^Y)T7LG3U@V_/.2a/,gG_EH5AKe51QXA;#05VH400ZQgJE
XRI5Za5\.?2Q]W-&Xf-(UaDCQ.H9\?^PF7Pd1f5E4I7Kd2.GBZDDSdGc(g^Me;]B
&J+R+M]Wd,Q-:))^DOG>3[79)E##8RP78F+KNJa3(I7G>gAWVH8F+Gb0GDZbZCAJ
BfGDa:8?YK\P^ZBdJ#:UfS[QHZD#Q[2,(OM,KZ_(APV01-^.4O=5K=7YZ.OR-?0)
2Ag().CO[,B1adNQ&QM5H+3bWS9a:XX6Q2aON^e;SLcYP]MF:+11ECAd#ZB2ORgM
?EQ^?,1SSP1RKW(QW?15L/?BgE;MV:eQ4XI((M)O>(EQSI=1-65\\SDA,g/=8ZXe
(VY[5<GE2V@[JfPB<7O?M0)Fa1SXNIVV?VcV;F]/BAOP;2QDOMIIBDV-[:]G(SVS
>KIag<bEa@P#&#Ie2N4f.K_^>+LB.XPcU@@5AQXS@/DVWM44EQ@4>cU&RMW2Ga>[
?6Z+O-MA-f4Ud&4GLebDW@e#X-?GUG<YK.T;YfZ](G?K=MaT?)<3YPOa88P#H0FC
]I_\HH&5WI@ce)fB,JNN7E>6NJD=dJ_QL.fcN4H5?gGD,8>GM2G<W?G\MaOaZ9R3
&gdT]UA:Q7c:6BLSOI3H@AF/J6QCPZZFL2P1.-#0IM>K3IG4)5aTSMSFPF6\05ZF
M<d,+.@E)_8:K@DDV1:g+P8(^S@KA/1E2a?S]+QIb>HXHY[4DMZENH.I<->8^=ZR
S(8P)Y0Z7NXg\P5&YSX&<1[]E.QVNB5..g\eE?2SGN=V11P9MS0SC6+_JLJ4FSE4
T-R3-=8WR8Z_ScT6S^KN4;gIX5AHOG_)0[B-d@Yd6;W1^/?92JM6LZGMJG8b60?W
PB?P3a:JFU0LF?WeQ)\U#OT^[+C84>cR=A:B6+)Z+N=:=cga/HFY29Ra(ad)4NOB
M9OPHY91JQF>b6LJLJT+@]O0,(KeOKM&QW6f;X)X+G7^^?Q64WV;fbTcQCO-_E9O
<FeeCK_JVN[0c)5J73GUK#PB46f0@6bO&]-E-X541[^:/H6X-URe.X]YIAH8-SM,
X1-bQ>71gWWK:])cLNV[H>:[EP46XOU?ed-ad72]+IQ(7D+X1=>]E4CKcM@FUMWW
F0]eXe@-cN72b50H/9H>K)/JK4d3HTFK]Z+G=.30-P2.:KID+QB?gQ<.Ib-BISVd
R).bHdf:R6]@.F#D+=Y^F94FY<PTD)Y#4OVO4(9bW3+[:F],<2Xd,YL<RU1G60)H
(6VcE;_]TM)5fQe+e@ef>[DAT,E3g\3_?^UWEEg;,0D>YKFE)4Pa:c(:5QFCI<c=
dafCDag3C/PI2,Z8:fa4,533Oa>>R/6gMM>7P@a.@,2e\F/63S-3I/WMa?U(+_EM
:HPKUE_T77/Rf3aKVF[dL2[_]@g\QBIJSS0g[#cCcZ214_X2bEF8<\3M4K(3d1b^
.^f&0Fd(38]?W0JKZHgP>)_YVE&1OM7He?GM<.Q1&MUSDeT7D72U.SS1VY:9CWZM
6CgTMcJe\3;CgC<.HM.EZ<R)VfS&2KV]E(MZ(MU.F)KGR5NDG+(734@:RY\?3/M?
.YBOZ85=J[MQZ_bDU[[a.#UWgH).A@70#X(g-7@_<5g<GEIg8:L1>,78JY2cZ-1-
6BKR0aAd9NJO&2\2]C[3;?=S(50ReWR[b\?V+XNg[gQa7=7IdU8I(We?8;2O:@EB
1Z@]5.OQ\f@SW2\?&]-7-9[d9=4-CI7&L3P)H9,J0DPeadeFQEWN+A8M;)[X.S;E
=R_cYG,<Q>GL<#>cN)Z4.@>3#F4(c&MQb(DNM0C)5PDT3dPE&W[DE(QZU#&@f/WY
NBS8\FP2F\dHH?A+G)DU5b-c??H.14R13c-HR7S1H_eV.0bf?@#fP+93Bc7=)HBK
V&cccH(O_=^\gWJP>GU)COU5g-Ic2M9^#J##f)1&P,fGcR9RM7.EUN&-?-NQ(V\D
?<<D1B37aUEfX#:c+K#PEV9?c\a)a)_6&9dc_eWZ>D.b1GO_8_,B/^OR4DEcBMe5
JG>2aP;,W^RSL<\6eVDf0#/2SOPK33O(b=X90W/_;5R:H=+[T4J<V28fGH8W&9:7
SE_GdBS<R58WL?=,R0PX_+QXBV2Kd8KO#-B(@4..YW&HI:\QKM^KG8,+(e_L1I?B
)<a14Mb95G3EXX)Z9FT&M]YS3=@^FMc(Y\W;cV\G@Kf-[5M)(3VK5EDZ^H.>(5fU
V<@dAe3bAEB[1@>+KZONc/(Ma(IRWN;fE6K7S&JLG,;B;gfNGNP7<]IGS]]M=[A0
3]G9fW7e(]-6<Z4SLX,,OMV+SJSC#Ud\IA[S0P<WKf3+,5.aWTE:27VK\WYZ29M0
5VB\I/9SWZ@Z931eC1Y;^_9>[O#SP8IHP^[]/UY@SQ>^+6_@O_aV<=R6LBC\I]e,
PW:NXK7cf^=B4\YA[_A.bSE572]6Re?;+d@g[Z(XQ2?R-C1A>?ZX-8\S:b+ZKd^S
]4[^GV3:K@[_Y+25E9/&aU^D6)X)5J[)SH7-#P;/]I)[b5#Q3UO<IcW@\XDaFQD.
+d]=_Wf@aKAU/J=V,bVVe4DCF4_?D)^#FR0[ZBVX_;X5)6&(W)Ic6M#b+<CK=2UG
#O&fWQ.2\>2FMQ0YKc[8OZ66fAVZ/C>g(PMM2G6]0MWN?gRLgRVTgNFC16,[\.[R
MS@0cI#UL&3:TV5S=_-(ec.B#A5I5:#3+;2BcHG40H06-)@280KUT_VbXWY[V]JT
]U,X>e9Q4Fc^501BV3WeB?/59dM_H=W-3N2#[cWaMf4.CdeVYF<FSYS#C=)g?Cg_
]F6RQDMXW1:WP]>2I1#.2A2Zg)aZU#B@Z&,>ec9JNcBU@LJfVGI:,/;S>(+Zd(Hg
F9>Z9dPHQC;CN6E#+;[C-2.9Ob@=DRP9:XOBdRE,RgT0MU2Me2@E<:dfMgLAL+G+
D00T[PUZ\YKOCSLRX#AE[1/2CGB7<M+4;\M\^#KddL5@E,626E>2/AC,JWQI&RIU
93WgUI9/dF.<6WfXa<BQ:KVe:\;2RAC4\g-E<3SP;>dV><,0/ZgD(#9B?6_5:K.^
9f>+D#fV&ZC@)R^aY8P6^1>VEM-S27XR3+EF.KM8Ag(O-;UTe7ZY0.c@f=2GYe_[
7[F=H2R2I:G>R+L(U_bGC+X+[d5ESM3A.;c\BBT;cf[I)@2W=e:6+P4CD;bV-0Pc
IJRFQ(?_>]2N6VK9Z:M8KI]4<+5^H.[d5PfGWf(1ADH.72T4(@<?M,U?VIG6G5#4
CX/6R&V.^#A8/TE37dIJeD)KZ3W..EZU7),:K=&R_H47W)A0Df(/X),TDM)3@B29
?GET/M;IK@\A:GXd;.7DB0W<Xc4/QL)DNd>][a_#XAQN\3@OXDTU^\=CFKS)7AOS
SeGV#Xb;/-F]A^Y-QSQ<d:Zfc.e[DX3F2VB_?A---#:[J,0,AL&bB4e(52Jg3,.U
0B+\;A\.cB=7R3@1/QDE1L??45,=bF(KORHBe]dODI^?6]VDCQ5>b]JW:[:3Q7aV
X-,c6)AMT;W_RcUgcVQ9Q;67DC1A45_8N^>/GN:-^+3V#@D22UILK8g,W=&FJ[]8
gC+0H(U-eaP]eZ30=RIYK]SDD?GDOW6X;QRK(g@A-GGM=+/[V4NB.5,AGOE8UH.]
#Z=)XC()]((-&K^EZCM5KA>?Y)B/PJ+X4E\c0_A(/eOUW[M;G:J^T@cJ1G]T&[TC
JNT2_XaRcJCV/=Q4)X\X?GL+A&:P0I0SMUTUG;cM-C:Fa:NFcgCF8f/&@YD8S3-F
1;)/R=W,a@d<5(4&,cC7@dZd1,]@@8fYgT49UO+Z=/N@OY@@&g@LZ5f]Q\\XY)Q2
#8G[+0XUUJ3J^1,QUd.BIFcND,JH4.?H#.K/^)F7<cUZLA0b:]R(@#+0RMMbbJgf
?]A^RJW;@b7&[)\_T>8;\RCKX:F?<U,;#=O@7FC&N4=Q?O2J4F]96O@Fg//0X6/P
CVeX,DcPD>2=BZP3OL?>OO,TF;-aSMNONE@D_;,\g^9bX<L>a?K6F[^M?QbcL:gX
(M[g8QY6T#gBUVW2f^P(1Ia+I4F@0@.EK2d-gG\YeHB:23IH\M>UH9QI0S7?VC8?
]9-WY^1C]VF9e(6b]a(?.GJBQ)N//T2eOb300bQDZ_51fBge#OYOO9XPF.B=0M,N
QH_3gb,N)](f_O[d56X)RHLUHgea64(g9=.PDZbFESN]\dCI=IY>F9<>d5E_)C95
Vf^Z;7V1-N]6&Ka88ETFD5K;-CI)@f+1NdOE1dHIc)edL&F/DF=#VAQFUgW9.L\g
bFQAKTd-:<QW6bacBVG_J#Re1J:HW5JWcGDd0R/^YW?V3A5EVSB0ea0b6F8cF,EW
M&Y]52J/=N10FG6EccP0A.eL_@)8HJB><V=OOCe#DVM7NN75aFED+R3WJHDQWDaE
@ZR8F9AMB)#?884g(0g?ePRC=<M^B<AKKRV;U?G(;UPFT9.4@Z3B.)F^C<)F?O92
I&-C#DI-Pd1cf1&Wfd]+J/W>9?ecWdOEM&T(S.GJ)F/ST,SD<dg+>>CZ=FDBdHA(
/e\=NF6Y(-C?JXL++7923&K:>7)[[,=HW&E=1M2(SOI)W+4XUZ\2)9eT[DGG:H\+
g;LDEYYca9Pg&&S-=\4a8;J>.a;GcJ9]RW]9]URM;5g51<]>EeUd3ED4RSUC5I)M
]ZP;..+acaF;/W7Lf9/NEB&7N:GU3J#IX?OC(7V38FP+,P.8H(>[?DJ-8M861e(6
BM9?JS:1?6TE8R_<@1Pf)1VZ4[#Wd)+(8/HXD[G^94.Y+C3K(J:,Q?]&WdX4@g66
E5FX0UHXJ=Z75+eSL9K;@ec@9AOF:PM:\755ggI9U=@eDE1,UDC@MA@0A7G\NHR@
K&I0OS>CG0>^,beBL^@Df1MdI,G)R^_DC=H7&U/>9YPC\>JDg(\O.[D8a(+]0##g
<TS(\8PC)J=c@0)9&,RR8-4a/BA11c^1gCbDU^9(6T)GMc/R:fP:e,\))I7?S-7.
H:ffK^;V9eN_>AHX:L;76g)>N#6\H?B:O_(FI[^RY;Yf;0M4=DfXNeASIQHE9f^4
&P^\5^&D1Z(PX/&+W9fGLTc#+@K),AZI/.V6S1KFcG(_/DXS2&TB&a>UP[Z<FQY&
7URE5PPA.<LF-LUU?aD>O?JIC.<K7Aa;B;4=\TN[>ccST^.fA8C,]1G+T.5GJ1W_
0#N-XfbV&_8d5L[=P630R>QSQf.KRX[P;&UW-b<U\2MBZX4TC.ANYKB1(TM>)ZA3
(E,gP147>_AV:3DH:]@.->gQT470aaY3D8+TB6c1VM6C_<K:GIKL&e_N:W-1/]CC
B_Ad(IH4GD<5c..ST@EM3PE^d-6dRKeOGH3F_I[]WO#B-QMBD(L-(J@+IP93/LJ@
G3YM(FJ,:&Z/.[AX-&TG?A7@77[E649gddb]L>O@gd)<L2:<XS,_]9Yd&e/B(a8]
M4-^8&L2D:<7D4d^QbIM7V?#f8S8V[:?6bQcZ:A.S2V7fJF\2ZD;O5VW[fW[TTb.
GP@8;MEKNEEAR1RaHcM@A_?Eb(4Q\XaACE7_WSe&3E+8cNA@9U1F6FCRO,a46e<Q
IFL-K.d5F[F6H\T\+?24_:IG)L&G3I7;gUGF,,\^EO@Z38&FZU;e+4Z(64&8W72^
&+gYMa+^&(.?1D)b_c_UB+E+<c)=3P,ZQ;>dUGb-1A>.@+Pd33S8c1]\DKQ2LF?2
5PN7R+W1a:SL?^^YV=f&O(-D,&=242f]d#R=S099_&UaYJ.2aY9ZKQfG_0U),1IV
S]26cR^DAL.96X2)RKa>5&;W-H^HYNXO?P4#K-LOM9]?@&;4FD[:d2&#W=9I#6a_
-[:F/93Y]?X@HH92&XLYFE/AFd0J>B.5/NX:Y]JC=:T&XV(?a:>J.UQV_Jg@033K
.CD6cZTE8>VZ\+^9_dM_&S?e9-a,</6AIB:_G6?2cdQ@>4/TU/a[<eG:1MA4#9W5
D#0OITMTR@I-dIJ]TN(U_GS:CQgMf09@gLXHgS#.#Hcb12eK]>f2#:JJ(ZBP?3(_
4V;JOQ#1OXQ2Jc&G1f=5LE?JfcK?EH&K7Y]_;U.=;C3M]\NW.:/\e.E.-(-I=N@S
]>G3IV7;.Gc.Y>_(.>XR=6WX03H/O.Z^Q.RSEDSaKFb5TN?GFa>.=5BYL,9Sf+:@
Y,..Q@.Oca[48R<X1CR-0a9Y]3.4MHF#NV\MEZ2P]E;)B2d(\0>Cc:1(TT&^EQ@@
a;7S<UT+6^^&BO]T..?Y3^(9Q^?Gb.CG.N+-SK.KJ:^/[c(J1DI<IdWR8,dX\=Zg
YbMPHH0^(TE<:/Ffd]AH[9M\,cJQg^:J[HP7+^9W?IT(NgFO&GWEL,DA>1=9[K25
]WLe\S<Y5?2#eI\LC-a9ZXJYD6FMJNY/57:(]eLH^+O1EOGA/JKN#>:.-MDg30[I
;S>YO=J5D69cS4\f)(K\H67=4V?GNJF/c33g4>(1EXWY\#f.XMZ/^#^BW9O7O61\
M\X&#I.WOV2>7C^_^H[SE;,).GR4P3V&4F02K6H30&TDDc/7TZXQX8[U,&g/NOLH
cNICB>dcFI_3-/:R)^.)OK^.,87d@1eP3GJK=FY=2,#gWUQQEe8_GfQF1M+3aGN(
B=C@6S(_OFU^&,RNRVRIY:;eC\[3fcV&b^LHLXReb=^aWebW:SL.aAfb.PJ_=RHQ
1Yg8KQ>f0ab;WI0]/,>-?JLO6aP>7S3#J;c/.)-J^IaKQbI442/ELT2R]^e#-G@)
4^?.AM<g(P4Q[H(38H:0c+WR/#8K33[\^Q^#FIdS56+1b?EP:I>^BH99)TN]+A/Q
4<47CH+XKB)U;4O9,[A>#^\Z9.?G[Y<aN:cV^3?;_L9Kc1@<7\U#7JR:0UAQ6TP+
=eX>Zedg[PZ9)\BPb^b3SF(SaCTZ61U7#D2c/&JQPV/N#&4Q]g\.I+LLR?=:XFG)
>DBC/U7WO3#HMNIW.GYG@e0)[_>\0/J3^ZP_SXZM4/T?aO]XVY4_E1LTM)>c9OOF
7H9A:C71,17GM7gSd5W(7G_(GHUBOIKI-1_I<e)/[3M?PcYDc9B&Q5QcEfY/_b:e
TRgf2T&WK(2UbReG[Db-5?e[DQI79?Q&PP1Kd,M1.&4g4O&X[(I>T/,cWMP.9J>N
.H<5Ra0.VAT2?eg>a7>I]YHH>#.8J,2W:9;d#^cgfZ1[aL@@&&df]LOFIaESg[&<
-Zf5Q>+f,J7=f)P=7,.LNg0f1T[@&S@;I[cG;MTdVVBY0SA0WW<1A0@b<dbO0&6.
/_P_bE;O(g0>&^^K:2gL@.8e;6YBfRHWDbTZCX9)-)fBbb/QPI##0.ZS2RM3&FT-
X0/a;Ge;/VM&aP>X]#,^@AeI@?8YL6Xb+69^V,+^HcR0,+Q6,cf]CcaPF(b#OW7L
C<C.P+eKE^#deM4+bI4F32:28_C7KCP-d+R,.9Z1=\4:\)67D23)2D0A=R_4a[#K
2K1,de-NUNVY@-B\bCc)U(H;5dLWJX82Z<cJEUe(<KN[E]bTaYG.d7N(PSWLO-AN
/(J^QWAENLJ:+aOcJS9Z=&Mf>-H=L=]M635Q/(.EOdg9:Ae&D(9,f10E#20E_VWW
C(S(FEC(0A8ER\8271TJ]72<(^3adM-?DE0Qc05^YHa];V?DgfX3.9WgOb:EQ<A]
f45.[\0f=^WX\=+.a&Pa-23V;8/S6O90D@9O<[<<#a^\\BHJcJO:E[HOe=;R(+J(
8B>Y.Xa/4M94&S/)c(KV7S4>d\KW2#AKR]Yf@T/WA#FR_/bU;S#-OI7AcZ,+=1/<
6ggP47Oga14O&BDPP&13RGL_W:9^SV)RK>d9>TY\-E:^+.7O_A:@JM=\CW0?10TL
I:gYG@bcB77==_=WA&+fg@gOL-=XT?GgVZ.DZQE&Q1&URJ_;?.8+QaZ5]C=^>e<-
7C.<J19#L;1ZQX\b9&Xae=7(g3+WYI]MBX#J2V9F]9e@.AZ9\Sc[(P<W-29N48R2
E698E)K:P@>]S:@?41]g\,(g-BG_;[/Y-A9G76&B@d4WG8&]G;(E/U&6^/[FYTWG
[H4cEDY-TJ)Q7#[=Y;a^]6/B44\YcY_-L+d3eb)QZc@f85RS<,^fd3UC(^J/LBbN
fW_;C57[Edg?HS[#9P_ERXaW7X;/IYf(\e7(_dD86ORBg(44WD_;0VF(.CV]OaXa
]PIbI48QcfccH#a3::CX&e\__OX4M71g->=?QG<XXa1)CHDT)PR?BLM\6;>JQdY+
5gSYY5:NI&-@S.NRMe=JV0-2#Q8UZ[QGbBca)bT&^M(=0]/D@O@6;E/;_H)X>6WP
+R>/AO9CDc)FI)_?b/BCC&BKAI=^//CI-WJ6XRB_@/e33;R6-MG,<&1]e^H4C7Se
;_EI>b;[ad29<>WB:\831^\b\W0A7VH2GdfW>.M,+0(DbMbJL48QC8KEK.-ea:Me
Y4c(TIbQFV8R=R+DPf>;TCLGfO4>dH\G37JI724VQXc=1MF@KfLH]JT<HVZ^Lge\
PdXL]BN8O:/b)SGQ.+VQ3_L4XXXZ3_b/E^]\,G1&LYA8Z?W5-P66^dC=g2>EKW4[
5FXZKMRJ@Ed57XJ,WQDO@(7FO(-e0;3UXW^IZ;?A\=>WTPKH4HBSZ?L>)>5M\#,)
K<^2gDgX?=Q,;-F7^)QA_+b6@7QEUaX^]W&F4&>cf.g[1gH<Y&+1>)2S:GTbIOS0
QL.Se=CNDQ-#4RLf2LMA\X1d?d+57O=MW(dZ_DL,J;V(cd>,@dTQ?Q?SV\a:(_f?
PA/O,gEV7J2,DZ7Z76>3)&]GH00Hd>9;R-d:EFPO,T)Dg#f,eX@a&GK\<bb(W<fE
6W-@KQR.f&CXEC,+FcYb]]RAagdUN;?Q,LG-7<))Y&)Rc#)gGYX[DL>F0][2/\Y)
WIcG;Q;#]U_JQbKD:a:Oc[,JH8+d\#gSM1g.Xd>OX8:QfJK:Bg,Z5dJY-4(.W]SF
F\?@89R3#dR>Ngg2eM#2<D_E8Y1b_FW/LLf&a.\9P)9deBS\.O5GcJ=ef):X9bM#
U_g>RIBJ-PYg.R3IgcJZ5/22<,,:#08<CAC-6b<)DM0HLHB37Yg3D/:)6_8>\HQ<
d/MA\gVgQ=2^)?PVZ@@W+#XH:46G7:F=C8-CGMKg7cM;T@I_)M[?QHV,V@_.e&QC
-W/Yf:EagFT2\1/Nbb)P+d1<G=9?8V/XE/b1EcS2WCe3-aNXPDJ<LF04AP/@U<2X
3Y-?@\d:-b[6MM(\7QW\)]Hag>,UJKFQE_1>Q(?N1TX=1Y)/I1U5]QRXLFV5>WGC
?W^6+cB3dTSXW1aX(=97;[DR=:[&gf8]TVFB)WaAE,Z5830(8@59VXG==Zg9=S\d
I2BXOSZ/54>7)9B9(.-_aWg8[@eFZRSIISNU+1L^FLC3TTF>,I0&a/CWV.&6=#1Q
ATbXNBR,\&(QVCVff)80:E89G2;V[<9@IRB4\R@E^/[XMfRB#aaHG-fD7QD8T8ge
U67AXA4G-HGM:)eP<:BBHgO0GI74@6;gCHT[AK\cQN/Z3d3\_,=AUfXTMO7;^,U8
VKVBf4IdI,:-EdHdFVGF@/8Z^2A&SD,U_d;B(>-^TYN,>UI+e7(g9X/73gf7(LCN
Da[ADf?X:f-2\Tf(K94WH#+)EV7AU)eA_bUbNT_GHGT]Z+]^f[#a172Y+g5[JVAX
FUU.LO#;L[[B(T@bP03?R3-CY]RGd#?O+a>O056FdMU)/(:;=OJYNDe>c-8)O>+F
U,>FM[IKI,6g)a/F7g&@K76gB(;_b8>)a)A4];(NdZ02=fcM-aY;5,_R<#@P+4cf
Q\V[4K[JX/?9_YZ5()>,/GgVJYTZ@EG#A=XKRe;dXTO8:eX##BH+6@g_BaY&(N^8
EU<5T]Y>G-J;f0IE#)CgbRSc<0<6EH>PH=CQ25Daa.P;X?8+aUF+a+dNR>G+85AC
EB[#33\.YREePY9@)J9<JQ7-N4DFM.A.H)=f>@L?K:3;g4ACMM2J]0-\QEB?Z\86
>+<^Mc;[[9DI:)J6L751YY8S[g?aD&V(BA^18@MPG,9ZJ,Jb][1e]UQC@LK=.Eca
7V>c9HSA:)>A=04C_0483OIN<0?#0.^+@.).5Ge#([HDBYJ]23c3@NC+dJC^GDeP
=82]:#dP-2>@CH\YL5A?HN;AW[CB,5L8T0EccNSd<G4<N@3?eCaWeG^^aR=M?[6H
0La3CY6R>-XXNK_8<R4<PWZ<cW/CLS\&6D1YT4VYd_@dbQ-I:e0\YZI#V+EIIBZF
PAC+^?@ITV?RMe:,?(NPZU,)S6MX?C6&Tf5[YGc>Q?e7]?gg_)=:_NKV:d7_Bg3K
.(.U4Z]26b;S:99Q?KUFbFNKS+;CZX-7LE7ggYGE4+\U=^d[REYIJUCNO4Y#MFG1
Gaa]@&[;;/YVZ)b<Q-(TMMNdJ^-P1f04E>U(f-\RX]fQbD\D[Y+,AUS43.I:^IKS
?:^34OeaD55@]E4P--W96/f65;KLM>4]&-SJOJ?1]eG2UVM>_e.40>9)^9XH6cT#
&8M4[1EPa#-,_-6aB0cF2<<KJ0Z/UEK\e0]19[d=<H?\bTW?RP]3TeBP///E2X?-
15->Pd;#JUDU_9YX<L&]J--GECT72^(^C\gaKWOfa8.Vc76(VeTU3J.P:7;&MPF1
A4CZPL7XMS\2H3PSIC2;ZZca31X[1;ZMS.V(g6?Q;Y[VD4MWHg2K+T_JXTP/V[YZ
1LM]?Aa1(#V9:;)-AYJdRJV<SL4A<;a@4^>2+J&1^W:JK?36WOY9Jd8.0&Q;D,g7
SV)+M>B:D?9&+54DE^6X,1PY:^?)DO_74G/XC73>],^[MGN@?)8eg=32cJ[CH4Z8
6PRK(-fTG]fJLJg6[Y=?PB>8fKAJF/A_2/+E^;(T^]#H86FE)&eYJAK/KM8>Y>R9
#C=fPG0HPP4G0A6ADQG^\d\S.V)#FMe7gaaY7#)L(W4C0Z2._#UTf(M.UVPS+YOC
9b,]HX8)N[T9V1)9&4PZMWab>e&a4COA)<(LDGL0LA\8+XKG[LaDe20=^8YL+c(9
(Z)YXQ3PZEN:Z#Q];Q8CSXYUH9:e+Q_,f4P[=G_eQ4f:aPC2GH5F#5=-M[_=(CK/
a#J^HV9I/.,GFCc>EA/)<K+0]2BP&6NBOJ)g#0YZc\G7]SPNA35+X&TA,fgfIKD(
a:)G)&I>[GOD3J:c@71/1@I5]0ZIgV+Z7dCVYS3dJd=+)P[^(<+;:XFZ/\=I1B>8
dQC/I2N59>PUe&N7O^LMM6@,U?+,T^;LMDRL+P#Y@,N1VbA+d&Xg-R6FTCKL(bW[
3A8>3Z:NC?JI:+1:>GK?WF;H1A+4^EZKFMSV3#)Tf&--MN96=H@OE4Eb+79V_-C4
[SJ8Z(F:0a1;B12CK>TW&6]P<.fJ8W1.,:A&&SYL@[ZA+d/A27PbZ8=8-Va^YeCV
=S43[;DA[=Y:dFQ.]&7)&L+@,OK)EG7.C.c\S4&&1e1cU53H_dI7GT:85a#,e1Z7
]C_M4:Eg>T]>0@QT\5&f;cCPIN;f8cRAQ/TNGKE])X@;HB<:TQCCUH/KZ3B;E.FS
J.I;XLY]/JHeGJ;J[f/)<>^d5OLYDOEKf/S>];VI/(]#;XfG)<CCcEed0(e.[VCO
?V.]9FYO];L4BaBdRP2HY^e^O_9OZ:W,H&^?#KSQDe8+faaJF&@K]X\R\>-4dAc0
gfc,Kd_a+cA<eWI4(=9P;&<BH5d:G139BOCP/.)57[Gd,8F,63MV:IX]HY9)RIRd
O9Y9]\H8&)CR(.&fZV7\WU@)&9\E06Q9#IcfB,=(IEaSa@(g+^=,<@ERf\CDSF>R
:G[@6:--U)_V]L<_SM)<+EUdDE4BV7=S&LPY3^S+Gd8L[S>()7cEAPeYO&I3I^gD
-2-@7Z+TbJ^YE(4:91A)YIa=E>LXD6ZYWEa^JBVXUaJ7C9KD#GJ=Z7BW6e:@W+^&
)D&L<ZW.af^bR@LfIDLgLfF,M(L\4:_))>S?9];DV(6[+>,OD]/)).XA=(5N#K.d
T_V)9#d=S66PPB&LVXU<TW3/CJMa:N.BTR;BJVdUg.D5#[[@-Pa.42C9E1R?b[]>
78^QMB<DYGT,8He/P&D[f0#[D&GM?bE\LCN9L=#eX(8/J441COI6DMN<6eRH]a<_
./(]B-2J=\GE>T_HE5^&J00M:0\YFHc\gDX<9:IYB+[;V-G?F?+J>]K:;HT\-WeY
(H:8-N-g2g/c9gI0+WGT\UfUANDgfc778N@/CX/Q,25PY4GIOVOaSGB6QV&]LR9>
/DW0aY0Y7f7LcBFf[=TZf^XUY=-@]LK5ODB\;;^E2KH_C(6bO#9aHa64BRgN-T+8
,@4Z89+ZNfY;@K;YUB^Tf[^3YMJ5bGZAg<JId[Y9MTcdG-_AVKDSYU@E-bbCb>RN
-:ZNAa;:36dTI3+]E+ZZZ>WIO+RJRVBE6&(cR/&.63A]?T0Z5^PCP.^HC35YW<,.
e1+7GT2L=<LX3Sga3/2TV@SL.L0b91eO[9W?>(Y>egHB<Eg\GH<U2W>0We<N6/B:
\.aZb@@W3gX0LCB(Za5T-,b<5U\B<Jb;^O2N/Se=YSG(:>b??L5^H>&gYR22\G7G
+2#=0VYK6)eD--HC=VG1e>8b,beQKbT.-TT8IB<:b;3PeaWbHESJ)5OMG]UTD>9L
3>7+g6QH<4KZRfJFOQ#_=gLI)L/0Fd+.aSc<Z_L]S5Q76BN-G<OM<[=<,Ob0T82Q
5\\-W)d+cO#Fg14aL6MA<E#4#_1H0+M\fLLXT5;2\:11@&HfD/M/_Ne,8CY?cR^J
Q6IHe.cG4.EU,fa?,aS,b<c>C,&P24(V7T-4KCASbAF<5,(-?6NY,C+/cbC5>,Ke
CZBKD4AcLV..K^Q@M>B?=e=Z)XF.\Hf\8f^0XGCB(+BFeU:(JAL=+:6_0S(b=b;-
X@/cG+f?,Q>CSBD7NNOL3dS,b:3d0@:^#I,gLa@QV_DI/cW\AC_?Ca+8+.QT0T#0
<EK35P=9&9H0GR9,X^<Y[VLVGDRA_gN?3Ye+Y&E57IPB4H7DHNScbYbKT#(+WL]B
CC&+=/)IR5-))<[AXX<)agC?,:^fA=I.GeA1Tg24+,C):Q3]@@aS^34:]R_4HIJ?
[S<-P]IQ:Od29RX.(4Na]A]a7:1Y7N4-+,A]<T@B(eYRg^>>dIQ^PA528]??gf/4
29R0@OL.+^Y3\_?X8c3HG6T53J;eK>=/WSU6_)R2FfHb9GYZMH^F)8H-GX/<<)8/
/G7<S9=d7b+X&PfVc\R.UWKa(]KK@RC_:(=>Y1)ePfGa=#OHVMEM4RU@_a2\2dHA
Na</)f?d=SbRe<37IJ098R42-.5edeJ7DeFY@?g6=PKIF1[f2,2R)SZ6883&f-=7
5[fF=1.W4-ccPb^?LK7]\8,JGO6+J7KYS:4d@FHTD3U5N@442\6RD,1Q3T;6SaeB
.:ScJUY_FZXT\-H>Q]CW5;_I(gJI39U=2>OIS,,+cJZ6aT4P)HIBFAdR-Xb5QM?S
A5&[JL_P=2]I(&K-VEZfQLaNG:2B0LfW:XE.1WM>bQ^MVEbO^77CUBDNX89CK&E@
Zd5d<dMMfWD?X&g(98Z07\VKGH;gK&eOS[AGUeBX0B;g7^>g_+JEM4;#N+#]2(86
UDUg<E+V_]eG3cWLeQf^b5,^S?M(PW2C517C<?1_L1+S;BR[FabX^.+8&;.F5MA+
L,AT3;3NO8=OMY2,P->g0<UV2^2>;OT-STN,L,T;LCN_f&QZ8;@VCbT(#8NLc889
SNOX]R0T,&ADb7]F?.Q=4cGg1+#2B9JU6\O=EF11C4[e@Y/G_>/U,&5\.0@(b]?P
_#dZ<M2^g?Q;.]UN\C>;7aB&=]^XHB=M[a2QdNUHEV2Zgf>CR]@L.PHFfF:6L0)Y
@2T^&eRKfa#c,+c)2/DKN(F)(X^8aZ9)+7T60K#7]\XHe84IPO\I(YD]/4(Rf\WT
+AW4Z.gTeaE2He\gC_]8PHfMKb4;LaPA6I9/Z3B4(8S-<I7M+:U1399eMHV9T>Vf
03L];TaI-(6N?XIS=2]e^E,,##7bBdEGH-=W&5CaDIZ3(0MW;I.&3:&=]60=7AbI
72ZOX&a29--3)BNc?T-]LJUJ]M[f=fYTWg.AMGX-=+@4GI<LNR/DZ8#1O-NFO54?
C/<C>CC7.3^FeT2fK.U;]WG?cN(+SUSD?4)@3F0H[+M_?cSS?YdI4&P=&,Sa[NBI
-OI::?=\KXXfMf?2O2FgNU=&QUT39dZ52fQQNY7PA>CJQ<>bcHO;HNVLY511[=Ab
33_(T;Lg3Fa+B];[;;,^a<^KeZ&b855Ub&?@g,GK:K9VW\YB^;C^7;^QfAc/KY=?
<d(BCe#aMBM;\_,W^KVIbg_XO6F<4UCf>@Wf1eeH@J8XW=+Fd1X<@N[cFK;AcNID
+=^:(E]OI<WELeMeD=<KY,GS,C&aJ;YMF2eMEgP7(cX;-G(d?0C1VXDL)FDI?HLe
-(_g_c<IVbWG&V)EDKC]0f>_@D.F6O#^fUZC3([#M+G5\(d7NGCXJ;ReIX5UKT(<
^3aQ[.\_JTTVOJZ></2&]2A)SB)Y9(,HdVBFfR.350:-V]a-1YL,TCO90K>M\M(f
Eb,HP6Y4bE)4J;WOML#F:,&6LNKKTE54faM@;<S,f#d^Z6Q;\Z&8a&9f>cU>5^ga
?281:Y/YS2]KCF<<F(a9J=[FZ[e05PKG7;K.]_K=6g?B^UK?R\S,U^^3=N3#O+^#
bN,<7H60QFP_:?gVaDYUN.&&N@NFf+RJ<LcTZY;;(/L)\HG:9e=8NA0OC-eW3SFW
2/#=.;);;b+(4RK0@#-a)\Tg(GO5@E\P&8V[aEY^eE:<=g:HQ#P/6c,JW@9=23GN
S4XBRdH9&RP;_fa0R)bdM?/?fVbWfD>G<HLZg^eU4H2J&P]@]Jbg^LX1^&2e0U[&
V8S.b_T,Vggg@\\)LRU<^WQLHTO,eL.Q,PZCO3Og3C&1BV9fW;1fe3J=/[B/#FMS
)PXReY^5NNERC]aE9#LfgO,JKYP^H4N=<5d\(#7QN,CHcD1-L+)((R;c7e?(c6EF
=70<V+b_HABNUIYEM1IW2XAC+@#]g_caAK4aN<6dE<GfZC?8,fIadL@gQN7@2^9A
Tag]TKd@)Nb=DHUc7K4J-N_2/TO]WfWPNbUcf2/>,eH(>+6HC0.cJJKgP@WAO+?=
3RgM)L-BE0V5#L-_8]@dEe8&?OHQ(cKX].Wc@P(8/U?+B.O]N&,Jd@]d8C3HML==
bI3+=;^PQZdMbbP_DN)?SEDV#eG:XFfT.44P(0J4&(^G\\G:;gQg;GOABQ+@PfYF
/ZDNX_?[8S#B4-M-G,3XZ2?K1\VU_/Ig7_K^d>^,S?J&QQ,CM,Ncac3<bLY\K_6e
SWL6@4VGXOcOAG#EG40W5PPbQ72;ReC(DV21CX)P,_=]74J3e7#0e969G#59VY7G
\Jf,GIT;ICHC2c<d?J?6J9/dUK.^]L\42VALNDG[4G33@.:Lc-_&>RHY,@GbNgf[
XHeG)FP]==M(@S+4WLXMC?.,+c>[IH\ZQ<+R[9&SPZ5geWU\LVgTZK:;EE_M6;&(
e8ML.QF]_E(L&55=b6R0Z,4@Sc66eI462I/KZ9X]9WG0QIG[Ca84#L^L_C789HI?
#:4B5bLMFJ_1dW1:<Q?-,R-)UA;X@Y-C/Qc_,b_/8eM].LZYJZ,FUE5UecB7Af@I
e8@=RDL0,@SJ@LFb^?c4#50PTT\80Hc5<bN+W(@,2=<cL<B2;#Z_,>.Mf2HA1J=f
T6<^[[?7^c<Q_QKR2[6@#:aRR&L@Y\&5AMQ=46J9fQOfP[>L[)/K<5b6,&c:9?f_
0Z=NV5Y;2Z@gCe:79fb8):dZGP[@JSH@O/;>)U4;e)YPH8]I@X[V74GbUF.>7.<O
V^g=;:6@O62fVVSV<1FGJ+KB0I-&d0bAL6aJc_AKA0^ZA8U4@GIbT\GRE>74:+SN
;LFFXGd/-O&(8V;50?We]Td9S>a.QDUY4RA#TdI8H_\=&.UaJ8[3cN\)eBg+&)T&
H#5C/LG<F.FH+W_1CL]ge:S/(1WJ&HQ@3+8CF5A&C;1.7N2dW]YO_<-^7URN2,7L
Y7?5TaSg#c]e(Ia?(=E.<UF1G6ffD3=27I=0Q(_f-?GO#fZ?0CJ,ScXSP4I/&9#3
#d>e5=EK]E,Ge&3c5O9S+J9MDC(4HDBA]7UBQ[9LEND)0-]^6I&Hb35QR]RDRP)F
>,Ge^XE;[]Z:8:67#CF#cR6^VX4gDNT]=JNe^G0gA[[58gc<76+d=[<W=2NK4]#_
6Pd9UY\&_T+4#25#EK]]._C>6.5WPTSJd9K[P<&P-4.RIN1B/g)]G)X]#bVJg8YD
D?EP4gQ_f5N_3gMW8@:RWD3WY6d^a>1\R\9+-_g2EO;P8:Q;F]Je/E_JZ=603d?8
N^NU,XcD_K/?N?Wg<JEKKa/:X7>Q;^XX8Eg;)759Q:LHX+B#[F0_9/4->D.?[W0f
H)/5IGBXX)6/PD^f5U[E&81W-4?51::=H4BDJRIP0;,(:MM.9)9];J842_PVScHI
X(\45Z84ZRB,NLC5A/3c:gAXQE\O;XQIEEDQQCCPA(.?<N@W2HP9OB3:f6TG\BS5
W;B\2/LP8SQ?aVf#]7\\;2+31-b=Y/L+XM:[g:4TUH528NM?a3VK.)V6W_XG?&W6
I0IdFc>OEU6[G>:cKGOSJ:X-9fY<:8@,aPM&D_N@Wdcd;-=;-.#S98X(;MZ3PCBD
d6DO@aS[1UM>(<JJ.fX-8LO\-_&?LC8JX2091W]XV[]&WCc2H2EC;G(<&eV?_b_^
2OKF>I&f?^_:(fV,3=8E#f44=PN[R2Q[E.[FSNB&Rf1H(2EGD=Z47G6\D\9egJW8
G=7F]eb;\7V_S]dK=KO<3HE^[F?8WG-<TJIZO2I<E0?\J>P:8X@BdC#&CfQS-C[-
E#M\#I#\:BL^K.Ud>1>,:\S=KA3D5DTRI3b)Y>R1)g/4Ea[4]Q(4.BV<#<DX8RVV
?PUGUVaU9?[3L7<)NZg3c\@50d8>3C7I,I3Ie[DeDW]_C,@Ea:=:8]#I76EN=][>
:PIOSY#]77FD57I\1V_R_:3,:U<D;E+.1WSL\C>V53PUc/K\=+HeG.bDVPD^FRWY
[#R95.EK4)>a=;:NNT6P2bS?cBH3T,6f+QMG6DAcW:HHID@4?E[&3I0Mf(.D0OTc
)E4Agcc5/3_9IL8B(aDBf0-BaD3Tbb<F,gV+)DR5&/2(cH.=EJ<gc>.W4;U)#FUf
fMGdW-3]]ef=ULf;[&MR&D5C\E#&4[]?NLdYGIR1=W9]XF2IS.><G2FZ&&EH@bL6
5+37Y6_gN09)73]K;Da_UY/K[FFH@ZHd(SM+Uc/#1#+@GP^Dc#@E,D6J449XAJ9<
a;X/cYS291PQ+#T;628TLY]b6&([fgZJI^PCT+(T-08e2GR^ZZG3_,aG<V290J9Y
F(P#f;2CGHBXTM_/QQ8264=eXg8NHEL9SAF>f.OC:fT#SG0+(UX5LC2GWJ4Z3(P?
/aZb#7VV=c5YRO?eQ@3A#33;<6]K\-fL\XMYJ^7a-1PcC?cUfSe?9+>@:+92(M?I
#C,&DU&L0?V)Xf>Bb:7X(C849/\@C_&AV]Kff8?_QHQ+7FQ5+3ALa8d;<XeEde_H
e]@^d8UaYB^,70^2<15)OLd4G->2U]DD9Q,e1AC4N^\LX1A)b-fB9VFb3SU\F3gb
^1+f,&[IFb(H:H[6Ff>7MYAF6Y_fK=&;ZC+YDa^=86bEOOS-FK+(+#_AS/;cMW<]
)e#LQa2L5CH@/e7-G:066JY+(.VT&aJ#U@/N#F&>C^#;7YI_A,48S<46&52FMYdP
@UX/_c\ef//E,<+Z/cH9N7P?.bVM\GOI5:&0-EJ@>_+f6FYe/4VMc:[4R@+KaOS?
=BWa;]f<ee.C/E4;g0/aTZF-?^-/DLFDT+aKEGI)FN;eQXD9(Q#E^OY@_aJK@L@U
AEf)4D]b:G;Q49gUf2^G3E^7>LP@V@(SVY<4Y?GUD?1XM_@4+Y,C/NGb0TB&(X&3
1(:=QUKf]6Z+\VO/&@O??;bQ9L9,dgKXfUV8DQ4J\04:?:dZNQ+B@4EFA_RGQgC&
55NC&(/B@MQ\P75Y-:C(4^SW)#@5W93W^1X_9K\/2Y+,6W17Oe7/4:=H7EYS,-?0
DY+Ua:eK/2_<)g&UPP4DHP>T8VGPgWC_6Tb8&bb9gJZ@:/,b^22RW&d\?c;?4]):
H6a/B@dNKZ[B<;cH<6PF-R1G+G&4GFgdO?RTND>3],N3N^6.=8G+c^_(9H)9e\2T
OWMG#&[+8GTWZE).^,S(=))Cc3LEf<KP^WO5^@ADWOX-+/I=g\?LfGSHfLe0eU(c
:N.L.(OfJKb4T?fRE+)BZ_ce\BA,[5c&c->Z)SWd3/E^&aO(3?0c_OS2V.NFgLN2
gN^LPVTDe7.JVAc&Vb+HVQGQ:\f3NB?Y2g[-:ged:f0UACZeP&75dgO=@MZ@MPJW
_P0#6II[N[5a-77U>?eTf7O/RE8eMU5^OL,U/</1VbY:Y(K<XM8M8-X8c)L0W2]7
\S\4\Z3E89R\FD#5:(e2\CRT2([g^e.B^HgA&=B];b[0WRg).Q)R=\;INNB,6[91
+KbL^/5FU9GI])^HC(8#/&]FAI^=\5096<cf03gb<+(H9HU-LEIbZaN#Z.J33]QH
CDEER;b,HW9Z.7_+S6CSCRJ5M@TJ6V1\6aJ^:NeB:1.QSFa+[J-bf^G=C2aJ35B;
[ed<+9&J<;4A2#)QG/aX>FEWg(+fIG1Ee1A)0G0IKCVP-(.[_)1OJW\3,439;0XO
Z5+V7aE#g6KVeM@^Z9[>d3);[KQ?>>XCSIC6_;A1Z.cR;,?,)>Wa2AE^QW)[/W39
]-^g/4GO6U]>9S&KJ5&;DR>6@G.#?[bQY4J<Ee.W/Ba.aV&W_0dAIf,G;JDd:<OW
X3d2g,@D]1O<A+FRaf^:6UM,:83WUFa7V0_[A;25:37C?;5a6]AHIe,GL$
`endprotected


`endif // GUARD_SVT_NOTIFY_SV
