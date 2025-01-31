# all numbers in hex format
# we always start by reset signal
#this is a commented line
.ORG 0  #this means the the following line would be  at address  0 , and this is the reset address
10
#you should ignore empty lines

.ORG 2  #this is the interrupt address
100

.ORG 10
in R2        #R2=19 add 19 in R2
NOP

in R3        #R3=FFFF
NOP

in R4        #R4=F320
NOP          #STRUCT

LDM R1,5     #R1=5
NOP          #STRUCT

LDM R0,201     #R0=201
NOP            #STRUCT

LDM R6,200     #R6=200
NOP            #STRUCT

PUSH R1      #SP=FFFFFFFE,M[FFFFFFFF]=5
NOP          #STRUCT

PUSH R2      #SP=FFFFFFFD,M[FFFFFFFE]=19
NOP          #STRUCT

POP R1       #SP=FFFFFFFE,R1=19
NOP          #STRUCT

POP R2       #SP=FFFFFFFF,R2=5
NOP          #STRUCT

NOP         #DATA
STD R2,R6   #M[200]=5   

STD R1,R0   #M[201]=19
NOP         #STRUCT

NOP         #DATA
LDD R3,R0   #R3=19

LDD R4,R6   #R4=5