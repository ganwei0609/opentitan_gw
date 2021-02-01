//=======================================================================
// COPYRIGHT (C) 2011-2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_ENV_BFM_SV
`define GUARD_SVT_ENV_BFM_SV

// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT ENV components.
 */
class svt_env_bfm extends `SVT_XVM(env);

  /** SVT message macros route messages through this reference */
  `SVT_XVM(report_object) reporter = this;

  /** Flag to track when the model is running */
  local bit is_running = 0;

  /** Flag to detect when the model is configured */
  local bit is_configured = 0;

/** @cond PRIVATE */
  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  /** Identifies the product suite with which a derivative class is associated. */
  local string  suite_name;

  /** Identifies the product suite with which a derivative class is associated, including licensing. */
  local string  suite_spec;

  /** Special data instance used solely for licensing. */
  local svt_license_data license = null;

/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_component_utils(svt_env_bfm)
`else
  `ovm_component_utils(svt_env_bfm)
`endif

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new component instance, passing the appropriate argument
   * values to the component parent class.
   * 
   * @param name Name assigned to this agent.
   * 
   * @param parent Component which contains this agent
   *
   * @param suite_name Identifies the product suite to which the agent object belongs.
   */
  extern function new(string name = "", `SVT_XVM(component) parent = null, string suite_name = "");

`protected
Q7aG/W&EOH^SH<8d/UcBf2d:G)eF6a,CQN?[/:?@QEI+VU]/a;DD3)))JIUcdc^_
J)cD_NgeM_Uc7=3(#0NQ\8M\<1J3bJ5MG\ebV8M3G<Y.6b,a#Ca-03W3NE65K_BE
XFP+5BKBJG/J<?2PbU(6^.9XHP,XL2>Q>P\]1>2439H.D$
`endprotected


  /* --------------------------------------------------------------------------- */
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

`protected
)LKX8_.(8gf9;aPO=9,U608Rd13?ZcZ?/d;,>^6cJU#O_^:;PTD-.)&G[;;KHgB[
15H=?>=Ie@aM-,J^+ZdbO>YcARAa+7c+V2Neb<J.<_-21)FY?8.5R2_1d6A&;47;
RZ.5HQ_a)A#M/$
`endprotected

  
  /* --------------------------------------------------------------------------- */
`ifdef SVT_UVM_TECHNOLOGY
  /** UVM run phase */
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  /** OVM run phase */
  extern virtual task run();
`endif

  // ---------------------------------------------------------------------------
  /** Displays the license features that were used to authorize this suite */
  extern function void display_checked_out_features();

  /* --------------------------------------------------------------------------- */
  /**
   * Returns the current setting of #is_running, indicating whether the component is
   * running.
   *
   * @return 1 indicates that the component is running, 0 indicates it is not.
   */
  extern virtual function bit get_is_running();

  // ****************************************************************************
  // User Interface for Configuration Management
  // ****************************************************************************

  /**
   * Updates the components configuration with data from the supplied object.
   * This method always results in a call to change_dynamic_cfg(). If the component
   * has not been started calling this method also results in a call to
   * change_static_cfg().
   *
   * @param cfg Configuration to be applied
   */
  extern virtual task set_cfg(svt_configuration cfg);

  /**
   * Returns a copy of the component's configuration object, including the
   * current configuration settings. If cfg is null, creates configuration object
   * of appropriate type.
   *
   * @param cfg Configuration returned
   */
  extern virtual task get_cfg(ref svt_configuration cfg);


  // ****************************************************************************
  // Utility methods which must be implemented by extended classes
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the component. Used internally
   * by set_cfg; not to be called directly.
   *
   * @param cfg Configuration to be applied
   */
  extern virtual protected task change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the component. Used internally
   * by reconfigure; not to be called directly.
   *
   * @param cfg Configuration to be applied
   */
  extern virtual protected task change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**\
   * Copies (deep) the <i>static</i> configuration properties from the configuration
   * object stored in the component into the argument. If cfg is null, creates
   * config object of appropriate type. Used internally by get_cfg; not to be called
   * directly.
   *
   * @param cfg Configuration returned
   */
  extern virtual protected task get_static_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the configuration
   * object stored in the component into the argument. If cfg is null, creates
   * config object of appropriate type. Used internally by get_cfg; not to be called
   * directly.
   *
   * @param cfg Configuration returned
   */
  extern virtual protected task get_dynamic_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Expected to return a 1 if the supplied configuration object is of the correct
   * type for the component. Extended classes implementing specific components
   * will provide an extended version of this method and call it directly.
   * 
   * @param cfg Configuration class to test
   */
  extern virtual protected function bit is_valid_cfg_type(svt_configuration cfg);

endclass

// For backwards compatibility
`ifdef SVT_UVM_TECHNOLOGY
class svt_uvm_env_bfm extends svt_env_bfm;
  `uvm_component_utils(svt_uvm_env_bfm)

  function new(string name = "", uvm_component parent = null, string suite_name = "");
    super.new(name, parent, suite_name);
  endfunction
endclass
`endif

// =============================================================================

`protected
Q49&]-2+HY4&[B76&>dPQ0ET^Ra]EJK^&&^1fL]JJ?@<6GQ81^=e6)50W<K+WcSH
^LC=F1=WH.R0[FA:3Q[9N)R]5^KVEIE85aYY+[NIJMH\3OBf\@V^=A6M])O[\PV1
c^GSMC6Ge-0[,JTHD)]VKD(R\bF]G/\cEJI#e]W/NfG^I]NZNcQ)Q#:9:A.da_(I
=2DUgNTDg_?:4CVB,4);GP^8U49Q/)gfWA[WPOH=:g\N(CcY(U\)YAVR/F+@g3FB
\U?@RN9@9.OBH=NbX1-S[DI5=RX@-A9X>HE7b7IN<b]fHV@e7T9+/a\U+#DFCCQY
T-3[eT>9/(V\@&+^3<6\b(g38f,U@R.O^2E[=L2,P)@.#.L_]H;OHgN@S.)WNFdB
-;2T__=;B9Edf>ZC5gf10[AFa77D:0;O7]JB0+L_[,QA_fEA-=0\-EgO2BgXHa66
bOb##=;d/.LGK7ZG),KZ&2I_1;,)])LU^25:#U90@].DXY5DSVbRKW7WE>WJ6dXU
EMZUV)4\af4.g)eR>\&[71.a<<V[BJ21_HYR[D88)Na:8N3TA1FI\DI2[<N@/YY#
<b,/9J-G9C=+Q[^34fPJL-5R^H1])aa\I/4dQ@DbC)_VAC>0GVNZ88S/@I.:g)Z<
V]f35TH^V(7)_.C#-d4HZ<6@ODKV+4/CeC\APdW:&/.aSbccUWe-ZfKC+Q6DS86C
[DFa>ge2+^-.C^(D45->TbZ&_.Ha^V.6+V=5N:/D-2J-D3/>OX@UT6D[4]db9,6\
4T5^4)2#S:@^F6[4De82\GRZ=RUM5;D3LMAFP4E_(#1:XFbF>U0fcb34(@[3D<RM
ZTD;6VNa;_&.[KC-<OD(FVb[ceb&Q/&2])K]KX:@I@G1W1)V\JZQ,@X3@#D#:cDb
6^L(aU,/0a,^=RHb@/BfV_<V^)FT3KTaT45H-8-XQeVXHY())K8d2@?Z0:N0?+JZ
Zc&[-QX0+:=\L3;Z>U1VJ[ED11E32.7aZ)?BI,Lg#4AA7TE>:&Fb/A7<eEaJdM[\
:ZF_cNM5WKeVf\?64D)WG?EF^)@)]FN\b7N)eA-ZO5&X6I-\#7(H\Y^IBY-dP-)@
;4A#]QM.Ac[PDQ<._0\&92?c).Rd[40DO\\c()Tcd3[dcE&[&1PX0B@.)M]FR6bP
[(2O/@/3CHLW9Gbc#9>f4Je9=F;EI8=0WI]Z8FfPBBSQMJ/E-92A0c5<b_D@P6^H
+d@)aUVCge[]P^)NgM4N?.@4MT6]6_cH&ObL0D0?4>DFcC\&K5(645#JKEG9R/\6
S[U[^5Q_B,,Fd@II1X#WBG4DUSAP/gN:BR_NJ49Q:eRW6\ID)e5b/10/H;5>(?B#
H0A(gOg0,bS6P1;:1R8F)[d>.E5\gNQG55>GUQ/=BJ.V6&::VOP+2#(KI(^G0-LR
-?_X\@YM;60]/K;KUIg9#WcfJQJaUcD,aBWJC.e:=Q-YIYQ?Z56(VR&>W7H+4Z#O
].(]#\<TH>-8?)KL+EMeW9XD^Id1,Jad@QTa-#eDf;+U278e^d)afd4dVeH(fY0Q
7L9HT&IO43DaXLUA6c.9SGV1OJBV8M-T3<X91UTJR:LK8Y(Y9f_5g.+Xg1#2YI>1
,P#NDaRSIUDAeSdfK5R>L4^U5f,cDTB;7?:/-I6C>0Y)gNCP@KSO;g#F8Y\JP,,2
[N+#IbE1PLbRR8Q86((V2Ra6&UW7YTX4e19d@b7)X)OI:DYCTMQ,:#CQWD3:(_^^
G:aZ2=4GI+_=3;L(J,8^C07;)XNT(V^MW03P\DMMW\^5AF3/E98V4g7S<93a6_OB
TISV:LBSV_T5;_+b#2@[;\A1DVTQ_YZfX8T\F?RB.fR:)KNS6]8=G3@QZ+P5,(BV
I[ROKA>5WV-TN:g6[c>8\]#FW<SJS92UANd1BMJT@.1B2RCf-S/B6U?X/#0VAgdU
0Yb32LH?d)3bH-a;5?(]gZ51e0DRgW7(5N?Q\8^g>;L6g&_:V24Ac-.(ABZJ=0&+
OfCWMPI43+U>6M9+B_G7;EP?/;\d9[?f,5Sf[PV[B9P/@.PgJ&8Hg8A[<]<7Zb=8
RMeSQ<S+D>TAD=]TA3^L\+K@C.S)<07.YPWa2\6?<^F7K.PI]DN_gggTRPWDB:Q4
#TI+1+9@8>a[D]>_C22O4<.DVDV9<8,FIW-aFUZ/XDBD&V(.d@3e[LP[;a=UdY6?
eI,Ta/P<[VL<]fIG;[5Yd4de+dY^:WA<V\WPe5=8B++ecTG7;W20A/_U=G2Xe#e7
D0d.63(P3UC)fL6#U9F&3P+TJ]1XK<8;<&]+9)Q:gS^RRU57SJSWa_#4@/VX8egM
=0?A([RLA[//3)DY4DDH+aZN<a23ECIKDIAYN<C7PfO6X1@PF^]e7J&g^?WObI:Z
\,bQ1@aKTDK=#9#0=,FgZ_dIML>04aST30/4[SY(Qe61)c9dN8Z:)bS(?Y#YW0N]
?2Z#dN&K[0LITU]TJ^f(+]\6>)Tb0[JJaAE9?OF]9Lf&)@CTH(d&2RMIHPSd:;5]
>8JHdB?F00FJ01(AVFN98=\<EI::+:3.R7??AXaZ=S9XG)AYG,8GKf)28/R+6X(5
M6K.]I-X?6PaFL0P<OCB@/OGJ5)I=[P)I6)cD5+bKDW.+NgA5VFf&#M+RLNG8KIA
Oe&V/-dLeeF)R3N,D/0M;YaE;.1A>@Zb:WPgQ.[OQG,?,1XKP&+:.&@5[=0]BW#S
df.\K[H@NSQO;aRC<OG5cTGHCP&F[F&;KG+8Y+#INE5KPd&><6d6SgWY79BPJRP(
WR1.DgaTE8P7R<#HL>-JA4VO[239=[;?WMgE;>@LIae6M0MaRXRe,XdEL?:d-PT1
_WL&A/9=;17HROB:NY@QR60&O#U;_>=HaGJO7\CE/HP8V/UX55U.^,0:0AE)fV/M
D6]:,<gXgKW94STb__8KGe^:1/dN_+MPTF>]bId>)<]1E]W7Ib?M9614>C=;HNZZ
1#2\G8J(VIW;.ISL6VK:4+4eMB&2,>5?;N7/NSH2g^)/P\RP>64E(9<#T@NUf#7U
&^T[W+_O?3\[2@2P<V-/WVK+8MDAgX.WKJ;SE,BOX/2+YL=Q8^)1V9DH7U2:H7^1
6gF2&<1:?9(1UB<3R,J4I7TU1>0C^_B^9D,H4K\WOba,7<RU8+@9,&ZgXKXIBf?1
IYU6RZ537G<D,a@&F_U[AJU7(\Df(g;GCJKC[I\-3Jcg6)@V&F;R0cBIM;[=.JOf
;:Z2FSfI3CWd,:7-)0ZEEV,LZ>1Y?F1UcHFMC+K2.afXaGbLGATST_^[N.EgD436
2b2bK@Q@-[cc=3g.,Te8/_g7a&,/P0bFS/[19eKCXY7R4A(_=9bKGgVdXTJPU4WK
AK8\_FW^=O;_f(#5_S1fCD2\RRNdF#/\aT+f)Ee>f#,-cP;Mf,]((.]OGI/)BS5[
1>DZ[?//PS<NR8SC?RZ4WMdee\Ua&Y&CQ)^ZR:Y9]4b)RT:^LgT6V#/Ba]?[WZLS
<->C-;Q631,ND2CBgNQK9MR<\]3B.Q4(K3_@R^5c>.K[,PXY/O9bT79DN7eVJ1IP
7NU/).g/Z7DPdQ(DJQB.H4ZY?&,QTKZEf3.@18.W/?6;@W=?Cc-Vb4bU@^I&Q@>S
HIF;:38\?MMdKGWA]2==Eg9ce[E#MUcR=Me/[XKR?\95;WW7,8#V>AF[L+IU/2SJ
LB]#/@OS9DEDcS(\1<+D[M<<?QCNL##^6.Q#+7L9K/IU3#;B4SdMd>NZVWG4YJ?V
G@+MfbH6N6PN9?DV(-T:6MX)P>Vd(,2-@S3BWJRR?J)e+4+eAH_<Ne#=a\0fWP32
#_=YgK0b4>c3@XD=1TLggTAW9=;SZ>NH04DTAeDeee_CDW[VR3A8c;_+6Z,&J6&F
^,13RLB@WD6YPDgU;(]^5f:R\bX508MP4WTg4Iae.\KB_H_C+Z8G\ONOZ#WY<O1>
;WWeQ-X4XD1MU+[@QNbX#M44C@&=,;2e^CcP::>@TLIV:4^1B^c)V#G.SbDHKB1>
Ig4ag711Ub(c&/FbC_FLNZTUCCKKIB&A#8aK&8>SN@R=47PW.Pf.\/<VKL:,OJTW
Qb8CHXYNb@+57M3S(;U5^-4Q.Y7Y^UcaMPRQCKBUNWDf9AP6#d6[=@KL;&UI;a](
)GG;f-^XYYg]XbH)^9W6]WX5;eRX34RQDN&SFT-_D\Je7VD49^FK->>5-/)e,1_O
aRc9A/EDdG)/A5:-]J5W/YSaR]&8]Y)g(&A;I^:G_N\e#gQMXB3-b<VKaBb;=93B
:A_NQ8WPd<J^)e\/]>ff^V\GYOL[N2+9Ia.(5Le#KN?PCJ/0:7B]Pd@8K(Ce@c@5
Z:.Q&YE._>Oe#CM;GKH[Y@L#AF-4^]9edG?UXLD6I^S=@QfDCc\=&#CPP(XGB.\9
egZ.;U2E73dRNFMcFa1c/dWZDN-.)Lg2?c60b+RC8(E(RB6eHHM4-=DDI2[baI55
1O^/f^J/dS7]?gIdRYKRP.2A<0g,H.#4\8JU(=4F<0dEPI^1F3.bIPJ<Re(dZ@QQ
)QYeA\c)P^>/b_WbGKPDD<_Y8JTKd)DJ.W,ZB\E4UYS#V8e4QaRU\G8<)F835?-(
N_,ML-^Fb@IE+C2B=,EMH0)JI2VI[Va_L>IEX1RL4P=Yb[/(\PY/WK;WD6?<M?DE
X]:5,3)5:.cTg,\_FG=WE2c2VJ+BdVCE45.IE^<#3KbEBMKQ=2NM\N;=E&K7Rd_c
ZT?UU2+Z27?)Z)e=I=)KCGD=>W==J25E6fBAZ>J:LMIA(.d9Hf540ZC9TI9OB:_Q
9J:=04cb6,E.B)EXc?4?VNIG86QRCe8M2J9c3P(._U-TUBUJJHR9(cE.72\TN?3L
gIX+G91\D2U,fI,[L_7cR3Ea\S8XU]9[TNPJe9ATM>SJS+PS/<APfVKSQ@:c6&,U
G>T_,DH#G>Xa<SWYB1G.A5O0550>5UO>.W[E8X2A):H5U2;#--SS1/B1cHbccWe/
IT9GS_a#M?fB-C,F9V,6dL#FL#&TR7L.C0:6ZZC(0^b/#6,;S)[FQ[^\-d]b)@ZD
7J3Ec.]3gI2]/V_J]+]@gV>?(<Z/c=#VC-M8?Le^1B=0-D_P:c#2Q,gQ(8@]VM-]
BWDbKZ[57]\a&8.eE@,_+_6]:60:K;Eda^-P?=H1DH/ae+a)gQ4=>;,Q[LfJ#Tcg
ObD\EgcK9[[E#EV^1O^6CV@Wb:H#+?PQUR@C@:\(b=UaXIRMP&YUGH1-M\DS:DaX
@-TV4ZPE=58b63-dJ:98K9Dc^VHW,[;Cg<94-@P<G<+IR;G5O/C#@g#2>PgZQH;I
c_6YgVWfRI\6@PD@?E:)R.?TTgHY(=VFe7:a4?Yd0K;^<+6fQdH#S9fMJ&)e;c2T
^FI?g,OfDDGg(M)/RFK&NF0NI0Bc(JD0ME6d/4?L8bR]Rc.O5>:+@J2I679a083[
&]I4S]+fS-P&VC<_g+16Uc?YWB>/L5f[^\)=2(7@d[XOFQ.A>9._AO-?HYX&2>;a
b(@0KYX=Ng^VUOe_M;][6Q75\-0b-&R,IBCKM>)[.S9#(1X?DD,I6&F:eRP<?;FQ
b=P.BgF/EODb9\R1@_OH?=K)L_7Y1T.C/UF2H,+#d6^KW&,_/QFJK<X,2R,7_-dX
McAe[V(=>BeU@E]#8[_@R?[X+G.8<MHLfTT5eMHNLg4Bd02+7:Z83d2>J&HD\YM>
VSU=)+P8#3PeB2<cP2/SaO8H,0FW.g0Oc7>>3:cY^A@\N-ON17aM]A2P&G^b=]O2
R_/7Xb++C3&?#@.<6\:;1R68P8<N+LW1MaG(,PIWL(2e[BLL()P1N+@R\;O;F_;S
<<7\L,KC&T(.=Q427.B5_0VU:Y7?<B+D-b(2W]WK=;?;,W(g>Z0#_D-A/FbMC_N;
B5NPH:296Gg_7H3X9I18Ta9.[#dF_SeW_OI,>Zf75c#e8SJEH#d+8J5WD.3YafCU
dRU9;B^_5Rc_G@\75#4f2BJgDKV+5=0-KeJ#/Zg0Zbg<A8c[:d1OS7)<&GUVA.7\
??00I4Q]:E?d(N<Tf-YM.40G9.dAE@.)gWK);2V(K<EHKH=6f:VYf7@[\daFCd]>
&/[85cTg9^Z_dce7N,N1RV(21SM0PMJQL>;&d\I?@YB==_98T#+cSOXMM2(ZS@^@
TSb9:_NgCda+E<)DHd.YX+_7YVS1_ba\X=<g5_B(3<FI,fO31Y2JS4d^VX0@VaDO
_\IEZCGeWD>+*$
`endprotected


`endif // GUARD_SVT_ENV_BFM_SV
