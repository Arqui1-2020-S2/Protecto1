from simulator import simulate, RAM, registers
from PIL import Image

def loadImage(filename):
    image = Image.open(filename, "r")
    pixels = list(image.getdata())
    counter = 65536
    for item in range(0, len(pixels) ):
        singlePixel = (pixels[item][0] + pixels[item][1] + pixels[item][2]) // 3
        RAM[counter] = singlePixel
        counter += 1
    #print(counter)

loadImage("image_test3.png")
simulate()

print("Registros")
print(registers)

print("")
print("Imagen original")
print([RAM[65536], RAM[65537], RAM[65538], RAM[65539], RAM[65540]])
print([RAM[65541], RAM[65542], RAM[65543], RAM[65544], RAM[65545]])
print([RAM[65546], RAM[65547], RAM[65548], RAM[65549], RAM[65550]])
print([RAM[65551], RAM[65552], RAM[65553], RAM[65554], RAM[65555]])
print([RAM[65556], RAM[65557], RAM[65558], RAM[65559], RAM[65560]])


table1 = RAM[0:256]
table2 = RAM[256:512]
table3 = RAM[512:768]
table4 = RAM[768:1024]
table5 = RAM[1024:1280]

print("")
print("Tabla 1 - f(I)")
print(table1)

print("")
print("Tabla 2 - Cuf")
print(table2)

print("")
print("Tabla 3 - Feq")
print(table3)

print("")
print("Tabla 4 - CuFeq")
print(table4)

print("")
print("Table 5 - Remapeo")
print(table5)


file = open("image.txt", "w")
for i in range(262144,422144):
    file.write(str(RAM[i]) + " ")
