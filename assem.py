# -*- coding: utf-8 -*-
"""
Created on Wed May  1 19:26:34 2019

@author: Dalia
"""

import sys
import math
from dectionary import *


def comment(lines):
    for i in range(len( lines)):
        foundIndex=lines[i].find('#')
        #Empty = lines[i].empty()
        if(foundIndex!=-1 ):
            lines[i]=lines[i].replace(lines[i][foundIndex:len(lines[i])],'')
            inputFile.write(lines[i])

#if found .ORG 
def ORG(lines):
    
    indexData = 0
    indexInstr = 0
    for i in range(len( lines)):
        #foundORG=lines[i].find('.ORG ')
        addr = lines[i].split()
        instrWithoutORG = searchDict(addr[0],instDict)
        if(addr[0] == '.ORG' ):
            
            if(addr[1] =='0'):
                instr = searchDict('LDD',instDict)
                reg = searchDict('R1',regDict)
                src = searchDict('PC',regDict)
                lines[i]=lines[i].replace(lines[i],instr[1]+reg+src)
                line = complete(lines[i])
                memInstr.write(line)
                memInstr.write('\n')
                indexInstr += 1
                
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
                
                memData.write(val) #write in data file
                indexData += 1
                
            else:
                #if instr found, add it in right addr instr mem
                temp = indexInstr
                for j in range(temp,int(addr[1])):
                    memInstr.write('0000000000000000')
                    memInstr.write('\n')
                    indexInstr += 1
                
#                getInstr(instr,Str)#define which instr
                
        elif(instrWithoutORG == -1):
           continue
        
        elif(instrWithoutORG != -1):
            getInstr(instrWithoutORG,addr)#define which instr
            print(addr)

#complete instr to fill 16bit
def complete(line):
    if(len(line)<16):
        for i in range(16 - len(line)):
            line+='0'
    return line

def getInstr(instr,Str):
    
    if (instr[0] == 2):
        if(len(Str) >3):
            sys.exit( 'syntax error: Expected two operands get more')
        elif (len(Str)==3):
            opp2 = opr2(Str[1],Str[2],instr)
            if(opp2 == None):
                sys.exit( 'Invalid operand in opr2 ')
            else:
                done = complete(opp2)
                memInstr.write(done)
                memInstr.write('\n')
        else:
            sys.exit( 'syntax error: Expected two operands get less ')

    elif (instr[0] == 1):
        if(len(Str) >2):
            sys.exit( 'syntax error: Expected one operands get more')
        elif (len(Str)==2):
            opp1 = opr1(Str[1],instr)
            if(opp1 == None):
                sys.exit( 'Invalid operand in opr1 ')
            else:
                done = complete(opp1)
                memInstr.write(done)
                memInstr.write('\n')
        else:
            sys.exit( 'syntax error: Expected one operands get less ')


def opr2(opp1,opp2,instr):
    Lines = ""
    Lines+= instr[1]
    op1 = searchDict(opp1,regDict)
    op2 = searchDict(opp2,regDict)
    if(op1 == -1 or op2 == -1):
        return None
    Lines += op1
    Lines += op2
    return Lines


def opr1(opp1,instr):
    Lines = ""
    Lines+= instr[1]
    op1 = searchDict(opp1,regDict)
    if(op1 == -1 ):
        return None
    Lines += op1
    return Lines

    

inputFile = open("file.txt",'r')
lines = inputFile.readlines()
inputFile.close()
#inputFile = open("file.txt",'w')
#comment(lines)
#empty()
#inputFile.close()
inputFile = open("file.txt",'r')
memData = open("data.txt",'w')
memInstr = open("Instr.txt",'w')
      

ORG(lines)

#lines = list(line.replace("\t","") for line in lines) #remove tabs
inputFile.close()
memData.close()
memInstr.close()











