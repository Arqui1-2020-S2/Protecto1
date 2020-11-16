
def writeImageMif(fileName,pixels):
    # filename: "image1part1.mif"
    # filename: "image2part1.mif"
    # filename: "image3part1.mif"
    file = open(fileName, "w") 
    header = """DEPTH = 65536; -- The size of memory in words
    WIDTH = 8; -- The size of data in bits 
    ADDRESS_RADIX = DEC; -- The radix for address values 
    DATA_RADIX = DEC; -- The radix for data values 
    CONTENT -- start of (address : data pairs) 
    BEGIN"""
    file.write(header + "\n")
    for i in range(0, len(pixels)):
        file.write(str(i)+" : "+str(pixels[i]) + ";\n")
    file.write("END;" + "\n")


writeImageMif("image1part1.mif",[0,11,22,33,44,55,66,77,88,99])