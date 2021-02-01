
`ifndef GUARD_SVT_UART_MONITOR_DEF_COV_DATA_CALLBACKS_SV
`define GUARD_SVT_UART_MONITOR_DEF_COV_DATA_CALLBACKS_SV

/**
 * The coverage data callback class defines default data and event information
 * that are used to implement the coverage groups. The coverage data callback
 * class is extended from callback class #svt_uart_monitor_callback. This
 * class itself does not contain any cover groups.  The constructor of this
 * class gets #svt_uart_configuration handle as an argument, which is used
 * for shaping the coverage.
 */
class svt_uart_monitor_def_cov_data_callbacks extends svt_uart_monitor_callback;

  // ****************************************************************************
  // Enumerated Type
  // ****************************************************************************

  /** Different types of supported pattern sequences
   */
  typedef enum 
  {
    FRAMING_ERR_FOLLOWED_BY_FRAMING_ERR_SEQ = `SVT_UART_COV_UTIL_FRAMING_ERR_FOLLOWED_BY_FRAMING_ERR_SEQ,
    BREAK_FOLLOWED_BY_BREAK_SEQ = `SVT_UART_COV_UTIL_BREAK_FOLLOWED_BY_BREAK_SEQ
  } sequence_type_enum;

  /** Variable used to capture payload */
  bit [2:0] payload_val;

  /** Variable used to capture parity error */
  bit parity_error;

  /** Variable used to capture framing error */
  bit framing_error;

  /** Event to trigger coverage of tx transaction */
  event tx_xact_event;

  /** Event to trigger coverage of rx transaction */
  event rx_xact_event;

  /**
   * Event corresponding to the different pattern sequences, triggered when
   * the corresponding pattern sequences are matched as part of an implementation
   * scan of the transfer. The index into the array is based on the
   * svt_pattern_sequence pttrn_seq_id data member.
   */
  event seq_match_event;

  /** Handle to transaction object that is passed in from monitor via callback */
  svt_uart_transaction  xact;

  /** Configuration object used for processing the data for coverage */
  svt_uart_configuration cfg;

  /** Array of pattern sequences that are to be matched */
  svt_pattern_sequence cov_seq[int];

  /**
   * When a cov_seq_match is triggered as part of a match, this variable contains
   * a list of the svt_uart_transaction objects (i.e., strongly typed) matching the
   * pattern sequence.
   */
  `SVT_DATA_QUEUE_ITER_TYPE cov_seq_iter[int];

  /** Pattern sequence types that are to be matched */
  sequence_type_enum seq_type;
   
  /** new() */
  extern function new(svt_uart_configuration cfg, string name = "svt_uart_monitor_def_cov_data_callbacks");

  /** Collect coverage when transaction is completed */
  extern virtual function void xact_observed_cov(svt_uart_monitor monitor, svt_uart_transaction  xact);
     
  /**
   * Callback issued by component to allow callbacks to initiate activities.
   * This callback is issued during the start_of_simulation phase.
   *
   * @param component A reference to the component object issuing this callback.
   */
  extern virtual function void startup(`SVT_XVM(component) component);

  /**
   * Method to kick off the dynamic pattern match processes. This forks off one
   * process for each pattern sequence in cov_seq. This function forks off processes
   * which will stay alive until halted by the monitor which initiated the call to
   * this method. 
   *
   * @param component A reference to the monitor object these callbacks are registered with.
   */
  extern virtual function void activate_dynamic_pattern_match(`SVT_XVM(component) component);
     
endclass

//vcs_lic_vip_protect
`protected
8g6(K;H=bU7DP,^7\K46)8;+>T]@_>Z?G4S#<M:J/Id-=;b6TBMA.(R&7E45UQDG
^_81a8b,Z&LY:-3#CM,]3<5a##W0@H-I;gY=NER]Z=3,G=WN0;R0I6#?\?7bK:?7
cgfCJ8HX+f_U\I@<K-f73P)L<XHdBd5]a<L-1gRT_?Z#bGX<O\3,/g;f1FeN>EX4
e7S=<#__J9,H\Cg,]8-7XP#/K9E;?G5#aNfPH4dQHfY2I:LZ@+[N5ZC8_-fOC](?
@RR5bI/6+A>S,?1\.SMXU1N+FKFC#D3)F119^ZG]D\N8RI@.A004U,HdY9&Gb@9a
#_F&/0_H1E>\_-)g#>M77/P6ZTT2E;)Q.fQ1.1E>>\F(&4QUM5Jc5a<-?)[\F-Q:
&_H>7N1(>,d/13AVI9TD;SPJLbbXDG3MC_-F1\a_^.;Eeg2eSJ=P8OOW:f6]/[+_
\ge=A\CSa):/5O9]A?,^ZAY#75ZV6SYS]_XTG>R@d:&7:<MdFbO.[Ac(_?9P/X>,
b^@,HWT+Q3U\&B^6RZ<2CN[NU)IXXBaN6U[]/(S.8NPX)M@e6J^-^[A.^IgT969c
?6\32dTB8C3;^@28I4U0V:[@+7S>TL,9HE.;M+:YOB#20/c4[7QSZUELU961/K=W
Z-VA7B::J^gAe6-__Z1Q;V^/^UP8ZUJUHA>2B?VDDIK4^_VMG<Q_dN0@TeYE^^SN
CG]4ZH;JJa>c;YAB-[>D1=A]3E+]4]]S/.HPJO2UQYJTXSWR78P];4X4N<.A5BHF
+HPL:T;B]ENNXG/Ra.\RI4_Z79CX6e\Pa<S;bR@Dd9/G5=P^19VVe1MKD-2G3gBb
F#Z&GR:R([KX.fX<1K@8R#1M_a&GWFH#Z53GB]WID13IU4EU:ed_Z/.878NCfWN6
L0VJX:()^61b5OQaT\9O;;&A7>NWGSIX.QW<NUfdW8>F4B^ZaD^7=Ve4\U,2S4QQ
bcJ9]57^@(G)K4T?DUTXUbPgaE\<^C]_QXW/\U[P7I6=^#&QVB?1c6CP\bCKJ^6S
Sf<.c::APU@X\-.46X=G,>B])<7?ZP_2dJK6GgLZ\J9[3MUG)RG67N3S\74HAUIH
&8F&MV^d/)<447Vb0,#DF.@a]PW>Va#&)2]EA@4]A6<;-(\9K<9c^;2<P6V4T/#8
IfKNFF0HZ1LJ@e:-(]1.]6A<(-aH-K()aZCPO>ERb?RW2W_?>I&IB<&,bcBUL&WS
;=8dfD2]FGZQ3R5.90=bf]R<+e4E5S.Me/KBS2>](@UggLI;9652W.?g97L-Ggb6
=E:2O)\(SG/WOC-8-(/8,KG^PHZSB@[8S>F9()08Q7MVU@&gWF^KL)T3VA/M]@SO
+\&,fYdF\.=5Z)8>DT:J=7EOLdg]K(6DA^&F.R)35WUN#Z2J+]F+.TL#D5;gPcG1
8I5MM]cLae/d.<]KgVPLW3Z>(6e-V;9S>;F[#2&1MF1_-\OX-aA9fYfd&E&3Fe@<
5b\_?&#e<b;1G.R3:5-,9D,&_f?9AIA<dT]PfN=@#Rab_Z5M-b?#RIYI]gS]QaH3
Q.C;6K2EK:0c7_[<_Q-C[a-RObDJ1C,57(#HV:/+^@=J,dYI)E0N]S8P299P\-X;
QYW5)1b)N<)DL>?GB,c3@IQHUDf0feM>H<&VQU_9#Z&E:6U6/cCdUFb\1aFf4-V7
A1T&7N=NW?Z/-_U:X>]/gN2WO<Z<BG.N(8\JFXIAcZ1d-\60167P&-MD8<aWQXA5
GL:76(cTeFMXIYMAE14f#MbE.6G6(&CVG19M7SD[&HcFF&0&XKD/,-#CU]eITITc
09++AA<HNgJ-3bgCdUf#-+:1Qf?1B3^,8P+7IFU\.^bRSd>3TK^ac-eC669Cg02e
R+9^09bH3-UEM_4J.:F?:TB2)JZbV,))eLdI-4gISJVU;cLBaY\^05;X;?<WgSf1
R_=_[.IMCGC=>FE3SLY#30eB068E;\@[ROUW&9ED(F6#AW@e2Rg<VO4DV#WH[T97
A?+e.CE&;edf]#X<1Y)26.5)=(0X\02cJ2?>Y-71#X>JI/^-@Q;U6;U&VC\7)#LW
H&53ed(DJSJ;CQ\@1R2P[X;4b#gY9OHD)NVBQ1JK1AcFP?PGH:66</X?)_2<:T6A
dPgK[.UO.3bX5?RW7N/K<C:W?a74Y;dB\>2.TVWJ,2;I_9W1Va@IGT^KN6,AA0Jd
,R3U</E#Q[.cK1V3Nf:_gT9_>Q2d\W:)L/6XXT5X@<BR?K:VfONPL1ZFe>=Ye11d
b&6A/S8d2/7GIa[YfCE<F7agM_(fFXb<;^I43=A1O,PZKdDR]_L06YK1@])XQ)V&
]gIDC6S.72;d+U8=agYdaAG)c?4Yf@A07P[^KF/g&Ib_[^>+7XU&5A-Z+U:V-65[
3Ce1_AE;8#U23d6;UN+2dZ[NH9(-&7VZ\E9OdUT\07(e+bFUMR1>R2:GPNAcI3-S
VDbfPe7IF>Wg7L]M]8QDe1>AEfW9BbL]TJ25COEWDTY_&\VV\0GN0U/#+V((V6gN
VTK5abHEa^+]JZYNMK],JVe2d-3@bA.EFG9/DEVK\PD=aMdF:\;OF/^ZW_#SOaNE
(?:eX1OY[WWdeU:;b6:[R?:SBZ)QQ6g[&JR-LMaSTN84U1([\2aIVXWe;V]2Rg2H
_D_/\6=V+ga@LWY=8bTK8W,0>9EC-[3FI4JceVBGPR5.\LTAF?Y;FH>\V)S5aHE0
X[X@dKR25Z/#,-^A(09]L?0YW>HT<;S3_08Yg_0?&XFeL4G#DXUS64E9RGOCQ(=7
bP[V/?JS3GKW&\3/eK[f:U>ZC\^Y3Sac025aT:,B4?65DX)]-IA\c.+Q\:7>LS3P
9DZ9O0IUS)e1)6I[IRbNO_U<G]>YMFBKYOGF?8Ra[79^A>cLQ/]F@ebfe/&8PaD.
GZ_K]c\?P:-Ab^;:48.=S;&H_RHJO/]+);;]_SIZEM=#F3cMQ1\@,UXg)7O/89_Y
.YV/A9#OLBG&L-698]WI=2.fPPT6@A(TPK@5[+>NY:ad8=_76EL\[a6?M(MgfbN5
V:,g),5?6JfY8YC0C?fE-8E&Ha;GZ[;>bNCWb>RUbb44HRZW7^+aPId-QT-GK\O7
YQ486ff3I<F\X=KA.&D98<&QZ]aE8/OHWENG(5ABV[US<W-b37+fCA.3QGAYM)7)
Hc0X(X<QB778G4P.XPG,baRE.>_SaF4L/WW7@gXT[H74@WY;;^I:Y)3C4dN#S.Ia
WKS^#:,.Y],]CYN;K0e])7TT-D2MGaI0](Cf=+X&->:@f[/#-TYK(R5#MMaV@e+G
K\PJeGB@V:O3L#O^SJ9G#16K[I&OJ^6F2Z.XFg^XRF>QbU7X(dXS7GUY,;NXWdQc
eQ,HGag==(,7TK-G_T&_JFea&^^(&M&QQ7=5VGDX/2Q;;fYaY(08S4KIZ,<cK\WD
3]8]]QWWW;;EQ(L@4=14M#U533>R,L7+54+a4a_+7DPbCJ^cT5<&5APAQLdX,&+;
DdS+7ILG&?Ba9.\#G+Q>/^N93++Kab7N/Z;)ZYa+R<C\(04TYQ(>@Ng3TA&PaR1[
0#KJ.2J,De0UXX[MLW[5.cZ[;?Sa+O:)PUQd\Q24L/e&NDf-eH2@7)1&0eCQ]PLf
Qd8df;]K@0E&#LGWS)J[Z(3S\WEJ&_9R,L,dI>8Q5(D]gKQ,AU+1H6#4(498_0?X
.L<f7=2,T\W;[GU=GbYO)&Q_acQY7_UP#:ZNQZa6g_;C8G<?HdCKEY7,E.F4g4e2
Z/>?PHJ9M:I]Y0d:R0L]QW?/ZPJ)D(/J7/F<<.dOV)=2/C]NO).<Sc086D8,#U)5
X40.5K4Z]_5N2QG&)@XgUT@Oe<Pa<?XK5WKAW+6:5I;TbDJ^H.[R3]a+M2Lb6QSd
VG57aM]>gDe+bPKc2f1:_WcQ;e3b&Hd>dFPD?JY173#EfW(J@8c5cO[Of&F&+bHM
Mf+;ef__6Z7K@HQ7L53c)>(<g0H^=SDW)2V_?1I/5_@d5Df1R;@HMU<BQ5+UTeX[
^MJE3fQ=X+-Ib;g2BM\2RVSRf\[BWY_S@N3I)HXJTOEb]?DLPAIcYRI6JTRRDSfF
>7](P:)LW&F>XO,&M1]cOI#O;I-IgIKJIW&1ADN[#EEMBB+7)6Z?<5<cD-c+JB4G
7I^:aE-2F.=Ja__>fb;BR>&WfR^Y]VS[eGR?c&+V@A#AGNO)deaT8<1PNZU,2,BW
D@1]G1IF6F+<dF=U^gaD3V8;@UIeg4[HNRP,)-Y45HJQFg5CMb703#0E+T9B\4/G
QJM9OU^ZV>gXB;JCg+DV\.IcJ]7-?D=;@&d[A_37;I9(+3/FGM#@G=[>RMU4&IUB
:L#20,;a>W&TUT)NR&f1+;-.TG&-fTOU;\[)859LU;7R/@E<ec)EB[31&1OS3KF5
X]9RLA)c2WUaDP-(G49@A9D15:_;W&M/7<+<a?+4fc1LaER]3@13G2f@aGfK(2W-
e5R81-eg^,08V2/4cV[)bQa2((<G2GVX\\8XC\1=L@O6GT7NQZ<BZ-I5J:6Y;-He
>1S.CON2HJOg07DDc(EBZe(PeaX4^cf-RD>0)JX<a&L1:/2H<2ZcJG_dY02ER[>Z
)45-NHAD;&gX+R)-_KRK>]a[fNXeU(d7ODJG05cVULVK1g9bS_Y<+>,\H@^dT\:9
Q4f//8M/dV-gD/>)TDFPM316MIQWNUCe=-EPDgbS3Y=?gGEZ8I,fJ>aTR-[ZUSb]
0L3Tc2Z]-c^g@48/#A:F=B:C@83-ORaU:-083@_GSB;Y-0I83.:T-(#W7+N[H-VQ
TZ,B/V6.;CCd)b4Y=Z^b1OS5[+AOaXH9VV/WBYfP8_ALVAQQ&f@ef/acY&D1.?54
C8B0^.XPfIV;JFFE7b6LP\c)=K,;<?=@MH^d4e&)Z)E@gGdBZJgeKZYd>)\59U^a
GF[:67J9T.<MUY3;dc@[I-HVZJI+[KA1[5FK[?UE:g>EOX.ARSgG0.D[3eN(R2eI
L^OYg&\4Xc59\AE:#OYRJN^@;J#\6\+24gU\:+BYa.51TQ1Nd8e4L;.IKZd2_)QI
P=FPEH3#=I[4<I1A\5[T,a34.I+R<<M2HgUL[^2a-=b;.]1.^>(Y:6[9#L:#2&Yc
\NVg[-7P52<:DZE=@Ag8D[eWT\Y[3\MG215=90.HaC4R\PZ8]3NgZ2H/[WgE&&MQ
=1XB>)a:0]AE]d2,)#?b7K[gD52[RKe5U3?g@VJ-6U(.c(,V#\#DbB?L@@(WBJ8=
S&7e#R@E/NW@6Ya=KN+U@>JT9];Mc3=TX?5S0eO4@,H6BgE12T.(0^US0YE7N&f5
->#D<7d\O_HJ,RZFdIBV;8<;=f<-cgISK)g50(U.@K1HD#43)7g,M.@V_,O>\?YQ
)Zfd][TG[<2]P5g4Qe>>fd;8@_XTW/A.Y5^(Y&:RQO9C?]CRN;:;ZQd2H\OCQV7M
Ie=f3TdE[Y+FVVL?30HA?#H_K4RbWL9UJ9A\A7C#HAAc;F=KLO,,KC-=-DWV4DGc
6-2OF)EG&MWPd)Le(]Y\TNYW8F7KOP)LMgN>4A&QY/5TMIZQVQbGWEI8YS0.<^,d
LOS1>Y<2>a(AG&CRNcSE7.KgL4T^FO@TUVO9LLI^<9,OE4T=9,0F/V/E(4Z;6eNR
T_b>cOR]c@NJV8Jb\ga-Ke)8_05K=5eESFMSUU5G]&VFJ_)6Yf[BS>U.PNID+/aX
N8Jc[eA7^7J=DVRM0d.</>P3/YR&V[]fUEM6]331H5fFU)V@[G2cJ>7b)F\Ye<>-
2M?A2Ba\8A.P_OO2+>bD?H7:)ECBU^ITW^):>>dH(V/fQ2VbC0GfBA)BX8Z#Sb4-
7[6:KQ>X8[_F-T=K@7K,)W^-VP[/_0BTL9a=GgF5P>.JC1_AA:M2^4&J2bOIJHOX
#\^C-1gHUYWMW97HH1KQ^b7]&R1C(,K[/OOJ?,L=6/7<Z9Vg),KXA]B.)eSXNY3T
OD0K\[B?.+17.9LUY1MQMG;D^3#Q.Id5Oe/T2YG:VF?-481Y4_g/0=cbE24f<U5J
I)4&VS+^eY3\7+885BD8eC/.I--EV<I<?)ff:7VFe?2e[fK?-eMc43MYg\U\0X30
?A24?R>>VKO8^0(aCP;^DegeJ)&GHD(eJ2HE(,/6)3F,(O+<bWf(;_G;H8S+AGS5
(/f-D?AA<G:ST+Z5-YU)2,9B>Q_\O[92O:+Y=P)LFDWNZY1<C1..K(aI5Y/H7;S1
f9Y(Z-6OF\7=eVI\0P\R@XUcDHfO..cM[cdRZLB#Y,MPR@B:cPT[ddC4XceL,I[:
[5/(TM=0;J:/4WcG-b31AZN,DG?YaKf9W>GIVbDS(Md4H3P[c45VC&c&XVfKgW-A
d=+,^bX+<\GWWXA.RBYTOBC:a#C[Z(_f>GeGfEB:RNLNcgcL&IBA&SHbJ9.F@479
_=F;d#2-#NE2NRFPO4CKe=^H9ZaUQB12@Q4@K@)3VM>aPb4:JS1)3POVOL4PRN\_U$
`endprotected


`endif //  `ifndef GUARD_SVT_UART_MONITOR_DEF_COV_DATA_CALLBACKS_SV
   
