def compile(filename):
    # Apertura del archivo en modo lectura
    fileObject = open(filename, "r")

    # Lectura de cada linea en el archivo
    lines = fileObject.read().split("\n") 

    file = open("result_image_OCTAVE.txt", "w")
    for i in range(0, len(lines)):
        line = lines[i]
        content = line.split(" ")
        file.write(str(content[-1]) + " ")

compile("result_image.txt")
