help.start()

install.packages("Rcmdr")
library("Rcmdr")

is.list(mtcars)

mod <- lm(mpg ~ wt, data = mtcars)
is.list(mod)

## ------------------------------------------------------------------------
"Hola mundo!"
# Esto es un comentario

y <- 2 + 2         # Asignación
y^y / 10*pi + 1    # Expresión
matrix(1, nrow = y/2, ncol = y)

## ------------------------------------------------------------------------
str(matrix(data = 1, y/2, y))

## ----vectores------------------------------------------------------------
logico   <- c(TRUE, FALSE, T)
entero   <- c(1L, 6L, 10L)
doble    <- c(a = 1, b = 2.5, c = 4.5)
caracter <- c("Hola", "mundo", "!")

## ------------------------------------------------------------------------
recursivo <- list(id = c(1, 2, 3), var = c("a", "b", "c"),
                  lista = list(4:9, TRUE))
str(recursivo)

## ------------------------------------------------------------------------
## Las tres propiedades principales
typeof(logico)
length(entero)
attributes(doble)

## ------------------------------------------------------------------------
# Las funciones is.* y as.*  logical, integer, double, character, list
is.character(caracter)
as.integer(logico)

# Coerción por defecto:
mean(logico)

## ------------------------------------------------------------------------
str(attributes(doble))

## ------------------------------------------------------------------------
class(doble) # Se pueden modificar: class(doble) <- "myclass"
names(doble)
dim(doble)

## ------------------------------------------------------------------------
NA # logico
NA_integer_; NA_real_; NA_character_;

## ------------------------------------------------------------------------
categoria <- factor(x = c("A", "B", "A", "A", "B"))
typeof(categoria)
attributes(categoria)
table(categoria)

## ------------------------------------------------------------------------
matriz <- matrix(data = runif(4), ncol = 2, nrow = 2)
arreglo <- array(data = rnorm(24), c(2, 3, 4))

dim(caracter) <- c(1, 3)
caracter

str(arreglo)
ncol(matriz); dim(arreglo)

## ------------------------------------------------------------------------
# Nada - util para más dimensiones
doble[]
# Entero positivo
doble[c(1, 2)]
# Entero negativo
doble[-c(1, 2)]

## ------------------------------------------------------------------------
# Logico
doble[doble > 1]
# Caracter
doble[c("a", "c", "c")]

## ------------------------------------------------------------------------
matriz
matriz[, c(TRUE, FALSE)]
matriz[1, , drop = FALSE]

## ------------------------------------------------------------------------
recursivo[[1]]
recursivo$lista[[1]][3:5]

## ------------------------------------------------------------------------
(df <- data.frame(x = c("a", "b", "c"), y = 1:3))

df[2, 2] # Se pueden seleccionar como en las matrices

df$y[2] # Se pueden seleccionar como en las listas

## ------------------------------------------------------------------------
df1 <- data.frame(x = c("a", "b"), y = 1:2)
df2 <- data.frame(x = c("c", "d"), y = c(6, 7))

(df <- rbind(df1, df2))

## ------------------------------------------------------------------------
# Importar de un csv (Enfoque malo)
dat <- read.csv("./data/saber2014II.csv", sep = ";", dec=",")
# head(dat)

# Importar de un csv (Enfoque correcto)
clases <- c(rep("character", 8), rep("numeric", 8), rep("NULL", 7), "character")
datos <- read.csv("./data/saber2014II.csv", sep = ";", dec=",", colClasses = clases)

## ------------------------------------------------------------------------
library(readr)
datos <- read_csv2("./data/saber2014II.csv")

# Nuevo Paquete de Whickham para importar de excel
library(readxl)
saber <- read_excel("./data/saber2014II.xlsx")

# Importar de SPSS con etiquetas
library(haven)
saber <- read_spss("./data/saber2014II.sav")

## ------------------------------------------------------------------------
library(dplyr)
resumen_a <- datos %>%
  mutate(PROMGLOBAL = (PROMMATEMATICA + PROMINGLES + PROMLECTURACRITICA +
                       PROMSOCIALESYCIUDADANAS +  PROMCIENCIASNATURALES + 
                       PROMRAZONAMIENTOCUANTITA + PROMCOMPETENCIASCIUDADAN)/7) %>%
  group_by(NOMBREMUNICIPIO) %>%
  summarize(DEPARTAMENTO = max(DEPARTAMENTO), TOTAL_EVALUADOS = sum(EVALUADOS)) %>%
  arrange(desc(TOTAL_EVALUADOS)) %>%
  mutate(ranking = row_number()) %>%
  select(ranking, DEPARTAMENTO, NOMBREMUNICIPIO, TOTAL_EVALUADOS)

## ------------------------------------------------------------------------
resumen_a

## ------------------------------------------------------------------------
resumen_b <- datos %>%
  mutate(PROMGLOBAL = (PROMMATEMATICA + PROMINGLES + PROMLECTURACRITICA + 
                       PROMSOCIALESYCIUDADANAS +  PROMCIENCIASNATURALES + 
                       PROMRAZONAMIENTOCUANTITA + PROMCOMPETENCIASCIUDADAN)/7) %>%
  group_by(NOMBREMUNICIPIO) %>%
  summarize(DEPARTAMENTO = max(DEPARTAMENTO), 
            PROMGLOBALXMPIO = sum(PROMGLOBAL * EVALUADOS) / sum(EVALUADOS)) %>%
  arrange(desc(PROMGLOBALXMPIO)) %>%
  mutate(ranking = row_number()) %>%
  select(ranking, DEPARTAMENTO, NOMBREMUNICIPIO, PROMGLOBALXMPIO) 

## ------------------------------------------------------------------------
resumen_b

