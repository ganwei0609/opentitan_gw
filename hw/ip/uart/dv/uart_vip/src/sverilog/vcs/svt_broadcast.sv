//=======================================================================
// COPYRIGHT (C) 2011-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_BROADCAST_SV
`define GUARD_SVT_BROADCAST_SV

`ifdef SVT_VMM_TECHNOLOGY

// Use vmm_broadcast for the basic broadcast definition
`define SVT_BROADCAST_BASE_TYPE vmm_broadcast

`else

//svt_vcs_lic_vip_protect
`protected
\a#1A+OAX:&:R.,;aAdFY.^fT[5Z1?KHSeNe6QeEBCWLYY1d?EOc-(GYZ\aU?;fJ
O>?MQ5GN64.5I7U1DOFI\KK3]KR(>ZL23?EM;W8]I&]V7MN<IW,(CND.eO;X_9H\
/]]09);LRUYc,QbT#Rc1ZT4;.@#:VN6eT2RWFe]c)[g4[=[bW5:c?N]LaR[H=Ic&
8SO[[F1E3CLH[Na)SK(e<.S&?1bSc()>Y;:I5XeO+dB@4PRY_LR3,ERbV>;=SP<X
9/G/QUPVLZ:JcC?9(YEV,JS&5$
`endprotected


`protected
NH_K4OUe=.\aAGU^Ad/B:Ag?)T8Y/AZ8V2M00_#/7B&H^?.#gLE],)1Z,2,#aKE_
^463N9+\IH_d4HcC>aH6Hd.W.>K#g]D_0F1/e.VU>fY3#S;M9(LCIG^2Vf)@Vg@g
D)><1)ddP42ZZ=R;6NR#(CX^Kg^4FKJ85cI7=?0KP6=BM,.RN<<A.;X@#064A_>Y
WD0?IK:Xd(NLS]\dgN6PUB^#^/3\OG@8LGg4:_(T\,.X_QTYKdGeACaSYe2J<^(g
2&9a?E)e\-5C86+W=Bdg+1BaJ#M0S-90dNO&CP@6R1A5;g&=g23EU7f\Z2-B[5+WS$
`endprotected


//svt_vcs_lic_vip_protect
`protected
T[dZS_UFUS(DX&I<b0bC#f+L#eF6Q&Z>&[dB:SH^@IGb)A66d8KJ1()Qd30L<N/N
c,V<]b&#f376W1#,T:34g7g3]TRYDV>H7EFIV?KfHV&M]]IY&OHGff8FRZZKT9-1
\]7KTb;OP6;L;Lf.eZ[bXOA]=4fGC.#JGAJK3JZ9aSR3beA9:L80eS0I8:L&F?@E
YD459^9SWXWT-Z&ba-FHM<+V?DM>JMaK^B1g)@IK8CO,VW\>De55ac807_=EP7#6
Pe^FT>/?+/5a;T.:OQ@5Q/:C8;39.Q^WTS4<[F=I]4P>3Sc_8a(@>^9]G_\Z4[EC
9VPJPX43[]5TC</;7QO?WH1&&W+1+/8O\KRdV^()4,&?:IA-0>a_4acHgK)OI(R7
L?a_9(g^fd,+N-)a&OPBTT(IPfX<FU6V/:,?XI]SOd\+cD5#d1@GTLcHM$
`endprotected


   extern function new(string      suite_name,
                       string      name,
                       `SVT_XVM(component) parent = null,
                       svt_channel source,
                       bit         use_references = 1,
                       int         mode           = AFAP
                       );

   extern virtual function int get_n_out_chans();

   extern virtual task broadcast_mode(bcast_mode_e mode);
   extern virtual function int new_output(svt_channel channel,
                                          logic use_references = 1'bx);
   extern function void delete_out_chans();
   extern virtual function void bcast_on(int unsigned output_id);
   extern virtual function void bcast_off(int unsigned output_id);
   extern virtual protected function bit add_to_output(int unsigned decision_id,
                                                       int unsigned output_id,
                                                       svt_channel       channel,
                                                       `SVT_TRANSACTION_TYPE    obj);
   extern virtual function void reset_xactor(svt_xactor::reset_e rst_typ = SOFT_RST);
   extern protected virtual task main();

//svt_vcs_lic_vip_protect
`protected
7F_,X)>WF-fZ5.K9Uc+S3aQV&@.VbHeVc00^\SVeV9XB1I)XT@=C4(gL;5cO,_\9
KFMa/4>c0UeFe9PO\)f2OM3FTI<_cX&TAZBTZNf+Ub]9,.fA1Y-\XTfBJF1DKW\>
2L#DQEN3G-5^VBdVdH#++4cZc5.\eb44P&b4BECK5b=Jcdg-M1BX9GMNBL9S9<1<
T0HIO=N,E?A8/f9Y]5LDEgXS33J]_^06&:6.NFJVLMPcAMA&-EI<[@#\>b9I,KfI
NOE#>HW#A/>&bETA_#M_EgXS5$
`endprotected


   extern virtual task bcast_to_output(int channel_id,
                                       int on_off);
//svt_vcs_lic_vip_protect
`protected
Z)QJOIRWW..BC^E/J[Wf+]+4=d5-7e0,[G=f_/3YC?S64L-eScF50(#^gGSK)EHN
JSO@42gE/-F9K/TIS/X&2FKUDS;\RUK32WGS1V5\L>4Sa+e@_0-/a1VLWDLTI6]d
?N<BH,(M(RZa;;@YK@/JC^O0LB=O>YS#/P0Leg>2g&H^b\KP)6RQ.E8_GRUK(7L6
R(=8cfV2Z5cV8)+-#.2Q[I2PP&+K]&F]VD);>Q>cU-2GLcgG+H5.RZ,4?#aOC=:A
F_##=];_&C4QfO1T6/B<K:UI05#9Q+D>=$
`endprotected

endclass : svt_broadcast

`protected
33IFJ]#e4?U7=XfBeI<1dE(4g&f5ZB>-/8]W8[:8fAO.=/=gZ3Z82)1^>WR3W#.2
?dGCafM?Cb8\FH:YbACb4b0b]Z</6T+=\/IAa-HeXX4cRebdXZOT#,J7a&D)IdU;
1fZ6^#=HV9SKdb366)]0>KYQCGJ[Hf+6FYV=OAY&,IXOeV+D/V&(L&(MD4c&C_ZP
RD2@/d1Yd<Q;[@<TCAI4SLd8Pe>LEEBFP)-_XAT27@=N.CRGS+0(SM9GI0.AN]gI
XOL\X3ee]/d@^Y1#d&UG4ee1BGPW1=1bXGX[(C9L.KC74I[6]]<Y9C9^A;a9_e;c
8EA#bG2AS+#O^<__5[GQ/C,/H6HH;92IC2COa5^7,Z=B@HM^P-?4L[gf1&E]8Y:9
K=9X\?V9f72ALYW[4R05Fg)>/<=C<JG8gOHa_>JSf.@7cS#K:]e#@eHZMXT\KU#T
Ra;c+S#dEaf43B.[GI?EdP\ER<5J?11FV=+(WJ@;FcZLY:S&1H#H6-HRRfZ220gO
HVe0aY3:+T57McX_AVc_&_ZQDBXMMFKPGA@@F[Q>/Y@^FdEbFcU5gc>TJKU[+c4C
6?A1c208NHgH]&L;#G3N39-IQ)#8M(S^ag9J3UMR+<G\JE9@C#;M0bK+A>_(^7B1
e(Ne,1+=1DG+_c_&-aN_W(<88A@O_abCRB^b=C89U,?F[IaMGO(W#,Ya;P5=(TR3
^_>C9D<;YbeeG4f_?\UcSI4<_KHR#HF#L=RJ#K+>;dPDEMe3F+;QHM:d.-I)H<aI
67a#F8V<feR.eMX]I=-cZ<\,T9V9eQR5a7FK@+9OL733,8b09LE&ZF7]BH]Ga;\I
b\RGL)gf)E7;.Wd6NJbO>-&P7L]#,L#/<_Y-04e,^YV=2,-4@DJa4-1,=UU)KAaI
b5gSO#\EM?C2WXN(]/AUPgO&+VfT\GOgd]&?#)5]9Z6MQ;1\a,#OgWH42IfL:^b6
J<?J0Vb?;@:fd#LV-fS&I0UXK+>3)++LPW&[d:>^/TFSR5YP_\,Z1QfNYcU6_I6/
+cdRBU2cfdMZG/ESIc^gI,U0:#D_5fQR5eIF__gD2G>BGLA8_DGJ<G(>K2+d_N2L
=eBB_6,AO;A\8#2?)b]&a^_5X/+eSa&VDV^9^bdE47d_gS,_\>PK0B7bJMT.b@M8
ETEGc9PcXf;)\#;KOE^>D#YG>S;+>\ddc34NdGb[cGe2b(S<Q[4.<O3QY;+?(2-,
0#JU+3=f,K#AGO]CfOXZUa.BJ(f@^K9PC=)A@ZQ&d(:^N0a.^L=M[ZcaU<F_22E2
+A<2J#F,YAI5dH0Mf;fMBC+3?^<@b2a[+O+)TSFK(J8S/1_\QEWeKf/4@_9(2LgG
L44,-JXUVX3<5/2IYWMAcKM)SSB]\=F)8?-T/XB6;A?<AZb2DL@A1TS-85Wa&XW<
H)gX.=Y6^S;F]&XOfaV;8AGBA\F_F?0EIccSdLEC^F94Z.f(E]E/gC+3c7&>?e0.
:LcD(>_3f;[a.Z^TH)K?91<-AfSf#fgDN8_)NDCNMSYUfGEE)(@ZIVgR0JBBY0CG
JM(R0=1DNTCEO4cXZMX75&fBO<,M=bU/&ZX]TRFA1LA\&M=cA#XIJELFYQ,JI5?a
[[9]F>U]=.X8]N;;\MEW1(D4=C;(BX[1,_21B5Tf?J+K+8b(K[R]<=de.=g<26=V
(H3O[d=/N.BT8@8.X,9:#E0b@PK(QEc+eKT85cF+=Q2cI[M0):?XQ#X@8fN2X@#V
[-O2c/;&\DFV9df>/6B<DNKB9:(9.]L-^DR/7-;+3(&(4([PgX_f?Eg&US^/EIMX
-95X7@P3PI3Xe]H&>ZZ^W73ALWd@Zb^R,:1HY?Ed@8YHDP6C3;dWS^4CT@?.G@OD
.8>8C_eR5940dSI#\EG?ZG6gH6?+ACM]EDW9?PR[>EEUU.2Q.aI4ZG(.eWNW>#EJ
/(PBE[2eY=P0I-DWf+C_G8HG^aB<DEA,KDIQP^/MLd/)]S>._IQ7IV5F?>HDTK=>
DQ_5>g@DQRDUVbRIdS+ZBLGCFG76UPDb,9EY-#-AJ]eE2H&@_g?VPCT>9RAAQ<)J
8cY?\UJXY&H=^9Fb6L#)>E+6Q5+?>_DE^&(XYUR_=5Qg=^ae:IDf^gb_]GZ9KV.:
)-SIb[>1C(Je5[bW3E3?OL.CB-#H?bA[bMIMa)P-,2a64/US3a:-DQM3VD1CP4KA
W&)GfRHF[;U#@7bLS^SL2(E:GRHB,9gQaY5[GHagTC6.@+3DLV,SdA<VP1GMO3e^
BV=A^IR4T2W)a:;JD;_7683,IYR=+A/Df8I.JC1SG5KS8ZD@A7#^,N2/b\B2-46F
-4+^FB4?N^b.5U?7eQ3Q.Y6-BS)GO]O:GO<Y_3gZ+U,UB81BI]L8<<.cAac\g0Vc
^A3Ma;bKB)M9aJ>8:Jg4Z2.XJ&2FbTWdUD(d(]XIbX9H<&T72L;5a@9-KTK-UeXO
PCKDCC<UPS/W/Ee.8B#,2N(&5fTRJH[YNg<VB#/Z2fX_BGfcBPQG;-.TMd9cb0-N
83PB7AA&cMB^c#G>M#5S?G<WZa3R:98=16S.B#OX+WBIDJf:EWCLGW85IMP(Z05@
O/H5:.Wb>F0Z;e]0FPRc)cgOQ,VOgf[=4(bOLX)&<X]agB73N?<]Y40[8f.<_&KA
Ke>\OW2#AMZg.T=bH?fJRPdU2\>+U)U3Y]bU^38gfIZ51J<2#A9:EeG3@YK<VFRI
#g=],=_+T1/@O,KCYc+?;X.XN+2>PB[EEJ@X])3_+FH=^PCQBX\_#6MVH,#N:e80
P,IHT#H7+^fCg/U^]+bWP]]5VAEZ9HA@b=bM.cE&WUVY[TLU<-\]bZ<f0aa/I&K?
QbcfS_07JK7>I;3d,,=5QJ.1Q<-XEd,XPKbU\fX&I^V=X:/_9VVe@13F>f,4VKT;
L[AQO3dY]+c&LGRR<XYS/GbB[OW:)CBeJKADK/O:c)?(;[GL8,E99W-.FX_3>=X?
NW;SXVU#EY_W#f6SI7RA;g)M:H5R5LZ@\X+\]2@bPTfR\?aS,AC2-KUb6I]F&K;a
@PR7J^[IV,:F:CF5b;L8A^.E8]E<ZC)+F<(R\70gV&.OZ>c8I@CS.QNB3K<3]5aD
dJ8b8=#\ZGNF0$
`endprotected


//svt_vcs_lic_vip_protect
`protected
#4]c?(aM92C:--NLS;fE4e2-4g8ED_MM6U<73_4<6&)cS=BN].YG,(]@[E0>.b-H
]<)UIK[[HRGc26X4>&9FS0[_2B8BY#A,VGB@24_D]5\g(DFV3a5DcPaS8?W#;4A&
UW2/VO.CV8+N@)JE5;IZH[ePFe981XDC=QfD?LXQHLbQPSMR83eeY^^(&b,6J?#V
\/Bf]eO;CQPCY0B55BW8IX6D0a8#)<Q:S\//VLC&(CD]G55A,6_4\GH.>SRJ>20=
0P.Y@A1J6SP1@^-OF^\c>UP58NIR?46H,(B^9T],VB(-[(KV8Z1GO6H(14?EZZB>
C,@a<XDSO-A:SPCGZ2,9.FD^c=:R\[)^Ve>4C0e,b&>^M[7G\3+]#\OF).Y3;BJW
F\)]\D6+3f]U<8PfRHQ(5(BDcCPVU8-^J?Z[2TgP+<PL:V3#:BKc6MOf/cR1c/gT
gfQ(-?;cK#.4VZ0g6RRfNL?,aX9aC<SGV&_4;6HHC(;I;_^/Ge>eGaY8S^GY@#b&
&APPD4f&5d[D]D5]EY3D<2R\V&4-KR\04=[3+f2JRM\]7I9(3>;^RC;NRZSXbV8=
(-(2Q#:B[]BQGWP.7GL#?@d<V;A#;MZ4Z^aQ6L:?U6eE2(>BI0V:c9f@T,aa(bNb
RZ9S\gY64Wba?H=MRU[VY?9T4N&,/(C\e9B@dC=/cBe+g\<-3DcCAg@\W9)3B3@9
T:;RLA,26J1&HK(,PX._Ub:E]K:UeKI;HUd;+Af4VYXbeAP0&OYE<B-eF67@d++?
.J>+0He8VXRBU&f:Y?\3PNVP&IIeF#3QagW;U+E7NT65RWI<GFV;&A,][Z8WHX-g
GeKWB5ZLg8YdSX&OP,g;)<A<X19XEg2;-=).O[?971UWSeQ=I+&F/c?I\T6<=18R
F8ZeDL-1gK&6X=3Y?Yg_L?be_g0VAXO9<005H0[ZEfM,9(-\L2)g[YJ<.b3R9J3W
OU52)F2D:c988=AV4gP(UC;NcYGcN7]GGQ.9Sg&8ReBVe[0[,J+M+R_(M,DJNOX]
TTY9F<T>VZ8@f&4S@XTTW[,Y@KL6NKfPBT:=SF2H5c^VYa,Nd7C;Me?CTB(2TfEb
+K5;.;3@[C89:JfBH0W1S-YGbIg[[Z4#]SgJ\OUdPRO8M]O/J\cF<UfaWZPR+fe+
Y,LGGLEREBJXgdFLe5H5L,<<a]H=36J7,C\e]A_Nc\f/;;T8AVYLb:45?>;):?#E
(GY3P?0K&)9W_;;M<A19AG3K3H6I925\<$
`endprotected


`protected
8CZ[NgK)V;&RV5D]DJE,1fOHEf69MX0.a/L6,EF:TdL2E]Jf0.&d())5EJIRXMH9
7aGB1EfW)T0HcG93]E/J@e,:25WedXB_27-f?e^G?,g05gBBJZEHXA[7&SAB2;Oe
3-fT8I9>?Y7g571K#W7<8C^7H@]</VfX1B\4M>8fZ4;1^V:/FQT4..IAPFfP=T&Q
RKg6c,G6WON:JaQF_P>[IQ/4P<IdKK6[d-9C/]Lcg605L6&5@]#7EJUDdUKC[HWR
&8<#RU@8,TC(WG3eUO+#]X7:9^S_5HG\BP;/J_E2@_QLW-3\@[aDY6:K<BFO\d6^
I-0g0A]g99SF-fO<N,A@Z8b2Z=EO<JNb5VW[4O/f+S?O?Qb3MV]RWNP/S[OM.(2-
+dPcPCafR)U?].g4WL<]301=1X+.STQfHU4GDZ(dJ>fdO@gZ\4,XS8^F2L3gAU#f
DbcP1.R5:<^(f2T>P[OSE;1<b;KJ>a#Z+^Q>cLGB4?Y-3N=@Ad^PDeO555X,WD]Y
YaB8c/WR[6(+ZQ/LSE^:<SXaP?/R6AK201Q#G@G9,LEMa;S/D5FNP4-P3Q:H>22>
(N]@4L@A-?V5[IVg28V?HWG+IJXIKaGZgD^WM6,?KVMKH@P795.ca,QKLFJUUH^1
J18SG>HD4R?(\:O_F_,LF#VH0>,[fQI5gfJ<aL4R;K\M\1g#Nf5]F&-TN9G<GQ>5
&@^KRWD#V^2-\\RCKY^YL\EB,G4gVc[Z>aG;^2O;.EKR73]3@N/7_Q\C+XP6bJdR
534R.PLV?]&Z)S_DE&GBJd\:gH.[SceV6DPcF>D^II@:;5,Id/7+H))5[RKgTa]I
[=YJXgKdKf4-)BeG/O;N6[@T^KR8ZgU(CVR]MdGI@Q_RQO-LbN:K+Ia@Y^:9GX]G
6I.,dVI?+Hc<3^:CA+>3AHI<KC/FOU#\Ve:9a_<1IfS0XIU0JB<5.d9-TKG<IJUW
G=_JT&N)3#eOd^R>Q@0<FCX/C^H2VNCP7=((DJ7bZ7INCH.AM?DKJ,:_SV]UF#0@
=12bLKb-K.)T/=1(e;[LSRK1gVdL]OD[c[PE_18X#[7T6K,9VJ:6(D;MfTXWb2A@
FFXPbK;SB(e(_>5-baM?>,ZP&c+AGRF>(8M6;b7P,N3+9/c[P;85Z;E[6Bg\K3@I
S7YY;DN1CPZXf)09QSJNGe&+S<b^Y0G.S8Mea:NVV?W<;JeA?4a>W1-H8(N_DR[A
9Ba[Q6,+#fI/#Lf&[?V&2S#OR<0:;ffbX71B2bM\Ab<;BBT;+KQQ=G7#GL?9-JKM
[)5C6PbWDcU/0$
`endprotected


//svt_vcs_lic_vip_protect
`protected
DWK&gU5RSZ<2(PXQ/aT+B4@##@CT.21SP=R5Xg8UK7F<VNgLPK>f5(R@I.L,_0WD
H2#1.eE&^S.UT:+=bL^.#)W7MSHPFRTg2ecUH(8ZfEJW.T/cLJXb[C7UdSU#<B>I
_<;Y2EN-X[.WI3O]>L<T^#=S5^:1B.6^:N<#Y;L8SIgQ?&IEN-.F(<A-+2BSa,/Q
YXP2QW>X;Z403]AM@TE76<2)^R0MLc?fRBKU3&N.dT?3ZLPd2<-#P@=&5P<=DQTf
<B1_+MJP0NE-?Mg[\+2@&^S>OU(fY)AM\FO9Z#LT]3HBFJF8SVQ=QfZ53/:321ID
IZ=,MCV5SH)29RQZBCPH)9XC:56<9HP-UXL<I8X9Y7H?_cLP/@IZ9EfZ1fU,+UcK
eCQ-.GeA1Jd\BgE-(X)]+L6Q\a^?,gEMV4_(gg25df@A]59ZA8K.V[N_3TWeOZCH
fCAX0V&a@9_I,M=#0fDY;&=g(9#/7BH6GY]9Z_T,1b)JP?N_f_]9Bd28-6(;\R8_
(34#a]VQaH_0fRH?#9fdgVc\G0PYK;HD>+#X02P]XA:8V(DVO]dBX<:SBc?2S53^
G>:&NQ\6>M?g>)M4DG9^GYXX\UT>d-VB^5ZdODU@_HfOfMVfOO>R:^7/92PW+X#b
Ne;J?RTB\:IgBL]d]2:+5\#Y<>\UCQ,5BWR-D2)J2:]#J-B,USM:5LV2Vd9HTE;>
TfLKfZF=YHfZHPALJ24[KRV^c>g0gPJ5\2V]-+g[PZNWM4T9X[J93)X_&^cYX:QF
+70JCC9aD\@1T0EZRa&&1c@M^EUOP=VfYCbJ=9W7(?1PQ06J-&37A1WJcLYfK9@,
=dXa)6#J,=#aLE77-e1:W[O+^dETgcLVfV:\=R/I-:<[TW>;aC>^d.FOJ)E;QN5U
#^e0M,SF\dL)VX7=a6@4BWDBP?9:)/d5[/E1L+gP3H@@EU?+ZV]2OF-H?9S:d5cW
[.B##TO?3fdHNECgVV:W1f\F/91d-HU\]C=Q?\UK^:cW7TN=&3bBBA)KO^/HUVH2
+PU#,4^5CPM6IbD^(@?([(ad9U?c[W03F_]3_K.IQ#Z3#\7F[KM2FQ<QP(.(EY;W
I^944A\Q=aMC(eb.d&Ge5Y/[S/_,_21/HF80274NCb2DET6.(7&Gd+)UA84BR<Zg
#I6a:E855Ha;2X_ON@b/\DTY=111G+96EJIQKU9[bJ@/(=CTZVHG2/(IW;PUG1G/
LT@^#RUScF1,(X5X/GN)cJd\C7])e=OU8AD6\CO9=S,9eNI^\P;+8+,FdBG(Z/6B
MJe&e4-e#2AF]FT8[Wef3:2P17T]6cI+\Pd.c]9XfF2J/2R]UaL6bEg;62,Nc4YI
/A3>g\DHN23))3bU2gQ+C&57V^(57FG#U;(7CVN652+>4/KK[[?@-?bgWS\)PO]J
^X0d2=ZU&9W3-A]K7PBO#8J_>A.cOLD5B2+;EH<C5NM3a7/F?SX13]^-EdN&V:>;
EJ#KS>KB;c._#R/Rg46aO1LL78;8AJ,J0M8KU&^eX4L>a2)O[:TR6ea:U2A2+\ZZ
5b)?,_M?]P(KfJHYVG[WW?<OcW7SF\;)=b)G@0[fN]M>BM:\Z4-T:0QeVa)@P:=b
5R;ceT\=WDVcU7]cFQc.R2G,WO=3d?[=+B5Sa7JIfTe>;H(T/84,++6:SVMZ&^^N
TN8^eN)OZ=L.0H@e<I(Tg;81Z2=[Z=IOEV\R4;4)V#Y6CZJCE@7,Q2:&KZ>BZ(=E
6<+6M1]1FBZ5Y)^DbD^WT]FK1e2:K]8Ic,1BaNd?b5/.VS^]1<BZ2WgF:=PHW&93
^3D^H,WfY8PBGWP><QD-dFQf::IHd:)GHV,5IJeA+@HJR).JQ+[02T[=8#YMf_DQ
FQa:?OR7c(YgKLS/;.U;?DG5\Y+EV_3MM/@V53[-4S;?B+9=9J&KM]W?ZZR]8J/A
XHeN-8O^H)dKYXf^]_Wb-cbc4+[CZ:89IA/.P0CO4c2X/f<8D#YR?d;B3GAad@1c
G(VO(7La&WNOO5DB@Td_Kc1US,&@4>-2F0,eBI[LUYVO,B5TZ&;TE1g40)BgS(40
33Q-2Q<,M=LIccX(SKX4M,BX2X^Q\C2KVG_#MNeB(b7CUHQH)?T/a5(#IE;E5;fa
KWUKEZUI+[@2@BDg0H-D.S3YBMAS:c.,5gcLLBNG]gfS:TQ/QP,]BRTZX=XB]d^V
P2Z]P0)]/8HH\g26H(dT@-7/8OKaU&N#S6;UFg.HR?K/N1G<[34@M1[97PCZC?YP
&2@=ed#U:L?WNW.7C&<9R7eN.Sg7BEB1S(f&)PYc7?Z;GH^=e3I(+]6BR]a6Ag>C
9^&0R/g\R^OQ.WeHAf^_W05R,f2DCOVZ\G)=6Q]BDOY8dH_cU5@D?[c&)[AeAgIc
A/:DR[,A)^&L]2D^4E(592c1LEO#+?0./5aO##_@0ca.b>J&D#QDO[gAe#?6K2.a
;Ndf^+b0W?[W6XJ?G.cXT@4K4GW3UaZgD0B,4EF^93:&>2D32VE0@=_RLZL<1I95
19#/b1]g]+.V;M:AK1(M<B=+f[^QT?WG5+/G]JX;ISQ#J[AGH,E/IL?TQL.#U?7c
#FXB?,<4.Ib/C0M9K:B[b;HW+TX6ae6.>.CPXG2&OO0/TN28Ra\1BSdP?-(??:#=
L;MT4PPR/MV+ZLfVa1[/a6M1SLSRgc+<GW4/W.5=SRB5cQP,CS4FfTM.#cQDfb(&
4X7:0P28[7=7cK]GSB_O>=&FDe6/4D#0G04cHa>@=YKK=fU)F#3L3F=;<R-44Bd/
Ca/-3Kg5A(,g_HDHRM^6OeW,H8W;Oa(DA(B)UOC[/D/1>]Z?0FW==:7EE;TR#;Y>
a=<FTc><&:A5DBYQEc2:4g:;QaDPG77^+3U:(1:X])2&?cS#S]2_YK0<589-bTTL
&+Cb6M.HC8F-I36^(EM3D?0:OUg?fZ\#1fRY)R\M#DVFGH;7>eLa?/?N&S\c(Q@_
=G63:INOTJaD;-Ee9(bWQ5@#[E6SXW#]JJ?L+4:R=HNZ95Q>ZH3#V7C)E:<NK4O&
S+.YKE>#9K?DDP?P+-._D2OO&4HF#L=AWfPd_/dX#F^ISSHgW[BLW53dP/E\_#Og
+5c,89D)B&Tc/2W&L)PQV[3@Yc;&:14KLJ-[YGdLA9ZPGNP>K21/U2:_TL)CZC0F
6=E<4[b<(57D<)dO2=a)4/\.GZ2/gFSeWb&LdR1P55L9Z8WWdH)7)SE];C_>c<G:
PMFN#8CCSC1SC:ZMN,>E23)2OGA;2+I,Ma5A+SeK&)_[DVJ.2AA:Na0.N_J+LS=(
G,WO,J4/C+FKG4&4Ae8UJVdTFLG<,5<KfVUT853>-c09?W(:DfFeacG-[21\]&K?
2BYDa;eVLef_>3)e)5O^(4PMK\E+D/^,_8I8#bdY9^[1\A@2f-/I]I4/)V09G^fd
&Y7+]2L[aeD;-MU>79:=S,5WOCC<d[608<T:ZVVYDdF&S3;6]AB.fD/#\M0TfV#3
I2E6JF,8Xf<]8OVHffB9+6.L(=UXHb59GVHAO>P-XPE&;dBSd)b0.B(B8WD,SBc-
+?2H20X@e5B(/+\9JOODZQ&+MW&Kd##_>X3.B._PG<9>9b_U9U5M7O)RJ48\A&TY
=1]6<Z1HT?=OeGCc]cga[[Q_dKU^:P,IAHH=OPXXg.a2B2<-ZTZ)eY]K5BAC-C#]
c_LPN/e22&)7J-?44DGL/ZL7GPZUePWb4GcB5HANUU8WQQ?XV;MJZAd922Ib002P
PD=@57#>)1E;GeJb42D(cC=)7\^gIMWe5U(IA)421Le[YaUc>U4R.V(0^W/N6(6H
;I.Yg-O:BBS\0H@HRCN6_4RJT34VPY>8PU-Rc3URAa()5=@LN8X3L5VcRAE98<eb
VW3T\f]I,A&[:;WT4bIZ#QJ,86MfX<;W2V:13e>FUf;#_D.bELNJ\L<C+T);MBO^
@FeT\P1?bXc>F-#=S8E\8J1_?@;1cSR1CeN4N.YHbZ5^#RK>c\[UNO9IZR.77KL6
DB>08b9KAg41)Qb)&-:>M9La())H\TZSZgJ3OQK/;NBWAZGOKHXY@_H2Kg0)#/18
#AaTLZ)9)9-6/d,GE3[afDAcR:<IZ;RFYA(ZE/65)fA)b[=JKO-UecNCV?)S&4,9
&VIEJ7ggQPFN2D)gXV<C)WI/FbgB?S^]<)2f1N>_d,6VV-e9X/0U+V@:4T>EK1G>
T6(ZO(&Ad3)[>(=G7/R:2K/c73d;2,_M>?R0.9]ANFK7-3[a:XGY=?Mc.C?6CcKg
#bWc:Z/_ZaCg19cE:fK642bKKBXbATCR@C)Q0]SM1V_NBPVB2MaK.XQ[1ed\TPPL
2be\6B[(P(aRVPF3/;,GONJ8(K5\7fd>BL<7]>RV=J+gWP3g>#D5,G-DGN?ceHXK
CRd8OL;G4WVHFaabL8X_-_?/f1RR0<f@J-+_bJb69_INE+&W?-B&5._d+a+XTfQV
2)=97&3a)g<gD(6=P0Sb(.&CDd(]Pg6Q0H\\.Wb+DDESST3e]URDA#:_IM@H6?:-
TWZbe4Z-@-V4e+F-dCZaca@;_&&Uf@P,ZS\:#N;a]d5@X2XCPLc@:NT5g7PS=D5Y
<3&-VEMUCU=O#e844/\(;=deD)3G<9]Oa#I16ZaD(;g(b55<H>Pb/AZ<GUd9?56[
eP;)#&_8Y?+QcMT#;d,FaZXb8eO95d1L_[,F<N7,.LSY^MEF/cK\g+TR#JO/VX-V
^MCM0BeCAL0D4OddP9g<+(N+Q37=\>8cFWU;E>?WPAfRHN)+(eMd5Z>0^RAI9VRO
3gF(02^\VVg6#QZ?)\Gg/M-3eO<C.CgPV<)PLF<2Y,555ALYbT8;]>YADf1=U[5^
F;IdAG>>ZLS00,9>2KREJEKEWLFM)FB3F<9.,KO8L?A;^TBgSJ6MQ)7M(@&K>KT:
0dP@;R&<(I]?F()NfO;Hd:ENJWUTg1Agd4CR(JS^>8S?bI09]^A>#EZJ\b9^3._A
7eH;LY\RL(g6GaI\>Yd9,b.GH/W+S+N57&@2\6Q6-#:fC6;V+C0>b4bY[UQN[dWJ
&-<856D&9W#WH?7HF5dKX1_feRJ&&3BdWT#3+C9eARKAc[ZETV,D(-6OR,&H_](U
8K)?1O:fe@P?cR_c@1d/[X];#dXLL_efQ&&(=/g:>KJV]=O1V7?+f,e^X,P2FP<2
87Z2LK69g(KWD4)#=f/)MEd/VHB&Y@)<10RM17NMAFAE=\V+a;@d=7:^ZEDA2FcV
=b]U3Sc96YAAFB+)(H:898a,bJ^bUYL=\d9=&1D6_-TE/]YKGKLH_dO=7FCUM(GZ
P#)Y@OTF,+#FNFdLaY#S_W_M2gTDYO30?&/cE(FFW[eJCOUXLSZaQSF(5;cV+)3P
[_YN82L46XSG?=0fHKR[OQa+1D]eZP?#g)BS[&(@Lc,OC[0bR-,^<63921N&DK3+
S6ZKCCP\ZKG3g=IfMJL/g^/3@<ZYBS\@=T9f(Iac+7-=>V>XO15F3a^#/Zf.;67#
[.(aX[?aLf124O7cfOYTES<TQA07]feR@[O0T?:,MIQG-LVF7DRe16K;G\7SG.(&
7G=J?XE:#XdX.c@ME,DIAdNX[AVN#YE2DPKd):L7)@OZgH7ZY3,>78OMcdT2YPC8
3(0QP;AEW_RW[J7O;I1X7AVb>^GIG;f9KWd6SIB6@VaXD<>Rd#L3SD>ATe?XQ\.D
gV7[+MI\IMCQ^K6)(bfH^W=(R\P6\5<7H)Z@a[Rg)YF3L[<8HQ@VYDb&-7#MFe46
Y8YCeSV43fTZ6&NO>Heg5[L+(e[gX,53-D13a[gNUIfBJKQ\1T,B_Qg0;\F(1=+^
8Q)CdF6HACf7RJ<2)69S>c:KU/M0VO_O.\++\NK/D3CdT#V66=-N#M>@;A8(E\a^
#9(EU#=-bL)G(f6c8?>#6Q3=REQBLNcNU;CE/@U;aHf:D@.MPASA[Y)@.(S^@@F^
=201aYL^-e-\XNdT)TUEUF+/ANZO71IdJ-B,XbO]YS9]O<AP\Q_d1,ILIR@DOg\=
+EL>AZ]8:)ST8g_OP+&VPH3V;>a,(QO1W@D8[L4:Fd2+[RGf8+VScPbHNNX+0X#-
P]D?@X@]7I3Z\34[?;Z-ZDN;cEULXK?HX6(8g1;7JHa+H$
`endprotected

/** @endcond */

`endif // SVT_UVM_TECHNOLOGY

`endif // GUARD_SVT_BROADCAST_SV


