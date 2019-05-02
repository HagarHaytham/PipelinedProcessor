
          #two oprands
instDict={'MOV':[2,'01000'],'ADD':[2,'01001'],'SUB':[2,'01010'],
          'AND':[2,'01011'],'OR':[2,'01100'], 'SHL':[2,'01101'], 'SHR':[2,'01110'],
          #one operand
          'NOP':[1,'00000'],'SETC':[1,'00001'],'CLC':[1,'00010'],'NOT':[1,'00011'],
          'INC':[1,'00100'],'DEC':[1,'00101'],'OUT':[1,'00110'],'IN':[1,'00111'],
          #branch
          'JZ':['branch','11000'],'JN':['branch','11001'],'JC':['branch','11010'],
          'JMP':['branch','11011'],'CALL':['branch','11100'],
          #ZERO oprand
          'RET':['branch','11101'],'RTI':['branch','11110'],
          #MEMORY
          'PUSH':['MEM','10000'],'POP':['MEM','10001'],'LDM':['MEM','10010'],
          'LDD':['MEM','10011'],'STD':['MEM','10100'],
          
          }

regDict={
        
    'R0':'0000', 'R1':'0001', 'R2':'0010', 'R3':'0011', 'R4':'0100', 'R5':'0101', 'R6':'0110', 'R7':'0111', 'PC':'1000', 'SP':'1001'}



varDict={}
labelDict={}


def searchDict(inst,dictionary):
    for key, value in dictionary.items():
        if(key==inst):
            return value
        
    return -1

def addToVar(var,val):
    varDict[var]=val
    return

def addToLabel(lbl,val):
    labelDict[lbl]=val
    return


'''def appendLabel(name,address,code):
    labelDict.append([name,address])
    
def searchLables(str):
    for i in range (len(labelDict)):
        if(str == labelDict[i][0]):
            return labelDict[i][1]
    return -1
    
    '''