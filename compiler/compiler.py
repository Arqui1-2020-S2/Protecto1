# Nombre de las instrucciones
NOP  = "NOP"
SAL  = "SAL"
SEQ  = "SEQ"
SMQ  = "SMQ"
CRG  = "CRG"
CRGB = "CRGB"
ALM  = "ALM"
ALMB = "ALMB"
SUM  = "SUM"
SUMI = "SUMI"
RES  = "RES"
SR   = "SR"
SL   = "SL"
CD   = "CD"

# Diccionario con el codigo de las instrucciones
instructions = {
    NOP  : "0000",
    SAL  : "0001",
    SEQ  : "0010",
    SMQ  : "0011",
    CRG  : "0100",
    CRGB : "0101",
    ALM  : "0110",
    ALMB : "0111",
    SUM  : "1000",
    SUMI : "1001",
    RES  : "1010",
    SR   : "1011",
    SL   : "1100",
    CD   : "1111"
}

# Diccionario con los registros y su codigo
registers = {
    "R0"  : "0000",
    "R1"  : "0001",
    "R2"  : "0010",
    "R3"  : "0011",
    "R4"  : "0100",
    "R5"  : "0101",
    "R6"  : "0110",
    "R7"  : "0111",
    "R8"  : "1000",
    "R9"  : "1001",
    "R10" : "1010",
    "R11" : "1011",
    "R12" : "1100",
    "R13" : "1101",
    "R14" : "1110",
    "R15" : "1111"
}

labels = {}       # Diccionario donde se almacenan los labels
program = []      # Lista donde se guardan todas las instrucciones codificadas
lineCodeCount = 0 # Contador de lineas de instruccion
branch_instr = [] # Lista que almacena las instrucciones de salto 

"""
Funcion encargada de compilar el archivo ingresado
filename: string con la ruta del archivo
"""
def compile(filename):
    # Apertura del archivo en modo lectura
    fileObject = open(filename, "r")

    # Lectura de cada linea en el archivo
    lines = fileObject.read().split("\n") 

    # Compilacion de las instrucciones de procesamiento de datos y memoria
    for i in range(0, len(lines)):
        analyzeLine(lines[i])

    # Compilacion de las instrucciones de salto
    analyzeBranch()

    # Escritura del codigo compilado en un archivo
    writeCodeMif()
    writeCode()


"""
Funcion para agregar un nuevo label en el diccionario, 
se hace una verificacion que no haya sido declarado antes
label: elemento que se desea agregar
"""
def addLabel(label):
    # Se verifica que el label no haya sido declarado antes
    if label in labels:
        error = ": Label '" + str(label) + "' ya ha sido declarado antes."
        raise Exception(error)
    else:
        # Se agrega el label apuntando a la siguiente instruccion
        labels[label] = lineCodeCount + 1 

"""
Funcion para obtener el codigo de una instruccion, se realiza una verificacion
de que el nombre ingresado exista
opname: string con el nombre de la instruccion
"""
def getInstructionCode(opname):
    if opname not in instructions:
        raise Exception("Instruccion '" + opname + "' no existe")
    else:
        return instructions[opname]

"""
Funcion para convertir un numero decimal a binario, utilizando una cantidad 
definida de bits, extendiendo las posiciones restante segun el signo
bits: numero de bits en el que debe ser representado el numero binario
number: string con el numero que se debe convertir
"""
def decimalToBinary(number, bits):
    s = bin(int(number) & int("1"*bits, 2))[2:]
    return ("{0:0>%s}" % (bits)).format(s)

"""
Funcion para abstraer la codificacion de una instruccion general 
(las que no son de branch ni Load address)
opname: string con el nombre de operacion
regSrc: primer registro utilizado en la instruccion
reg: segundo registro utilizado en la instruccion
regDestiny: registro de destino para el resultado
immediate: inmediato utilizado en la operacion
"""
def codeGeneralInstruction(opname, regSrc, reg, regDestiny, immediate):
    instr = getInstructionCode(opname) + \
            registers[regSrc] + \
            registers[reg] + \
            registers[regDestiny] + \
            decimalToBinary(immediate, 16)  # Conversion del inmediato a binario
    return instr

"""
Funcion para abstraer la codificacion de una instruccion de salto
opname: string con el nombre de operacion
branchDirection: string con la direccion de salto
"""
def codeBranchInstruction(opname, branchDirection):
    instr = list("0" * 32)
    instr[0:4] = getInstructionCode(opname)
    instr[12:32] = decimalToBinary(str(branchDirection), 20)
    return "".join(instr)

"""
Funcion para abstraer la codificacion de una instruccion de salto condicional
opname: string con el nombre de la operacion
reg1: string con el primer registro de esta instruccion
reg2: string con el segundo registro de esta instruccion
branchDirection: string con la direccion de salto
"""
def codeBranchCondInstruction(opname, reg1, reg2, branchDirection):
    instr = getInstructionCode(opname) + \
            registers[reg1] + \
            registers[reg2] + \
            decimalToBinary(str(branchDirection), 20)
    return instr

"""
Funcion para abstraer la codificacion de una instruccion de cargar direccion
opname: string con el nombre de la instruccion
regDestiny: string con el registro de destino
address: string con la direccion
"""
def codeLoadAddressInstruction(opname, regDestiny, address):
    instr = getInstructionCode(opname) + \
            registers[regDestiny] + \
            address
    return instr

"""
Funcion para codificar una instruccion de acceso a memoria
instruction: lista con los parametros de la instruccion
return: instruccion codificada
"""
def codeMemoryInstruccion(instruction):
    # Se verifica la cantidad de parametros de la instruccion
    if len(instruction) != 3:
        # 1: nombre de la instruccion
        # 2: registro de destino
        # 3: registro con direccion de memoria
        raise Exception("Numero de parametros no coincide: '" + instruction[0] + "'")
    else:
        # Se codifica la instruccion 
        opname = instruction[0]      # Nombre de la instruccion
        regSrc = instruction[2]      # Registro con el operando
        regDestiny = instruction[1]  # Registro de destino
        immediate = "0"              # Inmediato es cero, esta instruccion no lo utiliza
        return codeGeneralInstruction(opname, regDestiny, regSrc, "R0", immediate)

"""
Funcion para codificar una instruccion de procesamiento de datos
instruction: lista con los parametros de la instruccion
return: instruccion codificada
"""
def codeDataProcessInstruction(instruction):
    if len(instruction) != 4:
        # 1: nombre de la instruccion
        # 2: registro de destino
        # 3: primer operando (registro)
        # 4: segundo operando (registro/inmediato)
        raise Exception("Numero de parametros no coincide: '" + instruction[0] + "'")
    else:
        # Codificacion de la instruccion
        opname = instruction[0]             # Nombre de la instruccion
        regDestiny = instruction[1]         # Registro de destino
        firstOperand = instruction[2]       # Primer operando
        secondOperand = instruction[3]      # Segundo operando

        if secondOperand in registers: 
            # Operacion utilizando solo registros
            return codeGeneralInstruction(opname, firstOperand, secondOperand, regDestiny, "0")

        else:
            if opname not in (SUMI, SL, SR):
                raise Exception("Instruccion '" + opname + "' no soporta inmediatos")
            # Operacion utilizando un inmediato
            return codeGeneralInstruction(opname, firstOperand, "R0", regDestiny, secondOperand)

"""
Funcion para analizar cada linea del codigo, se compila a lenguaje maquina
si es posible, si se trata de un branch se guarda para compilarlo una vez
analizado todo el archivo
line: linea que debe ser analizada
"""
def analyzeLine(line):
    # Se divide la linea utilizando espacios como delimitador
    content = line.split(" ")

    # Se eliminan los strings vacios de la lista
    content = list(filter(lambda a: a != '', content))

    if len(content) > 0:
        # Se verifica si el primer elemento es un label
        if content[0] not in instructions and len(content) == 1:
            # Se agrega el label al diccionario
            addLabel(content[0])

        else: # Se trata de una instruccion
            global lineCodeCount
            lineCodeCount += 1
            instr = ""
            opname = content[0] # Se obtiene la instruccion
            
            # Codificacion de instrucciones de memoria
            if opname in (CRG, CRGB, ALM, ALMB):
                instr = codeMemoryInstruccion(content)
                program.append(instr)
            
            # Codificacion de instrucciones de procesamiento de datos
            elif opname in (SUM, SUMI, RES, SR, SL):
                instr = codeDataProcessInstruction(content)
                program.append(instr)
            
            # Guardado de la instruccion para codificarla al final
            elif opname in (SAL, SEQ, SMQ):
                # Se agrega la instruccion a la lista de saltos,
                #  con su respectivo numero de linea
                branch_instr.append([content, lineCodeCount])

            # Instruccion NOP
            elif opname == NOP:
                program.append("0"*32)

            else:
                raise Exception("Instruccion '" + opname + "' no existe")

"""
Funcion que se ejecuta al final del analisis para compilar las instrucciones de salto
"""
def analyzeBranch():
    for i in range(0,len(branch_instr)):
        instr = branch_instr[i][0]      # Se obtiene la instruccion sin codificar
        lineNum = branch_instr[i][1]    # Se obtiene el numero de linea de la instruccion
        opname = instr[0]               # Nombre de la operacion
        label = instr[-1]               # Direccion de salto
        codedInstr = ""

        # Verificacion que el label exista
        if label not in labels:
            raise Exception("Label '" + label + "' no declarado")
        
        labelLine = labels[label] # Obtener linea donde apunta el label
        branchDirection = labelLine - (lineNum+1) # Obtener cantidad de saltos 
        
        if opname == SAL:
            # Codificacion de branch no condicional
            codedInstr = codeBranchInstruction(opname, branchDirection)

        else:
            # Codificacion de branch condicional
            reg1 = instr[1]
            reg2 = instr[2]
            codedInstr = codeBranchCondInstruction(opname, reg1, reg2, branchDirection)
        
        # Se inserta la instruccion en la posicion que le corresponde
        program.insert(lineNum-1, codedInstr)

"""
Escribe el codigo compilado en un archivo de texto
"""
def writeCode():
    file = open("instructions.txt", "w")
    for i in range(0, len(program)):
        file.write(program[i] + "\n")


header = """DEPTH = 4096; -- The size of memory in words
WIDTH = 32; -- The size of data in bits 
ADDRESS_RADIX = DEC; -- The radix for address values 
DATA_RADIX = BIN; -- The radix for data values 
CONTENT -- start of (address : data pairs) 
BEGIN"""


"""
Escribe el codigo compilado en un archivo .mif
"""
def writeCodeMif():
    file = open("instructions.mif", "w")
    header = """DEPTH = 4096; -- The size of memory in words
    WIDTH = 32; -- The size of data in bits 
    ADDRESS_RADIX = DEC; -- The radix for address values 
    DATA_RADIX = BIN; -- The radix for data values 
    CONTENT -- start of (address : data pairs) 
    BEGIN"""
    file.write(header + "\n")
    for i in range(0, len(program)):
        file.write(str(i)+" : "+program[i] + ";\n")
    file.write("END;" + "\n")
