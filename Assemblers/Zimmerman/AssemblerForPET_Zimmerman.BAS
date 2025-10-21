From [Assembler for the PET, Mark Zimmerman, Dec 78 Personal Computing, pp 42-45](https://www.1000bit.it/js/web/viewer.html?file=%2Friviste%2Fpersonalcomputing%2Fpersonalcomputing1978%2D12%2Epdf#zoom=page-fit)

## Links

 - [Commodore Files For Beginners](https://www.atarimagazines.com/compute/issue42/050_1_COMMODORE_FILES_FOR_BEGINNERS.php)

Fails on line 70 with syntax error, becasue you can not have a space between `PRINT` and `#`, it must be `PRINT#`. See also [Commodore Files For Beginners](https://www.atarimagazines.com/compute/issue42/050_1_COMMODORE_FILES_FOR_BEGINNERS.php)

## Notes

Using this BASIC assembler program is pretty painful as only decimal input is allowed, so some manual translation is required.

## TODO

 - Add disk writing, instead of tape
 - Add hex input
 - Add labels


## Filename

ASSZIM


## Code


1 REM 6502 ASSEMBLER--COPYRIGHT 1978 MARK ZIMMERMANN 
10 DATA ADC,97,1,AND,33,1,ASL,2,3,BCC,144,8,BCS,176,8,BEQ,240,8,BIT,36,7 
12 DATA BMI,48,8,BNE,208,8,BPL,16,8,BRK,0,0,BVC,80,8,BVS,112,8,CLC,24,0
14 DATA CLD,216,0,CLI,88,0,CLV,184,0,CMP,193,1,CPX,224,4,CPY,192,4
16 DATA DEC,198,2,DEX,202,0,DEY,136,0,EOR,65,1,INC,230,2,INX,232,0 
18 DATA INY,200,0,JMP,76,6,JSR,32,9,LDA,161,1,LDX,162,5,LDY,160,5
20 DATA LSR,66,3,NOP,234,0,ORA,1,1,PHA,72,0,PHP,8,0,PLA,104,0,PLP,40,0
22 DATA ROL,34,3,ROR,98,3,RTI,64,0,RTS,96,0,SBC,225,1,SEC,56,0,SED,248,0
24 DATA SEI,120,0,STA,129,1,STX,134,2,STY,132,2,TAX,170,0,TAY,168,0
26 DATA TSX,186,0,TXA,138,0,TXS,154,0,TYA,152,0
28 REM DATA STATEMENTS ABOVE FOR M$ (MNEMONICS), OP (OPCODES), & CA (CATEGORIES)
30 DIM M$(55),OP(55),CA(55):FOR I=0 TO 55: READ M$(I),OP(I),CA(I):NEXT I
35 REM CATEGORIES DETERMINE POSSIBLE ADDRESSING MODES
40 PRINT "BEGIN AT";:INPUT BE:AD=BE
45 REM BE IS BEGINNING ADDRESS OF ASSEMBLED CODE & AD IS CURRENT ADDRESS
50 PRINT "DATA FILE NAME"; :INPUT NA$
55 REM ASSEMBLED CODE IS WRITTEN ONTOTAPE 
60 OPEN1,1,1,NA$ 
65 REM DATA FILE STARTS WITH BE AND ENDS WITH 999 
70 PRINT#1,BE
100 PRINT:C$="":A$="":PRINT "? ";
101 REM GET ASSEMBLY LANGUAGE LINE--20=DEL--13=RETURN

102 GETA$:IF A$="" GOTO102
103 PRINT A$;:L=LEN(C$)
104 IF ASC(A$) = 20 AND L<2 THEN C$="":A$="": GOTO102:REM DEL FIRST CHAR.
105 IF ASC(A$) = 20 THEN A$="":C$=LEFT$(C$,L-1): GOTO102:REM DEL A CHARACTER
106 IF ASC(A$)<>13 THEN C$=C$+A$:A$="": GOTO 102
108 L$=LEFT$(C$,3):IFL<=4THEN C$="":L=0: GOTO120
109 REM L$ HAS MNEMONIC, C$ HAS OPERAND
110 C$=RIGHT$(C$,L-4):L=L-4:REM L IS OPERAND LENGTH
120 MN=-1:REM MN IS MNEMONIC NUMBER--NOW SEARCH LIST
130 FORI=0 TO 55:IF M$(I)=L$ THEN MN=I: I=55
140 NEXT I
145 IF L$="END" GOTO 2000
150 IF MN=-1 THEN PRINT "WHAT?": GOTO100
155 REM MN=-1 MEANS MNEMONIC NOT FOUND
160 CA=CA(MN):OP=OP(MN):REM LOOK UP CATEGORY AND BASE OPCODE
200 IF CA=0 THEN POKE 997,OP:BY=1:GOTO 1000
205 REM OPCODES ARE STORED IN 997,998,999 BEFORE WRITING TO TAPE
207 REM BY=INSTRUCTION LENGTH IN BYTES
208 REM 1000 WRITES TO TAPE
209 REM CA=0 ARE "IMPLIED" INSTRUCTIONS
210 IF C$<>"A"GOTO 220
213 IF CA <> 3 THEN PRINT "NO":GOTO100: REM CATEGORY 3 FOR ACCUMULATOR OPERAND




216 POKE 997,OP+8: BY=1: GOTO 1000
220 IF LEFT$(C$,1)<> "#" GOTO 230
221 REM HANDLE "IMMEDIATE" INSTRUCTIONS HERE 
222 POKE 998,VAL(RIGHT$(C$,L-1)):BY=2
224 IF CA=1 THEN POKE 997,OP+8:GOTO 1000

226 IF CA=1 OR CA=5 THEN POKE997,OP: GOTO 1000

227 REM CATEGORIES 1,4,5 ARE ONLY ONES ALLOWED HERE


228 PRINT "NO":GOTO 100

230 IF LEFT$(C$,1)<>"("GOTO 260


231 REM CHECK FOR VARIOUS INDIRECT INSTRUCTIONS
232 IF RIGHT$(C$,3)<>"),Y" GOTO 240
233 REM IT IS AN "(INDIRECT),Y"

234 POKE 998;VAL(MID$(C$,2,L-4)) :BY=2

236 IF CA=1 THEN POKE 997,OP+16: GOTO 1000

237 REM IF NOT CATEGORY 1, ERROR
238 PRINT "NO" :GOTO 100

240 IF RIGHT$(C$ ,3)<>",X)" GOTO 250

242 POKE 998, VAL(MID$(C$,2,L-4)):BY=2
243 REMIT MUST BE CATEGORY 1, ELSE ..ERROR
244 IF CA=1 THEN POKE 997,OP:GOTO 1000
246 PRINT "NO":GOTO 100

250 IF RIGHT$(C$,1)<>")" THEN PRINT "NO":GOTO 100

251 REM IT BETTER BE A JMP (INDIRECT), ELSE ERROR

252 IF CA<> 6 THEN PRINT "NO": GOTO 100

254 N=VAL(MID$(C$,2,L-2)):HI=INT(N/256): BY=3

255 REM HI=HIGH PART OF ADDRESS

256 POKE 999,HI:POKE 998,N-256*HI

258 POKE 997,OP+32 :GOTO 1000



260 IF RIGHT$(C$,2)<>",X" GOTO 280
262 N=VAL(LEFT$(C$,L-2))
264 IF N>255 GOTO 270
265 REM HANDLE "ZERO PAGE,X" HERE
266 POKE 998,N:BY=2:IF CA=2 THEN POKE 997,OP+16: GOTO 1000
268 IF CA=1 OR CA=3 OR CA=5 THEN POKE 997,OP+20: GOTO 1000
269 PRINT "NO":GOTO 100

270 HI=INT(N/256) :BY=3
272 POKE 999,HI:POKE 998,N-256*HI
274 IF CA=2 THEN POKE 997,OP+24:G0TO 1000
276 IF CA=1 OR CA=3 OR CA=5 THEN POKE 997,OP+28: GOTO 1000
278 PRINT "NO":GOTO 100
280 IF RIGHT$(C$,2)<>",Y" GOTO 300 
282 N=VAL(LEFT$(C$,L-2))
284 IF N>255 GOTO 290
285 REM HANDLE ZERO PAGE,Y HERE
286 POKE 998,N:BY=2
287 IF CA=2 THEN POKE 997,OP+16:GOTO1000
288 IF CA=5 THEN POKE 997,OP+20:GOTO1000
289 REM CONTINUE HERE!-- SOME ZERO PAGE,Y MUST BE TREATED AS ABSOLUTE,Y



290 HI=INT(N/256) :POKE 999,HI:POKE 998,N-256*HI: BY=3
292 IF CA=1 THEN POKE 997,OP+24:GOTO 1000



294 IF CA=5 THEN POKE 997,OP+28:GOTO1000
299 PRINT "NO": GOTO 100
300 N=VAL(C$): REM NOW, FOR NUMERICAL OPERANDS
305 IF CA=8 GOTO 340
306 REM AT 340 DO BRANCHES

310 IF N>255 GOTO 330
312 POKE 998,N:BY=2
314 IF CA=2 OR CA=7 THEN POKE 997,OP:GOTO 1000

316 IF CA=1 OR CA=3 OR CA=4 OR CA=5 THEN POKE 997,OP+4:GOTO1000
318 REM CONTINUE ON HERE:
330 HI=INT(N/256):POKE 999,HI:POKE998,N-256*HI:BY=3
332 IF CA=2 OR CA=7 THEN POKE 997,OP+8:GOTO 1000
334 IF CA=1 OR CA=3 OR CA=4 OR CA=5 THEN POKE 997,OP+12:GOTO 1000
336 IF CA=6 OR CA=9 THEN POKE 997,OP:GOTO 1000
339 PRINT "NO":GOTO 100
340 N=N=AD=2:IF N<-128 OR N>127 THEN PRINT "CAN'T BRANCH";N:GOTO 100
342 IF N<0 THEN N=N+256:REM HANDLE RELATIVE ADDRESSING & NEGATIVE NUMBERS HERE
344 POKE 998,N:BY=2:POKE 997,OP:GOTO 1000
1000 PRINT AD:FOR I=997TO996+BY:PRINT PEEK(I); :NEXT I
1005 REM DISPLAY WHAT WAS RESULTING MACHINE LANGUAGE
1010 AD=AD+BY:REM INCREMENT ADDRESS
1020 FOR I=997 TO 996+BY:PRINT#1,PEEK(I):NEXT I
1025 REM WRITE TO TAPE
1030 T=TI:POKE 59411,53:REM TURN ON TAPE MOTOR
1040 IF (TI-T)<2 GOTO 1040:REM FOR (1/30) SECOND
1050 POKE 59411,61: REM TURN MOTOR OFF
1060 GOTO 100
2000 PRINT#1,999:CLOSE 1:END






1 rem 6502 assembler--copyright 1978 mark zimmermann 
10 data adc,97,1,and,33,1,asl,2,3,bcc,144,8,bcs,176,8,beq,240,8,bit,36,7 
12 data bmi,48,8,bne,208,8,bpl,16,8,brk,0,0,bvc,80,8,bvs,112,8,clc,24,0
14 data cld,216,0,cli,88,0,clv,184,0,cmp,193,1,cpx,224,4,cpy,192,4
16 data dec,198,2,dex,202,0,dey,136,0,eor,65,1,inc,230,2,inx,232,0 
18 data iny,200,0,jmp,76,6,jsr,32,9,lda,161,1,ldx,162,5,ldy,160,5
20 data lsr,66,3,nop,234,0,ora,1,1,pha,72,0,php,8,0,pla,104,0,plp,40,0
22 data rol,34,3,ror,98,3,rti,64,0,rts,96,0,sbc,225,1,sec,56,0,sed,248,0
24 data sei,120,0,sta,129,1,stx,134,2,sty,132,2,tax,170,0,tay,168,0
26 data tsx,186,0,txa,138,0,txs,154,0,tya,152,0
28 rem data statements above for m$ (mnemonics), op (opcodes), & ca (categories)
30 dim m$(55),op(55),ca(55):for i=0 to 55: read m$(i),op(i),ca(i):next i
35 rem categories determine possible addressing modes
40 print "begin at";:input be:ad=be
45 rem be is beginning address of assembled code & ad is current address
50 print "data file name"; :input na$
55 rem assembled code is written ontotape 
60 open1,1,1,na$ 
65 rem data file starts with be and ends with 999 
70 print#1,be
100 print:c$="":a$="":print "? ";
101 rem get assembly language line--20=del--13=return

102 geta$:if a$="" goto102
103 print a$;:l=len(c$)
104 if asc(a$) = 20 and l<2 then c$="":a$="": goto102:rem del first char.
105 if asc(a$) = 20 then a$="":c$=left$(c$,l-1): goto102:rem del a character
106 if asc(a$)<>13 then c$=c$+a$:a$="": goto 102
108 l$=left$(c$,3):ifl<=4then c$="":l=0: goto120
109 rem l$ has mnemonic, c$ has operand
110 c$=right$(c$,l-4):l=l-4:rem l is operand length
120 mn=-1:rem mn is mnemonic number--now search list
130 fori=0 to 55:if m$(i)=l$ then mn=i: i=55
140 next i
145 if l$="end" goto 2000
150 if mn=-1 then print "what?": goto100
155 rem mn=-1 means mnemonic not found
160 ca=ca(mn):op=op(mn):rem look up category and base opcode
200 if ca=0 then poke 997,op:by=1:goto 1000
205 rem opcodes are stored in 997,998,999 before writing to tape
207 rem by=instruction length in bytes
208 rem 1000 writes to tape
209 rem ca=0 are "implied" instructions
210 if c$<>"a"goto 220
213 if ca <> 3 then print "no":goto100: rem category 3 for accumulator operand




216 poke 997,op+8: by=1: goto 1000
220 if left$(c$,1)<> "#" goto 230
221 rem handle "immediate" instructions here 
222 poke 998,val(right$(c$,l-1)):by=2
224 if ca=1 then poke 997,op+8:goto 1000
226 if ca=1 or ca=5 then poke997,op: goto 1000
227 rem categories 1,4,5 are only ones allowed here
228 print "no":goto 100
230 if left$(c$,1)<>"("goto 260
231 rem check for various indirect instructions
232 if right$(c$,3)<>"),y" goto 240
233 rem it is an "(indirect),y"
234 poke 998;val(mid$(c$,2,l-4)) :by=2
236 if ca=1 then poke 997,op+16: goto 1000
237 rem if not category 1, error
238 print "no" :goto 100
240 if right$(c$ ,3)<>",x)" goto 250
242 poke 998, val(mid$(c$,2,l-4)):by=2
243 remit must be category 1, else ..error
244 if ca=1 then poke 997,op:goto 1000
246 print "no":goto 100
250 if right$(c$,1)<>")" then print "no":goto 100
251 rem it better be a jmp (indirect), else error
252 if ca<> 6 then print "no": goto 100
254 n=val(mid$(c$,2,l-2)):hi=int(n/256): by=3
255 rem hi=high part of address
256 poke 999,hi:poke 998,n-256*hi
258 poke 997,op+32 :goto 1000
260 if right$(c$,2)<>",x" goto 280
262 n=val(left$(c$,l-2))
264 if n>255 goto 270
265 rem handle "zero page,x" here
266 poke 998,n:by=2:if ca=2 then poke 997,op+16: goto 1000
268 if ca=1 or ca=3 or ca=5 then poke 997,op+20: goto 1000
269 print "no":goto 100

270 hi=int(n/256) :by=3
272 poke 999,hi:poke 998,n-256*hi
274 if ca=2 then poke 997,op+24:g0to 1000
276 if ca=1 or ca=3 or ca=5 then poke 997,op+28: goto 1000
278 print "no":goto 100
280 if right$(c$,2)<>",y" goto 300 
282 n=val(left$(c$,l-2))
284 if n>255 goto 290
285 rem handle zero page,y here
286 poke 998,n:by=2
287 if ca=2 then poke 997,op+16:goto1000
288 if ca=5 then poke 997,op+20:goto1000
289 rem continue here!-- some zero page,y must be treated as absolute,y



290 hi=int(n/256) :poke 999,hi:poke 998,n-256*hi: by=3
292 if ca=1 then poke 997,op+24:goto 1000



294 if ca=5 then poke 997,op+28:goto1000
299 print "no": goto 100
300 n=val(c$): rem now, for numerical operands
305 if ca=8 goto 340
306 rem at 340 do branches

310 if n>255 goto 330
312 poke 998,n:by=2
314 if ca=2 or ca=7 then poke 997,op:goto 1000

316 if ca=1 or ca=3 or ca=4 or ca=5 then poke 997,op+4:goto1000
318 rem continue on here:
330 hi=int(n/256):poke 999,hi:poke998,n-256*hi:by=3
332 if ca=2 or ca=7 then poke 997,op+8:goto 1000
334 if ca=1 or ca=3 or ca=4 or ca=5 then poke 997,op+12:goto 1000
336 if ca=6 or ca=9 then poke 997,op:goto 1000
339 print "no":goto 100
340 n=n=ad=2:if n<-128 or n>127 then print "can't branch";n:goto 100
342 if n<0 then n=n+256:rem handle relative addressing & negative numbers here
344 poke 998,n:by=2:poke 997,op:goto 1000
1000 print ad:for i=997to996+by:print peek(i); :next i
1005 rem display what was resulting machine language
1010 ad=ad+by:rem increment address
1020 for i=997 to 996+by:print#1,peek(i):next i
1025 rem write to tape
1030 t=ti:poke 59411,53:rem turn on tape motor
1040 if (ti-t)<2 goto 1040:rem for (1/30) second
1050 poke 59411,61: rem turn motor off
1060 goto 100
2000 print#1,999:close 1:end







## LOADER PROGRAM LISTING

1 REM LOADER COPYRIGHT 1978 MARK ZIMMERMANN
1O PRINT "FILE"; INPUT N$ :OPEN 1,1,0,N$: INPUT #1,B:PRINT "FROM";B:A=B
20 INPUT #1,C: IF C=999 GOTO 50
30 POKE A,C;A=A+1 : GOTO20
50 PRINT "TO";A-1:CLOSE 1


1 rem loader copyright 1978 mark zimmermann
10 print "file";input n$ :open 1,1,0,n$: input #1,b:print "from";b:a=b
20 input #1,c: if c=999 goto 50
30 poke a,c;a=a+1 : goto20
50 print "to";a-1:close 1
