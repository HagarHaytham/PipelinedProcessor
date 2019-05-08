# all numbers in hex format
# we always start by reset signal
#this is a commented line
.ORG 0  #this means the the following line would be  at address  0 , and this is the reset address
10
#you should ignore empty lines

.ORG 2  #this is the interrupt address
100

.ORG 0
setC           #C --> 1
NOP            #No change

#NOP            STRUCT,DATA
ClRC           #C --> 0

NOT R1         #R1 =FFFF , C--> no change, N --> 1, Z --> 0
#NOP            STRUCT

NOP            #DATA R1
inc R1	       #R1 =0000 , C --> 1 , N --> 0 , Z --> 1

in R1	       #R1= 5,add 5 on the in port,flags no change	
#NOP            STRUCT

in R2          #R2= 10,add 10 on the in port, flags no change
NOP            #DATA R2

NOP            #DATA R2
NOT R2	       #R2= FFEF, C--> no change, N -->1,Z-->0

inc R1         #R1= 6, C --> 0, N -->0, Z-->0
#NOP            STRUCT

Dec R2         #R2= FFEE,C-->1 , N-->1, Z-->0
NOP            #DATA R1

out R1
#NOP            STRUCT

out R3
#NOP            STRUCT

out R2
