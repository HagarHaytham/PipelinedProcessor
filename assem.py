# -*- coding: utf-8 -*-
"""
Created on Wed May  1 19:26:34 2019

@author: Dalia
"""

import sys
import math
from dectionary import *


def comment(lines):
    #print(lines)
    LINES = []
    for i in range(len( lines)):
        
        if(len(lines[i])>0):
            if(lines[i][0] == '#' or lines[i][0] == '\n'):
               pass
            else:
                foundIndex=lines[i].find('#')
                coma = lines[i].find(',')
                if(coma != -1):
                    lines[i]=lines[i].replace(',',' ')
                #Empty = lines[i].empty()
                if(foundIndex!=-1 ):
                    lines[i]=lines[i].replace(lines[i][foundIndex:len(lines[i])],'')
                    LINES.append(lines[i].upper()+'\n')
                else: 
                    LINES.append(lines[i].upper())
    return LINES
                

#if found .ORG 
def ORG(lines):
    print(lines)
    indexData = 0
    indexInstr = 0
    for i in range(len( lines)):
        
        #foundORG=lines[i].find('.ORG ')
        addr = lines[i].split()
        instrWithoutORG = searchDict(addr[0],instDict)
        if(addr[0] == '.ORG' ):
            i+=1
            val = lines[i]
            Str = val.split()
            instr = searchDict(Str[0],instDict)
            
            if(instr == -1):#if val found, add it in right addr in data mem
                inp = indexData
                for j in range(inp,int(addr[1])):
                    memData.write('0000000000000000')
                    memData.write('\n')
                    indexData += 1
                a =bin(int(val,16))
                memData.write(a[2:].zfill(16)+'\n') #write in data file
                indexData += 1
                
            else:
                #if instr found, add it in right addr instr mem
                temp = indexInstr
                for j in range(temp,int(addr[1])):
                    memInstr.write('0000000000000000')
                    memInstr.write('\n')
                    indexInstr += 1
                
        elif(instrWithoutORG == -1):
            pass
        
        elif(instrWithoutORG != -1):
            indexInstr = getInstr(instrWithoutORG,addr,indexInstr)#define which instr
            print(addr)

##############################################
#complete instr to fill 16bit
def complete(line,op1):
    if(len(line)<16):
        if(op1 != '0'): 
            op1 = searchDict(op1,regDict)
            line += op1
        
        for i in range(16 - len(line)):
            line+='0'
    return line

##############################################
def getInstr(instr,Str,indexInstr):
    
    if (instr[0] == 2):
        if(len(Str) >3):
            sys.exit( 'syntax error: Expected two operands get more')
        elif (len(Str)==3):
            opp2 = opr2(Str[1],Str[2],instr)
            if(opp2 == None):
                sys.exit( 'Invalid operand in opr2 ')
            else:
                done = complete(opp2,'0')
                memInstr.write(done)
                memInstr.write('\n')
                indexInstr += 1
        else:
            sys.exit( 'syntax error: Expected two operands get less ')

    elif (instr[0] == 1):
        if(len(Str) >2):
            sys.exit( 'syntax error: Expected one operands get more in opr1')
        elif (len(Str)<=2):
            opp1 = opr1(Str[1] if len(Str)==2 else '0',instr)
            if(opp1 == None):
                sys.exit( 'Invalid operand in opr1 ')
            else:
                done = complete(opp1,Str[1] if len(Str)==2 else '0')
                memInstr.write(done)
                memInstr.write('\n')
                indexInstr += 1

    elif (instr[0] == 'MEM'):
        if(len(Str) >3):
            sys.exit( 'syntax error: Expected one operand get more in mem')
        elif (len(Str)<=3):
            Mem = mem(Str[1],Str[2] if len(Str)==3 else '0',instr)
            if(Mem == None):
                sys.exit( 'Invalid operand in mem ')
            else:
                done = complete(Mem,'0' if len(Str)==3 else Str[1])
                memInstr.write(done)
                memInstr.write('\n')
                indexInstr += 1
                
    elif (instr[0] == 'branch'):
        if(len(Str) >2):
            sys.exit( 'syntax error: Expected one operand get more in branch')
        elif (len(Str)<=2):
            Branch = branch(Str[1] if len(Str)==2 else '0',instr)
            if(Branch == None):
                sys.exit( 'Invalid operand in branch ')
            else:
                done = complete(Branch,'0' if (len(Str)==1) else Str[1])
                memInstr.write(done)
                memInstr.write('\n')
                indexInstr += 1
        
    return indexInstr

##############################################
def opr2(opp1,opp2,instr):
    Lines = ""
    Lines+= instr[1]
    op1 = searchDict(opp1,regDict)
    if( op1 == -1):
        return None
    Lines += op1
    if(opp2.isdigit()):
        #Lines = complete(Lines,opp1)
        a =bin(int(opp2,16))
        Lines += a[2:].zfill(4)
        #Lines += '\n'+opp2
    else:
        op2 = searchDict(opp2,regDict)
        if( op2 == -1):
            return None
        Lines += op2
    return Lines

##############################################
def opr1(opp1,instr):
    Lines = ""
    Lines+= instr[1]
    if(opp1 != '0'):
        op1 = searchDict(opp1,regDict)
        if(op1 == -1 ):
            return None
        Lines += op1
    return Lines

##############################################    
def mem(opp1,opp2,instr):
    res = opr1(opp1,instr)
    if(opp2 != '0'):
        if(opp2.isdigit()):
            res = complete(res,opp1)
            a =bin(int(opp2,16))
            res += '\n'+a[2:].zfill(16)
            #print(res)
        else:
            op2 = searchDict(opp2,regDict)
            if(op2 == -1 ):
                return None
            res += op2
    return res

##############################################
def branch(opp1,instr):
    res = opr1(opp1,instr)
    return res

##############################################
def colon(file):
    inf = open(file,'r')
    read = inf.readlines()
    inf.close()
    wr = open(file,'w')
    count = 0
    for i in range(len( read)):
        read[i] = str(count) + ': ' + read[i]
        wr.write(read[i])
        count +=1
        
    j = 0
    for i in range(count , 1048577):
        wr.write('\t' + str(count+j) + ': ' +'0000000000000000\n')
        j+=1
##############################################    
#main
inputFile = open("Testcases/NEW/Memory.asm",'r')
lines = inputFile.readlines()
inputFile.close()
#remove comments and empty lines
lines = comment(lines)
#print(lines)
memData = open("Testcases/NEW/MemoryData.mem",'w')
memInstr = open("Testcases/NEW/MemoryInstr.mem",'w')
      
ORG(lines)

inputFile.close()
memData.close()
memInstr.close()

colon('Testcases/NEW/MemoryInstr.mem')
colon('Testcases/NEW/MemoryData.mem')











