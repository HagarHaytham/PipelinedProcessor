# all numbers in hex format
# we always start by reset signal
#if you don't handle hazards add 3 NOPs
#this is a commented line
.ORG 0  #this means the the following line would be  at address  0 , and this is the reset address
10
#you should ignore empty lines

.ORG 2  #this is the interrupt address
100

.ORG 10
in R1     #R1=30
NOP

in R2     #R2=50
NOP

in R3     #R3=100
NOP

in R4     #R4=300
NOP

NOP       #DATA
Push R4   #sp=FFFFFFFE, M[FFFFFFFF]=300

JMP R1    

INC R1    # this statement shouldn't be executed,

#check flag fowarding  
.ORG 30
AND R1,R5   #R5=0 , Z = 1
#try interrupt here
JZ  R2      #Jump taken, Z = 0
SETC        # this statement shouldn't be executed, C-->1

#check on flag updated on jump
.ORG 50
JZ R1      #shouldn't be taken
JC R3      #Jump Not taken

#check destination forwarding
NOT R5     #R5=FFFF, Z= 0, C--> not change, N=1
in  R6     #R6=200, flag no change
JN  R6     #jump taken, N = 0
INC R1

.ORG 100
CLRC
AND R0,R0    #N=0,Z=1
out R6
rti

#check on load use
.ORG 200
SETC      #C-->1
POP R6     #R6=300, SP=FFFFFFFF
Call R6    #SP=FFFFFFFD, M[FFFFFFFF]=half next PC,M[FFFFFFFE]=other half next PC
#try interrup here
INC R6	  #R6=401, this statement shouldn't be executed till call returns, C--> 0, N-->0,Z-->0
NOP
NOP


.ORG 300
Add R3,R6 #R6=400
Add R1,R2 #R1=80, C->0,N=0, Z=0
ret
SetC           #this shouldnot be executed

.ORG 500
NOP
NOP
