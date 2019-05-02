# -*- coding: utf-8 -*-
"""
Created on Tue Nov 27 02:11:47 2018

@author: Mary
"""
import sys
import math
from dectionary import * 
#checker =0
num=0
count=0




def opr1(opp,instr,num):
    #in progress
    code=[]
    if(opp.isdigit()):
        return None
            
    myOp=searchDict(opp,varDict)
    #if operand is not variable
    if(myOp==-1):
        myOp=searchDict(opp,modesDict)
        # if operand is indexed or indirect absolute
        if(myOp==-1):
            
            
             
            if(opp[0]=='@'):
                Str=opp.replace(opp[0],"")
                var=searchDict(Str,varDict)
                if(var!=-1):
                    code.append(instr[1])
                    code.append('110100')#@x(r6)
                    code.append('\n')
                    code.append("indexed" + ' ' + Str )
                    #global count
                    num+=1
               
                    #code.append(varDict[Str][0])##########
                    
                    return code,num
                else:
                    var=searchDict(opp[1],varDict)
                    if(var==-1):
                        return None
                    else:
                        code.append(instr[1])
                        Str=opp.replace(opp[1],"")
                        mode=searchDict(Str,modesDict)
                        if(mode ==-1):
                            return None
                        code.append(mode)
                        code.append('\n')
                        code.append("indexed" + ' '+ opp[1] )
                        #global count
                        num+=1
                     
                        #code.append(varDict[opp[1]][0])  
                        return code,num

            #it is direct
            else:
                var=searchDict(opp[0],varDict)
                if(var==-1):
                    return None
                else:
                    code.append(instr[1])
                    Str=opp.replace(opp[0],"")
                    mode =searchDict(Str,modesDict)
                    if(mode ==-1):
                        return None
                    code.append(mode)
                    code.append('\n')
                    code.append("indexed" + ' '+ opp[0] )
                    #global count
                    num+=1
                   
                    #code.append(varDict[opp[0]][0])
                    return code,num
        else:
            code.append(instr[1])
            code.append(myOp)
            code.append('\n')
            
            return code,num
    else:
            code.append(instr[1])
            code.append('010100')#r6
            code.append('\n')
            code.append("indexed" + ' ' + opp )
            #global count
            num+=1
            
            #code.append(varDict[opp][0])
                                
    return code,num

def opr2(opp1,opp2,instr,num):
    #in progress
    code=[]
    op1=[]
    op2=[]
    if(opp1.isdigit()):
        op1.append(instr[1])
        op1.append('001100')       #r7
        op1.append('\n')        
        op1.append("num"+ str(format(int(opp1),"016b")))
        #op1.append('\n')  
        num+=1
    else:
        op1 = opr1(opp1,instr,num)
        num= op1[1]
        op1 = op1[0]
    if(opp2.isdigit()):
        op2.append(instr[1])
        op2.append('001100')       
        op2.append('\n')        
        op2.append("num" +str(format(int(opp2),"016b")))
        #op2.append('\n')
        num+=1        
    else:
        op2=opr1(opp2,instr,num)
        num= op2[1]
        op2 = op2[0]
    if(op1 !=None and op2!= None):
        code.append(op1[0])
        code.append(op1[1])
        code.append(op2[1])
        code.append('\n')

        if(len(op1)==4):
            code.append(op1[3])
            code.append('\n')
        if(len(op2)==4):
            code.append(op2[3])
            code.append('\n')

    else:
        return None
    return code,num




def branch(Str,pc):
    encodedStr=''
    if(searchDict(Str[2],labelDict)==-1):
        sys.exit('Undefined Label Name')

    encodedStr+=(Str[1]) #append branch code
    #append label code
    offset=int(labelDict[Str[2]]) - (pc+1)
    print(offset,pc)
    if(offset > 1023 or offset <-1024):
        return "Invalid offset"
    #encodedStr+=str(format(offset % (1 << 11), '011b'))
    offset1 = str(format(offset, '011b'))
    if(offset<0):
        offset1 = offset1.replace('-','1')
    encodedStr+=offset1
    encodedStr+=('\n')
    return encodedStr
#       



def JSR(Str): #1 operands
    #search in lbl array
    encodedStr=''
    lbl= searchDict(Str[2],labelDict)
    if(lbl == -1):
      sys.exit('No existing Lable') 
      
    encodedStr+=(Str[1])
    encodedStr+=('\n')
    encodedStr+=(format(int(labelDict[Str[2]]),'016b'))
    encodedStr+=('\n')
    num+=1
    return encodedStr,num
    #print( bin(int(lbl))[2:] )
    #inst=instr[1]
    #Lines.append(inst)
   # print(inst)
    #lable=bin(int(lbl))[2:]
    #lable=str(lable)
    
    #Lines.append(lable)
   # print(lable)


def define (Str1,count,value):
    if(len(Str1)<3):
        sys.exit('more operands are expected in line '+str(i))
    else:
        if(Str1[1][0]=='@'):
            sys.exit('variable should not start with special characters in line '+str(i))
        else:
            varArr=[str(count),Str1[2]]
            value.append(Str1[2])
            addToVar(Str1[1],varArr)
            count+=1
    return count,value

def label(Str,count):
    foundIndex= Str.find(':')
    if(foundIndex!=-1):
        addToLabel(Str[0:foundIndex],count)
        
        
def comment(lines):
    for i in range(len( lines)):
        foundIndex=lines[i].find(';')
        if(foundIndex!=-1):
            lines[i]=lines[i].replace(lines[i][foundIndex:len(lines[i])],'')
            inputFile.write(lines[i]+"\n")
            
        
# binary

#############################################################################
#main

value=[]
Lines=[]
inputFile = open("file.txt",'r')

lines = inputFile.readlines()

inputFile.close()
inputFile = open("file.txt",'w')
comment(lines)      #remove comment done
lines = list(line.replace("\t","") for line in lines) #remove tabs
inputFile.close()
inputFile = open("file.txt",'r')

#loop to initiate vars and labels with initial address

for i in range(len(lines)):
    line = lines[i] #read line
    length= len(line)
    defin= line.split()
    #print(defin)
    if(length >0 and (line.find('Define')!=-1)):
        count,value = define(defin,count,value)
    elif(length >0 and line.count(':') >0):
        label(line,count)
    elif(length >0 and line != "\n"):
        count+=1
    
print(labelDict,count,varDict)

    
#2nd loop to calculate words of indexed

for i in range(len(lines)):
    
    line = lines[i] #read line
    Str = line.split()
    length= len(Str)
    if(length == 0 ):
        continue
    if(length > 0):
        if (Str[0] == 'Define'):
            address=int(varDict[Str[1]][0]) + num
            varDict[Str[1]][0] = str(f"{address:016b}")
            #print(varDict[Str[1]][0])
           
        elif(line.find(':') !=-1):
            foundIndex= line.find(':')
            L=int(labelDict[Str[0][0:foundIndex]]) + num
            labelDict[Str[0][0:foundIndex]] = str(L)
           
            #print(labelDict[Str[0][0:foundIndex]],num,varDict) 
        else:
            instr = searchDict(Str[0],instDict) #return obj instr
            length -=1
            
            if(instr != -1): 
    
                '''if (instr[0] == 'branch'):
                    Lines.append(branch(Str))        
                
                elif(instr[0]=='jmp1op'):
                    if(length !=1):
                         sys.exit('syntax error: Expected no operand get more in line ') 
                    JSR(Str[1],labelDict)
                
                elif(instr[0]=='jmpnoop'):
                    if(length !=0):
                         sys.exit('syntax error: Expected no operand get more in line ')                
                         #Lines.append(instr[1])
                    Lines.append(instr[1])
                    #print(instr[1])
            
                elif(instr[0] != length):
                    sys.exit( 'syntax error: Expected no operand get more in line '+str(i))
                '''
                
                if(instr[0]=='jmpnoop'):
                    if(length !=0):
                         sys.exit('syntax error: Expected no operand get more in line ')                
                    Lines.append(instr[1])
                    
                    
                elif (instr[0] == 'branch'):
                    Lines.append(["branch"+' ' + instDict[Str[0]][1] + ' ' + Str[1]])
                    #Lines.append('\n')
                    
                elif(instr[0]=='jmp1op'):
                    if(length !=1):
                         sys.exit('syntax error: Expected no operand get more in line ') 
                    Lines.append(["jmp1op"+' ' + instDict[Str[0]][1]+ ' ' + Str[1]])
                    #Lines.append('\n')
                    
                elif(instr[0]=='jmpnoop'):
                    if(length !=0):
                         sys.exit('syntax error: Expected no operand get more in line ')                
                         #Lines.append(instr[1])
                    Lines.append(["jmpnoop"+' ' + instDict[Str[0]][1]+ ' ' + Str[1]])
                    #Lines.append('\n')
                    
                elif(instr[0] != length):
                    sys.exit( 'syntax error: Expected no operand get more in line '+str(i))
                    
                    
                elif (instr[0] == 0):
                    Lines.append(instr[1])
                    #Lines.append('\n')
                  
                    
                elif (instr[0] == 1):
                    if(length >1):
                        sys.exit( 'syntax error: Expected one operand get more in line '+str(i))
                    elif (length==1):
                        opp1=opr1(Str[1],instr,num)
                        num =opp1[1]
                        opp1 = opp1[0]
                        if(opp1 == None):
                            sys.exit( 'Invalid operand in line '+str(i))
                        else:
                            #count+=checker
                            Lines.append(opp1)
                    else:
                        sys.exit( 'syntax error: Expected one operand get less in line '+str(i))
                        
                elif (instr[0] == 2):
                    if(length >2):
                        sys.exit( 'syntax error: Expected two operands get more in line '+str(i))
                    elif (length==2):
                        opp2= opr2(Str[1],Str[2],instr,num)
                        num = opp2[1]
                        opp2 = opp2[0]
                        if(opp2 == None):
                            sys.exit( 'Invalid operand in line '+str(i))
                        else:
                            Lines.append(opp2)
                            #count+=checker
                    else:
                        sys.exit( 'syntax error: Expected two operands get less in line '+str(i))
    
                        
            else:
                print(Str[0])
                sys.exit('instr not found in line '+str(i))
                
#print(labelDict,num,varDict)

#for i in range(len(lines)):
    
          
        
outputFile = open("output.txt",'w')
        

pc=0
s=1
for i in range(len(Lines)):
    for j in range(len(Lines[i])):
        #print(Lines[i][j])
        var= Lines[i][j].split()
        
        if(Lines[i][j].count("indexed")>0):
            #print(Lines[i][0])
            pc+=1
            Lines[i][j]=varDict[var[1]][0]
            
        elif(Lines[i][j].count("num")>0):
            Lines[i][j]= Lines[i][j].replace("num","")
            pc+=1
            
        elif(Lines[i][j].count("branch")>0):
             
            ARR = branch(var,pc)
            Lines[i][j] = ARR
            
        elif(Lines[i][j].count("jmp1op")>0):
             
            ARR = JSR(var,num)
            num = ARR[1]
            ARR = ARR[0]
            Lines[i][j] = ARR
            pc+=1
    pc+=1
    
Lines.append('\n')
for i in range(len(value)):
    Lines.append(format(int(value[i]),"016b"))
    Lines.append('\n')
    
print(Lines)
        
for i in range(len(Lines)): 
    for j in range(len(Lines[i])):       
        #print(Lines[i],'\n')
        outputFile.write(Lines[i][j])
           

