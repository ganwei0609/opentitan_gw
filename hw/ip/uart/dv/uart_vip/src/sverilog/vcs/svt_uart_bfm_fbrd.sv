
//-------------------------------------------------------------------------------
// To enable baud clock generator based on fractional baud rate divisor
//-------------------------------------------------------------------------------
bit enable_fbrd;

//-------------------------------------------------------------------------------
// This variable holds the value of the fractional part of the divisor when fbrd
// feature is enabled
//-------------------------------------------------------------------------------
real frac_divisor;

//-------------------------------------------------------------------------------
// This variable holds the value of the number of baduX16 cycles over which
// the fractional divisor value will be acheived
//-------------------------------------------------------------------------------
int frac_divisor_period;

//-------------------------------------------------------------------------------
// This variable holds the value over which the value of mult will be rounded
// off to the nearest integer value
//-------------------------------------------------------------------------------
real frac_median;

//-------------------------------------------------------------------------------
// This variable holds the value representing the number of baudX16 cycles to 
// be derived using 'divisor+1' reference clock cycles
//-------------------------------------------------------------------------------
reg [31:0] mult;

//-------------------------------------------------------------------------------
// This variable is used to set the counter reaching a max value equal to the
// value of frac_divisor_period
//-------------------------------------------------------------------------------
int dur_counter;

//-------------------------------------------------------------------------------
// This variable is used as the counter to keep track of the number of
// reference clock cycles used for each baudX16 cycle in fractional baud rate
// generation
//-------------------------------------------------------------------------------
int clk_cnter;

`protected
B+D/K;a^E^gF).PG-X<B_K3=>^YK5O@T2NGg[+We:7[))/L<LOgQ-)AS8)1gNCS1
1?<P\E[B(P^-^+HOI]:^9:YbP(TG5<?b++cFJSH[KE4\Q5Q5UNK.:>6YD/[B)V#1
e54JIS6EQZBS\)RP-B9X4?AV;=,RTGKGf2<:bFL:;^L-cA/?OO+.fL3#Ld?XE:Cf
<HG2^cFb-(bEbT1c&a=[PJa27+C&CK_;g.D;N&e)TN[MVB[P4dSB(YH_Lg]\[JeQ
\dS-7I8?+Y4M4R-_b+F2,RWP[Mb_7)EJI@&,QcVe-48M/>,M@_PX&0_e^/6^KI6b
6IeR6U_[;]6HG/_]DWW33GCH)=g9ER@fY7&9H\4@)Je#\gA7YWF#7?J=&?:+Y>#Y
[;\NCH70-TA66(X^X&OL2YNVS9<.C@T/PVd:R[NLB6#a_F=^2[I8>Q>McT,@=d0L
ICB2+-7?V7c):K&@e]FUf#a4;KHD(U(3:YH5.J=X\NCUbHdXO7I==JXd\[7Mg&dH
DA)1.-KYF=R>WY4P=JBM/CT8OG5g=f2AIdHYRN,P5EWM?H/9UDTY&TMQL7C[f:],
0AD.M?3G]O9T.+^C?R798H?ac;a)5If?U\NHM]Q@P1O/=I/(]b/PW7#P:)c1LQ;2
R?ID/09XP[(74()S1Dg#[=_@b4=L3PB[]GV#Z2]5&4c0dQE6X8,DTO/e1?]_AG9W
4B7Q]S-?L.[WOQ-U1G_f-]67+L?BY5NA_TR>(M93[3@3>=SKfO?#fQd,O]d#V]g\
MUK8-D)(N>I8@460D\Zf4T.D5J\c-HR32)WOU9(RU7OUI&T@E<<@G2\Cc7R[<K/#
b0c4X7RGYcR1F;7\):DEE)#W=g[0.=M/ePKddg2Y0DMeII\551Md8dg]?2g3aR(I
)U@_(V@1YS5cV=,W3._Pb@YPKeO@3E&Te7F@N,,fC+[SG(?/8<-.ZA00KFc@<VO<
^IQ,@_JC?R,DYEH:N34FO#EeT_^d(4I0]0dLb4.e9gRLbb=E#ZLFfJDN)DAF8J:L
6UHaW;D7GLa#Kc3S.H3:82E,AUgcg]XH/b60M.cT0._d+I5QOQd3^2=J(1.D^a-H
DT^:<\egN(ccP3OO):\Z70ZY\2Q9I(3ZFJ5Nda,_Q^dYXLH\&](SMeS9:W^0:UNE
9)OYTEN]-P<d+SC6@g,XQ2MUY8]B/?J+,A7T+A_@<QDRLMXQC:VB4;,[O\7;H>QU
7:7_d=9&Z^+@5OWH@L)JPHI#2e&BY6B18#PWL6MO-2:RG;W?W)IfaQ?JSf[SZ@<-
&A7TWP\5aeGJ33T=-G5Q?^Af\HDDOb(#GR)fN)9E@C.,gHSGE)?<[OZ6(RRfca5&
,QL@cPPgf&TK)2\:ZQ7@+0>COfU^&+T4Cf=DbOcMR6e9RQcHdX14Mde&17WA+S)R
e&2KXC@0_acVd]OBaPaa/_[f/DAFCEJcbIGV\-HI]f0T,S(0Of1L_PN4O)dZXgGN
f@g]_g427Q<[]0S#QZAFH@NOIg3P)Be^A5@+AHI&dZIWKZFW,N,2bNF@-_IBU5g_
0Y5,UL;G\5g#+OB_@J@g[)@AIBb]XY@3gX,\dE^X7AXK_]</@f(=)R?M&GbS0CNf
aM\J?f)d6WG=H7JZd6#-HGfcfDK0bDD,&N:CZ_.8#1LLAN+NfAd67/FdR_OKD.f7
7KZKAgS\S2WKG@,9)eg+MLDTPFC4_5E3CN)\GO1eJT3fP>ECGOc:8U9H<QPHFe/?
R,Y[:#G7Ob^R^;GUKJ2Jf<VM)/X3.@2)9<Ldc5=ZL71&ZMWc4?=:QQV2B)aFKZ^P
_dFL,D5->)?,;THIYfOXW+,PPH@U39DYe\918+7JZ\BfKUP\?O_WD\[#\_b)#762
QAU1^V+T6(9XEf?VK8N_B(7c3Q8)^2]J[PABX.[b;+b:U3>/7gS3)B\H5+b?aaWV
eaJ4@+DSZ6D<I\U/CE6U.#bZV^+c[TcDV>GZ@Ea7.:SH^0>;H?6-a=Y=N2O(+>O6
BQ;_CV:;,Z[(1M.YW_aYQ[Z&:F)T:2IPO5QR^TI4dOB-/W+0_F,53^[bg4;?@b(5
-WZJU07>O+P>b/U[:,gI0:g4Z<MB33/QQ_R>UOYA3cQF87</=VZaZV=NP(9bCD11
K:g1VM?eR41^2+Z1d@G/>>Z]dYT<Wba>&H?IQ_#I9Kb;#FgBBZE3Y?+9U9#;bN5E
SK[fCBLC>#.(8)Z72Ya2+10-?VE+^H?f4a//C_dR6Fb9WgB>.+(<eJ^U9I+:P[T6
dWg3WRF&33D>bKO_;,4cDVa.>3^0)H-?PS87&D>+Y18aB-1TWGgBXbQWUZ><(7Zb
CeNd?U&JB0B3D->SEJ-9:Z/YWDS?-C/;^[98,K;#?\Na(T)FSfP5c,K&7U.;BC)0
C+dH3@VEb[PUUDW<Xe@^EERQN()K(GEJXZ9DUQYfBTF#O+YSAE._CWWBI3:C1DHN
R_>._g7@R_[OLU0[N.Y30cEDbIUP>;^<0dK(:NNfa65f,R+-#FI(I08AS+C<YC;e
5Rc7CY@M\,@C[+@^EJ]&MWJ_^5B;cJBHXER?L9/fG.-DY[_PV?0#G?5@#JNdLg#B
@G1b<#W)SI/1-I<>bT,:f5dV5\@R8dPHeX1@AfgFR+ON6a7d;M\eTU5[\6V5RE.D
RSCA1A-ed#Z^E[;a6XS1A:_7dXC>a?Xa;P+05KSe\2\0J2(K]T#X[R3L3f=/RC[_
Af\O[dg(bJcUGVDg4DN.D#ZK3]=G2I>(SUeTP^O[LD]&G7QRe99=NeWP-b0AY3M=
](4G\U=^]4Z3NeeE04<96baO(6P_Z13,3Bbe8V0&32:?=d9cS+5LgLCG7dBbd.d?
6Sfd-/W21PXf)Q<0F0?U4]@0<ZL43G7FM]T^]#f>eOD#V7G3:F9#J,C4B70;QL(M
TM(O(R?N8I4g@1NJU/)LG]7+C-94=SVdb[)9[K9?]T[A2>_08De^[Ddd.6I&Q.Sa
C_<W17:HgcA9=G;UYYNEDV6P4G81RE\<P,Q1/B1LREK>)Bg^3.<gRY?._-B0)O&7
+I7b[dY7D/+84?711.d&R+L&T\)WeZ+:VJM-<Z5E-IEW:@C);R+gg]2_<;NC?N\<
Z)aE0+Kd[[6[](>X01UF+N/CNG^=#3LF<KGVT3.2S.#5G&b238-b]J@1AS(W1FDC
.NZQRMB^U)&.SCaWJMGZU0bB:8_.7E:+MOL/2]5:C^&MBbB>dVGN>]\[-ZP[#fHKR$
`endprotected

