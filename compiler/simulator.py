from bitstring import BitArray

# Memoria de uso general
RAM = [0] * 600000

# Registros
registers = [0] * 16

# Memoria de instrucciones
instr_mem = []

# PC y PC+1
pc = 0
pcPlus1 = 2

def updatePC():
    global pc, pcPlus1
    pc += 1
    pcPlus1 = pc + 2

def NOP():
    updatePC() # Actualizar PC

def bin2int(number):
    return BitArray(bin=number).int

def SAL(label):
    global pc, pcPlus1
    pc = pcPlus1 + bin2int(label)
    pcPlus1 = pc + 2

def SEQ(reg1, reg2, label):
    global pc, pcPlus1

    # Conversion de binario a entero
    reg1 = bin2int(reg1)
    reg2 = bin2int(reg2)

    # Si el valor de los registros es igual, hace el salto
    if(registers[reg1] == registers[reg2]): 
        pc = pcPlus1 + bin2int(label)
        pcPlus1 = pc + 2
    else:
        updatePC()

def SMQ(reg1, reg2, label):
    global pc, pcPlus1

    # Conversion de binario a entero
    reg1 = bin2int(reg1)
    reg2 = bin2int(reg2)

    # Si el valor de reg1 < reg2, hace el salto
    if(registers[reg1] < registers[reg2]): 
        pc = pcPlus1 + bin2int(label)
        pcPlus1 = pc + 2
    else:
        updatePC()

"""
Funcion para cargar el valor de una direccion en un registro
reg1: registro destino
reg2: registro con la direccion
"""
def CRG(reg1, reg2):
    # Conversion de binario a entero
    reg1 = bin2int(reg1)
    reg2 = bin2int(reg2)

    addr = registers[reg2] # Obtener direccion

    # print(addr)

    registers[reg1] = RAM[addr] # Cargar valor

    updatePC() # Actualizar PC

"""

"""
def ALM(reg1, reg2):
    # Conversion de binario a entero
    reg1 = bin2int(reg1)
    reg2 = bin2int(reg2)

    addr = registers[reg1] # Obtener direccion

    RAM[addr] = registers[reg2] # Guardar valor

    updatePC() # Actualizar PC

def SUM(reg_result, reg1, reg2):
    # Conversion de binario a entero
    reg_result = bin2int(reg_result)
    reg1 = bin2int(reg1)
    reg2 = bin2int(reg2)

    # Suma de los valores en los registros reg1 y reg2
    registers[reg_result] = registers[reg1] + registers[reg2]

    updatePC() # Actualizar PC

def SUMI(reg_result, reg1, imm):
    # Conversion de binario a entero
    reg_result = bin2int(reg_result)
    reg1 = bin2int(reg1)
    imm = bin2int(imm)

    # Suma del valor del registro reg1 e imm
    registers[reg_result] = registers[reg1] + imm

    updatePC() # Actualizar PC

def RES(reg_result, reg1, reg2):
    # Conversion de binario a entero
    reg_result = bin2int(reg_result)
    reg1 = bin2int(reg1)
    reg2 = bin2int(reg2)

    # Suma de los valores en los registros reg1 y reg2
    registers[reg_result] = registers[reg1] - registers[reg2]

    updatePC() # Actualizar PC

def SL(reg_result, reg1, imm):
    # Conversion de binario a entero
    reg_result = bin2int(reg_result)
    reg1 = bin2int(reg1)
    imm = bin2int(imm)

    # Left shift del valor en reg1 un total de imm veces
    registers[reg_result] = registers[reg1] << imm

    updatePC() # Actualizar PC

def SR(reg_result, reg1, imm):
    # Conversion de binario a entero
    reg_result = bin2int(reg_result)
    reg1 = bin2int(reg1)
    imm = bin2int(imm)

    # Left shift del valor en reg1 un total de imm veces
    registers[reg_result] = registers[reg1] >> imm

    updatePC() # Actualizar PC

def CD(reg1, label):
    # Conversion de binario a entero
    label = bin2int(label)
    reg1 = bin2int(reg1)

    # Cargar label en reg1
    registers[reg1] = label

    updatePC() # Actualizar PC

instructions = {
    "0000" : NOP,
    "0001" : SAL,
    "0010" : SEQ,
    "0011" : SMQ,
    "0100" : CRG,
    "0101" : CRG,
    "0110" : ALM,
    "0111" : ALM,
    "1000" : SUM,
    "1001" : SUMI,
    "1010" : RES,
    "1011" : SR,
    "1100" : SL,
    "1111" : CD
}

def readInstruction(filename):
    # Apertura del archivo en modo lectura
    fileObject = open(filename, "r")

    # Lectura de cada linea en el archivo
    global instr_mem
    instr_mem = fileObject.read().split("\n")

opNOP  = "0000"
opSAL  = "0001"
opSEQ  = "0010"
opSMQ  = "0011"
opCRG  = "0100"
opCRGB = "0101"
opALM  = "0110"
opALMB = "0111"
opSUM  = "1000"
opSUMI = "1001"
opRES  = "1010"
opSR   = "1011"
opSL   = "1100"
opCD   = "1111"

cycles = 0

def simulate():
    global pc
    readInstruction("instructions.txt")
    lenm = len(instr_mem)-1
    while pc < lenm:
        instr = instr_mem[pc]  # Se obtiene la instruccion

        global registers
        reg = registers

        # Instrucciones generales
        opcode  = instr[0:4]
        reg_src = instr[4:8]
        reg     = instr[8:12]
        reg_des = instr[12:16]
        imm     = instr[16:32]

        # Saltos
        label = instr[12:32]

        # Load Address
        addr = instr[8:32]

        global cycles
        cycles += 1

        # Instrucciones de cargar memoria
        if opcode in (opCRG, opCRGB):
            instructions[opcode](reg_des, reg_src)

        # Instrucciones de almacenar en memoria
        elif opcode in (opALM, opALMB):
            instructions[opcode](reg_src, reg)
        
        # Instrucciones de procesamiento de datos
        elif opcode in (opSUM, opRES):
            instructions[opcode](reg_des, reg_src, reg)
        
        # Instrucciones de procesamiento de datos con inmediato
        elif opcode in (opSUMI, opSL, opSR):
            instructions[opcode](reg_des, reg_src, imm)
        
        # Instruccion de salto no condicional
        elif opcode in (opSAL):
            instructions[opcode](label)
        
        # Instrucciones de salto condicional
        elif opcode in (opSEQ, opSMQ):
            instructions[opcode](reg_src, reg, label)        
            
        # Instruccion Load address
        elif opcode in (opCD):
            instructions[opcode](reg_des, label)

        # Instruccion NOP
        else:
            instructions[opcode]()
    print("Ciclos totales")
    print(cycles)
