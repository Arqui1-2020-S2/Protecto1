# ImageUitls

## Introducción

> Este progrma permite generar archivos para creación de la memoria de inicialización, asi como visualizar la imagen de resultado.


## Ejemplos 

### Generar  archivos .mif dada una ruta de imagen.
``` bash
python3  imageUtils.py -i inputImage.png
```
Toma una imagen y guarda tres archivos en .mif en la ruta output con la información en pixeles, normalizados a un valor por pixel.
### Visualizar el resultado de una imagen
``` bash 
python3  imageUtils.py -s input
```
Toma archivos de salida generados por el procesador y unifica los arreglos de los datos de salida para para poder mostrar una imagen de resultado.

Formato de archivo:

index : value;

