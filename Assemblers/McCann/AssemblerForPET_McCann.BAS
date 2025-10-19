From [A Simple 6502 Assembler for the PET, Michael J. McCann, No. 6 Aug-Sept 1978 MICRO-The 6502 Journal, pp 17-21](https://archive.org/details/micro-6502-journal-6)


## Bugs

Bug in 6060, missing "NULL,0"

## Notes

## TODO

## Filename

ASSMCCN

## Code

1 REM 6502 ASSEMBLER PROGRAM
2 REM BY MICHAEL J. MCCANN
3 REM FOR USE ON THE COMMODORE PET
10 DIM MN$(256),BY$(256),CO$(16)
20 FOR E=0 TO 255
30 READ MN$(E),BY$(E)
40 NEXT
60 FOR E=0 TO 15
70 READ CO$(E)
80 NEXT
90 PRINT CHR$(147):PRINT
100 PRINT"1-INPUT SOURCE CODE AND ASSEMBLE":PRINT
110 PRINT"2-SAVE OBJECT CODE ON TAPE":PRINT
120 PRINT"3-LOAD OBJECT CODE FROM TAPE":PRINT
130 PRINT"4-RUN MACHINE LANGUAGE PROGRAM WITH SYS"
140 PRINT"5-RUN MACHINE LANGUAGE PROGRAM WITH USR"
150 PRINT"6-LIST MACHINE LANGUAGE PROGRAM"
180 GET A$:IF A$="" GOTO 180
190 IF VAL(A$)=0 OR VAL(A$)>6 GOTO 180
200 ON VAL(A$) GOSUB 14000,20000,9000,10000,11000,2900


210 GOTO 90
1000 SX=INT(DC/16)
1010 UN=DC-(SX«16)
1020 SX$=CO$(SX)
1030 UN$=CO$(UN)
1040 HX$=SX$+UN$
1050 RETURN
2900 PRINT CHR$(147)
2910 INPUT"START ADDRESS";AD:I=0
3000 IF I=24 GOTO 5050
3001 I=I+1
3005 IB=PEEK(AD)
3015 IF MN$(IB)<>"NULL" GOTO 3050
3025 DC=IB:GOSUB 1000:GOSUB 13000
3030 PRINT AD;AD$ TAB(12) HX$ "*"
3040 AD=AD+1:GOTO 3000
3050 ON BY$(IB) GOTO 3060,3090,4050
3060 DC=IB:GOSUB 1000:GOSUB 13000
3070 PRINT AD;AD$ TAB(12);HX$;TAB(21);MN$(IB)
3075 AD=AD+1
3080 GOTO 5030
3090 DC=IB:GOSUB 1000
4000 B1$=HX$
4010 DC=PEEK(AD+1):GOSUB 1000
4011 B2$=HX$
4024 GOSUB 13000:P=DC
4030 PRINT AD;AD$ TAB(12);BU;" ";B2$;TAB(21);MN$(IB);TAB(27);P

4035 AD=AD+2
4040 GOTO 5030
4050 DC=IB:GOSUB 1000
4060 B1$=HX$
4070 DC=PEEK(AD+1):GOSUB 1000
4080 B2$=HX$
4090 DC=PEEK(AD+2):GOSUB 1000





5000 B3$=HX$
5010 OP=PEEK(AD+1)+(PEEK(AD+2)*256)
5011 GOSUB 13000
5020 PRINT AD;AD$ TAB(12);B1$;" ";B2$;" ";B3$;TAB(21);MN$(IB);TAB(27) OP
5025 AD=AD+3
5030 GOTO 3000
5050 GET A$:IF A$="" GOTO 5050
5051 IF A$=CHR$(19) THEN I=0:RETURN
5052 IF A$<>CHR$(13) GOTO 5050
5070 I=0:PRINT CHR$(147)
5080 GOTO 3000
6000 DATA BRK,1,ORAIX,2,NULL,0,NULL,0,NULL,0,ORAZ,2,ASL,2,NULL,0,PHP,1
6010 DATA ORAIM,2,ASLA,1,NULL,0,NULL,0,ORA,3,ASL,3,NULL,0,BPL,2,ORAIY,2
6020 DATA NULL,0,NULL,0,NULL,0,ORAZX,2,ASLZX,2,NULL,0,CLC,1,ORAY,3
6030 DATA NULL,0,NULL,0,NULL,0,ORAX,3,ASLX,3,NULL,0,JSR,3,ANDIX,2,NULL,0
6040 DATA NULL,0,BITZ,2,ANDZ,2,ROLZ,2,NULL,0,PLP,1,ANDIM,2,ROLA,1,NULL,0
6050 DATA BIT,3,AND,3,ROL,3,NULL,0,BMI,2,ANDIY,2,NULL,0,NULL,0,NULL,0
6060 DATA ANDZX,2,ROLZX,2,NULL,0,SEC,1,ANDY,3,NULL,0,NULL,0,ANDX,3
6060 DATA ANDZX,2,ROLZX,2,NULL,0,SEC,1,ANDY,3,NULL,0,NULL,0,NULL,0,ANDX,3
6070 DATA ROLX,3,NULL,0,RTI,1,EORIX,2,NULL,0,NULL,0,NULL,0,EORZ,2,LSRZ,2
6080 DATA NULL,0,PHA,1,EORIM,2,LSRA,1,NULL,0,JMP,3,EOR,3,LSR,3,NULL,0
6090 DATA BVC,2,EORIY,2,NULL,0,NULL,0,NULL,0,EORZX,2,LSRZX,2,NULL,0
6100 DATA CLC,1,EORY,3,NULL,0,NULL,0,NULL,0,EORX,3,LSRX,3,NULL,0,RTS,1
6110 DATA ADCIX,2,NULL,0,NULL,0,NULL,0,ADCZ,2,RORZ,2,NULL,0,PLA,1,ADCIM,2
6120 DATA RORA,1,NULL,0,JMI,3,ADC,3,ROR,3,NULL,0,BVS,2,ADCIY,2,NULL,0
6130 DATA NULL,0,NULL,0,ADCZX,2,RORZX,2,NULL,0,SEI,1,ADCY,3,NULL,0,NULL,0
6140 DATA NULL,0,ADCX,3,RORX,3,NULL,0,NULL,0,STAIX,2,NULL,0,NULL,0,STYZ,2
6150 DATA STAZ,2,STXZ,2,NULL,0,DEY,1,NULL,0,TXA,1,NULL,0,STY,3,STA,3
6160 DATA STX,3,NULL,0,BCC,2,STAIY,2,NULL,0,NULL,0,STYZX,2,STAZX,2,STXZY,2
6170 DATA NULL,0,TYA,1,STAY,3,TXS,1,NULL,0,NULL,0,STAX,3,NULL,0,NULL,0
6180 DATA LDYIM,2,LDAIX,2,LDXIM,2,NULL,0,LDYZ,2,LDAZ,2,LDXZ,2,NULL,0
6190 DATA TAY,1,LDAIM,2,TAX,1,NULL,0,LDY,3,LDA,3,LDX,3,NULL,0,BCS,2
6200 DATA LDAIY,2,NULL,0,NULL,0,LDYZX,2,LDAZX,2,LDXZY,2,NULL,0,CLV,1
6210 DATA LDAY,3,TSX,1,NULL,0,LDYX,3,LDAX,3,LDXY,3,NULL,0,CPYIM,2,CMPIX,2
6220 DATA NULL,0,NULL,0,CPYZ,2,CMPZ,2,DECZ,2,NULL,0,INY,1,CMPIM,2,DEX,1
6230 DATA NULL,0,CPY,3,CMP,3,DEC,3,NULL,0,BNE,2,CMPIY,2,NULL,0,NULL,0
6240 DATA NULL,0,CMPZX,2,DECZX,2,NULL,0,CLD,1,CMPY,3,NULL,0,NULL,0,NULL,0
6250 DATA CMPX,3,DECX,3,NULL,0,CPXIM,2,SBCIX,2,NULL,0,NULL,0,CPX,2,SBCZ,2
6260 DATA INCZ,2,NULL,0,INX,1,SBCIM,2,NOP,1,NULL,0,CPX,3,SBC,3,INC,3
6270 DATA NULL,0,BEQ,2,SBCIY,2,NULL,0,NULL,0,NULL,0,SBCZX,2,INCZX,2,NULL,0,SED,1
6270 DATA NULL,0,BEQ,2,SBCIY,2,NULL,0,NULL,0,NULL,0,SBCZX,2,INCZX,2,NULL,0
6280 DATA SBCY,3,NULL,0,NULL,0,NULL,0,SBCX,3,INCX,3,NULL,0
6280 DATA SED,1,SBCY,3,NULL,0,NULL,0,NULL,0,SBCX,3,INCX,3,NULL,0
6290 DATA 0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F
9000 PRINT CHR$(147)
9010 INPUT "ENTER FILE NAME";N$


9020 OPEN 1,1,0,N$
9030 INPUT#1,ZZ
9040 INPUT#1,EN
9050 FOR AD=ZZ TO EN
9060 INPUT#1,DASl
9070 POKE AD,DASl
9080 NEXT
9090 CLOSE 1
9100 RETURN






10000 PRINT CHR$(147)
10010 INPUT "ENTER ADDRESS IN BASE 10";AD
10015 IF AD>65535 GOTO 10000
10020 SYS(AD)
10030 RETURN
11000 PRINT CHR$(147)
11010 INPUT"ENTER ACCUMULATOR VALUE";AC
11015 IF AC<0 OR A0255 GOTO 11010
11020 INPUT"ENTER ADDRESS IN BASE 10";AD
11030 POKE 2,INT(AD/256)
11040 POKE 1,AD-(INT(AD/256)*256)
11050 X=USR(AC)
11060 RETURN
13000 A=AD:S3=INT(AD/4096)
13002 A=A-S3«4096
13010 S2=INT(A/256)
13012 A=A-S2*256
13020 S=INT(A/16)
13060 U=AD-(S3*4096+S2*256+S*16)
13070 S3$=CO$(S3)
13080 S2$=CO$(S2)
13090 S$=CO$(S)
13100 U$=CO$(U)
13110 AD$=S3$+S2$+S$+U$
13120 RETURN
14000 PRINT CHR$(147):AD=826:ZZ=826
14010 PRINT "(MNEMONIC) (SPACE) (OPERAND)"
14020 GOSUB 15000
14030 F=0
14040 FOR E=0 TO 255
14050 IF MN$=MN$(E) THEN BY=BY$(E):F=1:CD=E:E=256
14060 NEXT
14070 IF F=0 GOTO 14260
14080 ON BY GOSUB 14100,14130,14180
14090 GOTO 14020
14100 POKE AD,CD
14110 AD=AD+1
14120 RETURN
14130 IF OP>255 OR OP<0 THEN PRINT "ERROR":RETURN
14140 POKE AD,CD
14150 POKE AD+1,OP
14160 AD=AD+2
14170 RETURN
14180 IF OP>65535 OR OP<0 THEN PRINT "ERROR":RETURN



14190 POKE AD, CD
14200 B2=INT(OP/256)
14210 B1=OP-(B2*256)
14220 POKE AD+1,B1
14230 POKE AD+2,B2
14240 AD=AD+3
14250 RETURN
14260 IF MN$="ORG" OR MN$="END" OR MN$="DC" GOTO 14280
14270 PRINT "ERROR":GOTO 14020
14280 IF MN$="ORG" GOTO 14300
14290 GOTO 14340
14300 IF F0=1 THEN PRINT "ERROR":GOTO 14020
14310 F0=1
14320 AD=OP:ZZ=OP
14330 GOTO 14020 






14340 IF MN$="END" GOTO 14360
14350 GOTO 14380
14360 EN=AD-1
14370 RETURN
14480 POKE AD, OP
14510 AD=AD+1
14520 GOTO 14020
15000 INPUT A$
15010 IF LEN(A$)<3 THEN PRINT "ERROR":GOTO 15000
15020 IF LEN(A$)=3 THEN MN$=A$:OP=0:RETURN
15030 S=0:FOR M=1 TO LEN(A$)
15040 IF MID$(A$,M,1)=" " THEN S=M:M=LEN(A$)
15050 NEXT
15060 IF S=0 THEN MN$=A$:RETURN
15070 MN$=LEFT$(A$,S-1)
15080 OP=VAL(RIGHT$(A$,LEN(A$)-S))
15090 RETURN
20000 PRINT CHR$(147):SZ=0
20010 INPUT "ENTER PROGRAM NAME";N$
20020 OPEN 1,1,1,N$
20030 PRINT#1,ZZ:DA$=ZZ:GOSUB 20110
20040 PRINT#1,EN:DA$=EN:GOSUB 20110
20050 FOR AD=ZZ TO EN
20060 DA$=PEEK(AD)
20070 PRINT#1,DA$:GOSUB 20110
20080 NEXT
20090 CLOSE 1
20100 RETURN
20110 SZ=LEN(STR$(DA$))+SZ+1
20120 IF SZ<192 THEN RETURN
20130 POKE 59411,53
20140 T=TI
20150 IF (TI-T)<6 GOTO 20150
20160 POKE 59411,61
20170 SZ=SZ-191
20180 RETURN






1 rem 6502 assembler program
2 rem by michael j. mccann
3 rem for use on the commodore pet
10 dim mn$(256),by$(256),co$(16)
20 for e=0 to 255
30 read mn$(e),by$(e)
35 rem print mn$(e),by$(e)
40 next
60 for e=0 to 15
70 read co$(e)
80 next
90 print chr$(147):print
100 print"1-input source code and assemble":print
110 print"2-save object code on tape":print
120 print"3-load object code from tape":print
130 print"4-run machine language program with sys"
140 print"5-run machine language program with usr"
150 print"6-list machine language program"
180 get a$:if a$="" goto 180
190 if val(a$)=0 or val(a$)>6 goto 180
200 on val(a$) gosub 14000,20000,9000,10000,11000,2900


210 goto 90
1000 sx=int(dc/16)
1010 un=dc-(sx«16)
1020 sx$=co$(sx)
1030 un$=co$(un)
1040 hx$=sx$+un$
1050 return
2900 print chr$(147)
2910 input"start address";ad:i=0
3000 if i=24 goto 5050
3001 i=i+1
3005 ib=peek(ad)
3015 if mn$(ib)<>"null" goto 3050
3025 dc=ib:gosub 1000:gosub 13000
3030 print ad;ad$ tab(12) hx$ "*"
3040 ad=ad+1:goto 3000
3050 on by$(ib) goto 3060,3090,4050
3060 dc=ib:gosub 1000:gosub 13000
3070 print ad;ad$ tab(12);hx$;tab(21);mn$(ib)
3075 ad=ad+1
3080 goto 5030
3090 dc=ib:gosub 1000
4000 b1$=hx$
4010 dc=peek(ad+1):gosub 1000
4011 b2$=hx$
4024 gosub 13000:p=dc
4030 print ad;ad$ tab(12);bu;" ";b2$;tab(21);mn$(ib);tab(27);p

4035 ad=ad+2
4040 goto 5030
4050 dc=ib:gosub 1000
4060 b1$=hx$
4070 dc=peek(ad+1):gosub 1000
4080 b2$=hx$
4090 dc=peek(ad+2):gosub 1000





5000 b3$=hx$
5010 op=peek(ad+1)+(peek(ad+2)*256)
5011 gosub 13000
5020 print ad;ad$ tab(12);b1$;" ";b2$;" ";b3$;tab(21);mn$(ib);tab(27) op
5025 ad=ad+3
5030 goto 3000
5050 get a$:if a$="" goto 5050
5051 if a$=chr$(19) then i=0:return
5052 if a$<>chr$(13) goto 5050
5070 i=0:print chr$(147)
5080 goto 3000
6000 data brk,1,oraix,2,null,0,null,0,null,0,oraz,2,asl,2,null,0,php,1
6010 data oraim,2,asla,1,null,0,null,0,ora,3,asl,3,null,0,bpl,2,oraiy,2
6020 data null,0,null,0,null,0,orazx,2,aslzx,2,null,0,clc,1,oray,3
6030 data null,0,null,0,null,0,orax,3,aslx,3,null,0,jsr,3,andix,2,null,0
6040 data null,0,bitz,2,andz,2,rolz,2,null,0,plp,1,andim,2,rola,1,null,0
6050 data bit,3,and,3,rol,3,null,0,bmi,2,andiy,2,null,0,null,0,null,0
6060 data andzx,2,rolzx,2,null,0,sec,1,andy,3,null,0,null,0,andx,3
6060 data andzx,2,rolzx,2,null,0,sec,1,andy,3,null,0,null,0,null,0,andx,3
6070 data rolx,3,null,0,rti,1,eorix,2,null,0,null,0,null,0,eorz,2,lsrz,2
6080 data null,0,pha,1,eorim,2,lsra,1,null,0,jmp,3,eor,3,lsr,3,null,0
6090 data bvc,2,eoriy,2,null,0,null,0,null,0,eorzx,2,lsrzx,2,null,0
6100 data clc,1,eory,3,null,0,null,0,null,0,eorx,3,lsrx,3,null,0,rts,1
6110 data adcix,2,null,0,null,0,null,0,adcz,2,rorz,2,null,0,pla,1,adcim,2
6120 data rora,1,null,0,jmi,3,adc,3,ror,3,null,0,bvs,2,adciy,2,null,0
6130 data null,0,null,0,adczx,2,rorzx,2,null,0,sei,1,adcy,3,null,0,null,0
6140 data null,0,adcx,3,rorx,3,null,0,null,0,staix,2,null,0,null,0,styz,2
6150 data staz,2,stxz,2,null,0,dey,1,null,0,txa,1,null,0,sty,3,sta,3
6160 data stx,3,null,0,bcc,2,staiy,2,null,0,null,0,styzx,2,stazx,2,stxzy,2
6170 data null,0,tya,1,stay,3,txs,1,null,0,null,0,stax,3,null,0,null,0
6180 data ldyim,2,ldaix,2,ldxim,2,null,0,ldyz,2,ldaz,2,ldxz,2,null,0
6190 data tay,1,ldaim,2,tax,1,null,0,ldy,3,lda,3,ldx,3,null,0,bcs,2
6200 data ldaiy,2,null,0,null,0,ldyzx,2,ldazx,2,ldxzy,2,null,0,clv,1
6210 data lday,3,tsx,1,null,0,ldyx,3,ldax,3,ldxy,3,null,0,cpyim,2,cmpix,2
6220 data null,0,null,0,cpyz,2,cmpz,2,decz,2,null,0,iny,1,cmpim,2,dex,1
6230 data null,0,cpy,3,cmp,3,dec,3,null,0,bne,2,cmpiy,2,null,0,null,0
6240 data null,0,cmpzx,2,deczx,2,null,0,cld,1,cmpy,3,null,0,null,0,null,0
6250 data cmpx,3,decx,3,null,0,cpxim,2,sbcix,2,null,0,null,0,cpx,2,sbcz,2
6260 data incz,2,null,0,inx,1,sbcim,2,nop,1,null,0,cpx,3,sbc,3,inc,3
6270datanull,0,beq,2,sbciy,2,null,0,null,0,null,0,sbczx,2,inczx,2,null,0,sed,1
6270 data null,0,beq,2,sbciy,2,null,0,null,0,null,0,sbczx,2,inczx,2,null,0
6280 data sbcy,3,null,0,null,0,null,0,sbcx,3,incx,3,null,0
6280 data sed,1,sbcy,3,null,0,null,0,null,0,sbcx,3,incx,3,null,0
6290 data 0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f
9000 print chr$(147)
9010 input "enter file name";n$


9020 open 1,1,0,n$
9030 input#1,zz
9040 input#1,en
9050 for ad=zz to en
9060 input#1,dasl
9070 poke ad,dasl
9080 next
9090 close 1
9100 return






10000 print chr$(147)
10010 input "enter address in base 10";ad
10015 if ad>65535 goto 10000
10020 sys(ad)
10030 return
11000 print chr$(147)
11010 input"enter accumulator value";ac
11015 if ac<0 or a0255 goto 11010
11020 input"enter address in base 10";ad
11030 poke 2,int(ad/256)
11040 poke 1,ad-(int(ad/256)*256)
11050 x=usr(ac)
11060 return
13000 a=ad:s3=int(ad/4096)
13002 a=a-s3«4096
13010 s2=int(a/256)
13012 a=a-s2*256
13020 s=int(a/16)
13060 u=ad-(s3*4096+s2*256+s*16)
13070 s3$=co$(s3)
13080 s2$=co$(s2)
13090 s$=co$(s)
13100 u$=co$(u)
13110 ad$=s3$+s2$+s$+u$
13120 return
14000 print chr$(147):ad=826:zz=826
14010 print "(mnemonic) (space) (operand)"
14020 gosub 15000
14030 f=0
14040 for e=0 to 255
14050 if mn$=mn$(e) then by=by$(e):f=1:cd=e:e=256
14060 next
14070 if f=0 goto 14260
14080 on by gosub 14100,14130,14180
14090 goto 14020
14100 poke ad,cd
14110 ad=ad+1
14120 return
14130 if op>255 or op<0 then print "error":return
14140 poke ad,cd
14150 poke ad+1,op
14160 ad=ad+2
14170 return
14180 if op>65535 or op<0 then print "error":return



14190 poke ad, cd
14200 b2=int(op/256)
14210 b1=op-(b2*256)
14220 poke ad+1,b1
14230 poke ad+2,b2
14240 ad=ad+3
14250 return
14260 if mn$="org" or mn$="end" or mn$="dc" goto 14280
14270 print "error":goto 14020
14280 if mn$="org" goto 14300
14290 goto 14340
14300 if f0=1 then print "error":goto 14020
14310 f0=1
14320 ad=op:zz=op
14330 goto 14020 






14340 if mn$="end" goto 14360
14350 goto 14380
14360 en=ad-1
14370 return
14480 poke ad, op
14510 ad=ad+1
14520 goto 14020
15000 input a$
15010 if len(a$)<3 then print "error":goto 15000
15020 if len(a$)=3 then mn$=a$:op=0:return
15030 s=0:for m=1 to len(a$)
15040 if mid$(a$,m,1)=" " then s=m:m=len(a$)
15050 next
15060 if s=0 then mn$=a$:return
15070 mn$=left$(a$,s-1)
15080 op=val(right$(a$,len(a$)-s))
15090 return
20000 print chr$(147):sz=0
20010 input "enter program name";n$
20020 open 1,1,1,n$
20030 print#1,zz:da$=zz:gosub 20110
20040 print#1,en:da$=en:gosub 20110
20050 for ad=zz to en
20060 da$=peek(ad)
20070 print#1,da$:gosub 20110
20080 next
20090 close 1
20100 return
20110 sz=len(str$(da$))+sz+1
20120 if sz<192 then return
20130 poke 59411,53
20140 t=ti
20150 if (ti-t)<6 goto 20150
20160 poke 59411,61
20170 sz=sz-191
20180 return




