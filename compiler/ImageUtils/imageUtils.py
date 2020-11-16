from PIL import Image
import numpy as np
import matplotlib.pyplot as plt
import sys, getopt

def getPixelArrayFromFile(filename):
    fileInput = open(filename, "r")
    with open(filename) as file_in:
        lines = []
        for line in file_in:
            lines.append(int(line.replace(';','').split(':')[1]))
    return lines



def plotImage(pixelArray, rows):
    matrix = np.resize(pixelArray, (rows, len(pixelArray) // rows))
    plt.subplot()
    plt.imshow(matrix, cmap="gist_gray")
    plt.savefig("./output/generated.png")
    plt.show()


def writeImageMif(fileName, pixels):
    # filename: "image1part1.mif"
    # filename: "image2part1.mif"
    # filename: "image3part1.mif"
    depth = 2 ** 16
    file = open(fileName, "w")
    header = """DEPTH = {}; -- The size of memory in words
    WIDTH = 8; -- The size of data in bits 
    ADDRESS_RADIX = DEC; -- The radix for address values 
    DATA_RADIX = DEC; -- The radix for data values 
    CONTENT -- start of (address : data pairs) 
    BEGIN""".format(
        depth
    )
    file.write(header + "\n")
    for i in range(0, depth):
        if i < len(pixels):
            file.write(str(i) + " : " + str(pixels[i]) + ";\n")
        else:
            file.write(str(i) + " : " + str(0) + ";\n")

    file.write("END;" + "\n")
    print(""" Archivo generado {filename}""".format(filename = fileName))


def processImage(filename):
    image = Image.open(filename, "r")
    width, height = image.size
    pixels = list(image.getdata())
    singlePixelArrayPart1 = []
    singlePixelArrayPart2 = []
    singlePixelArrayPart3 = []
    for item in range(0, len(pixels) ):
        singlePixel = (pixels[item][0] + pixels[item][1] + pixels[item][2]) // 3
        if item < (2 ** 16):
            singlePixelArrayPart1.append(singlePixel)
        elif (2 ** 16) <= item and item < (2 ** 17):
            singlePixelArrayPart2.append(singlePixel)
        elif item >= (2 ** 17):
            singlePixelArrayPart3.append(singlePixel)
    message = """ 
    Imagen encontrada {filename}
    Ancho {width}
    Largo {height}
    Bloques de Memoria completos {completeBlockSize}
    pixeles restantes {remainder}
    """.format(
        filename=filename,
        width=str(width),
        height=str(height),
        completeBlockSize=str((width * height) // (2 ** 16)),
        remainder=str((width * height) % (2 ** 16)),
    )

    # Primer bloque  de memoria
    # Segundo bloque de memoria
    # Pixeles restantes
    print(message)
    message = """
    Tamaño de parte 1: {len1}
    Tamaño de parte 2: {len2}
    Tamaño de parte 3: {len3}
    """.format(
        len1=str(len(singlePixelArrayPart1)),
        len2=str(len(singlePixelArrayPart2)),
        len3=str(len(singlePixelArrayPart3)),
    )
    print(message)
    writeImageMif("./output/image1part1.mif", singlePixelArrayPart1)
    writeImageMif("./output/image1part2.mif", singlePixelArrayPart2)
    writeImageMif("./output/image1part3.mif", singlePixelArrayPart3)

    # unifyPixelArray = (
    #     singlePixelArrayPart1 +  singlePixelArrayPart2 + singlePixelArrayPart3
    # )
    # plotImage(unifyPixelArray, 400)




def main(argv):
    opts, args = getopt.getopt(argv, "i:s:", ["inputFile", "show" ])
    for opt, arg in opts:
      if opt == '-i':
        # "inputImage.png"
        print(arg)
        processImage(arg)
      elif opt in ("-i", "--inputFile"):
        processImage(arg)
      elif opt in ("-s", "--show"):
        #print("""Analizando archivo: {filename}""".format(filename=arg))
        array1 = getPixelArrayFromFile("""./{inputFolder}/input1.mif""".format(inputFolder = arg))
        array2 = getPixelArrayFromFile("""./{inputFolder}/input2.mif""".format(inputFolder = arg))
        array3 = getPixelArrayFromFile("""./{inputFolder}/input3.mif""".format(inputFolder = arg))
        limit = (400*400)%2**16
        completeImageArray = array1 + array2 + array3[0:limit]
        plotImage(completeImageArray,400)
        #print(len(completeImageArray))

if __name__ == "__main__":
   main(sys.argv[1:])