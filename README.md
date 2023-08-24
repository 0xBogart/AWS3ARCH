# ＡＷＳ３ＡＲＣＨ
aws3arch es una herramienta de enumeración de Buckets S3 AWS existentes, incluyendo su región asignada.
<br><br>
## Características
- Reconocimiento de la existencia o no existencia de un Bucket S3 en AmazonAWS
- Cada Bucket S3 reconocido como existente, será capaz de encontrar su región correspondiente
<br><br>
## ¿Cómo Funciona?
- Lee como primer argumento '$1' el dominio [Es necesario omitir cualquier extensión .com|.es|.net|.org|etc]
- Lee múltiples dominios desde un fichero
- La estructura de un fichero deberá contener 1 dominio por linea
- Si el Bucket S3 no existe, será reportado como NO existente
<br><br>
## Modo de Uso
./aws3arch.sh domain

./aws3arch -r domains.txt
<br><br>
## Ejemplos
`
./aws3arch.sh amazonaws
`
```
ＡＷＳ３ＡＲＣＨ
______________

Bucket amazonaws  >> amazonaws.s3.ap-south-1.amazonaws.com
```
<br><br>
`
./aws3arch.sh -r domains.txt
`
```
ＡＷＳ３ＡＲＣＨ
______________

Bucket amazonaws  >> amazonaws.s3.ap-south-1.amazonaws.com
Bucket amazon     >> S3 Bucket amazon does NOT exist
```
