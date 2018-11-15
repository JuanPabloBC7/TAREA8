Include MACRO1.lib
Include macros.lib
.MODEL SMALL
.STACK
.DATA
SMS0    DB  13,10,'------------MENU PRINCIPAL------------ $'
SMS1    DB  13,10,'|1.EJERCICIO 1: USANDO MACROS        | $'
SMS2    DB  13,10,'|2.EJERCICIO 3: MANEJO DE MATRICES   | $'
SMS3    DB  13,10,'|6.SALIR                             | $'
SMSO    DB  13,10,'-------------------------------------- $'

SMS01   DB  13,10,'LA PRIMERA OPERACION DE LOS MARCOS ES: $'
SMS02   DB  13,10,'LA SEGUNDA OPERACION DE LOS MARCOS ES: $'
SMS03   DB  13,10,'LA TERCERA OPERACION DE LOS MARCOS ES: COCIENTE: $'
SMS04   DB  ', RESIDUO: $'
MENU    DB ?
A    DB 8
B    DB 3
C    DB 5
OP1D DB ?
OP1U DB ?
OP2D DB ?
OP2U DB ?
OP3C DB ?
OP3R DB ?


    Matriz DB 100 DUP(0) ;arreglo para mantener la matriz
    I DB 1; Contador de filas
    J DB 1; Contador de columnas
    K DB 1; Posici?n lexicogr?fica en la matriz
    TamanoMatriz DB 1; Variable para mantener el tama?o de la matriz
    MensajeFilas DB 'Ingrese cantidad de filas de la matriz: $';
    MensajeColumnas DB 'Ingrese cantidad de columnas de la matriz: $';
    MensajeTamanoMatriz DB 'Cantidad de posiciones de matriz: $'
    Celda DB '*$'
    CambioLinea DB 10,13,'$'
    Columna DB 1
    Fila DB 1
    X DB 1
    Y DB 1 
.386
.CODE
PROGRAMA:
    MOV AX,@data
    MOV DS,AX
    
    MENUPRINCIPAL:
        XOR DX,DX
        MOV DX,OFFSET SMS0
        CALL IMPRIMIR
        MOV DX,OFFSET SMS1
        CALL IMPRIMIR
        MOV DX,OFFSET SMS2
        CALL IMPRIMIR
        MOV DX,OFFSET SMS3
        CALL IMPRIMIR
        MOV DX,OFFSET SMSO
        CALL IMPRIMIR        ;FINALIZACION DE LA IMPRESION DE MENSAJES DEL MENU PRINCIPAL
        CALL LINEA
        
        MOV AH,01H  ;_________________________________________________________________________________RECIBIR UN DATO DEL TECLADO
        INT 21H
        SUB AL,30H
        MOV MENU,AL
        CALL LINEA
        
        ADD MENU,30H    ;_______________________________________________________________________________________PASARLO A DECIMAL
        CMP MENU,49     ;INICIO DE COMPARACIONES DEL MENU PRINCIPAL PARA IRME A LOS DISTINTOS PROCEDIMIENTOS
        JE MACROS
        CMP MENU,50
        JE MATRICES
        CMP MENU,54
        JE SALIR        ;FINALIZACION DE COMPARACIONES PARA EL MENU PRINCIPAL DE LOS DISTINTOS PROCEDIMIENTOS
        
    IMPRIMIR PROC
        MOV AH,09H
        INT 21H
        RET
        IMPRIMIR ENDP
    
    LINEA PROC 
        MOV DL,10   
        MOV AH,02H
        INT 21H
        RET
        LINEA ENDP
    IMPNUM PROC
        MOV AH,02H
        INT 21H
        RET
        IMPNUM ENDP    
    MACROS:
        OPERACION1 A,B,C,OP1D,OP1U
        MOV DX,OFFSET SMS01
        CALL IMPRIMIR
        MOV DL,OP1D
        CALL IMPNUM
        MOV DL,OP1U
        CALL IMPNUM
        
        OPERACION2 A,B,C,OP2D,OP2U
        MOV DX,OFFSET SMS02
        CALL IMPRIMIR
        MOV DL,OP2D
        CALL IMPNUM
        MOV DL,OP2U
        CALL IMPNUM
        
        OPERACION3 A,B,C,OP3C,OP3R
        MOV DX,OFFSET SMS03
        CALL IMPRIMIR
        MOV DL,OP3C
        CALL IMPNUM
        MOV DX,OFFSET SMS04
        CALL IMPRIMIR
        MOV DL,OP3R
        CALL IMPNUM
        JMP MENUPRINCIPAL
        
    MATRICES:
        call Clrscr
        GotoXY 5,5              ;Se llama al macro para mover el cursor     
        ImprimeCadena MensajeFilas      ;Se llama al macro de impresi?n de la cadena
        CapturaNumero I
        ;PrintNumero I
        GotoXY 5,6
        ImprimeCadena MensajeColumnas
        CapturaNumero J
        ;PrintNumero J
        Mov AL,I
        Mov BL, J
        Mul BL
        Mov TamanoMatriz,AL
        GotoXY 5, 7
        ImprimeCadena MensajeTamanoMatriz
        PrintNumero TamanoMatriz
        ;call clrscr 
        Mov Y,00
        Mov Fila,10
        CicloFilas:
            Mov X,00
            Mov Columna, 30
        CicloColumnas:
            GotoXY Columna,Fila
            Mapeo Y,X,I,J,1
            PrintNumero AL
            Inc Columna
            Inc Columna
            Inc Columna
            Inc X
            Mov CL,X
            cmp CL,J
            jl CicloColumnas
            inc Y       
            inc Fila
            Mov CL,Y
            cmp CL,I
            jl CicloFilas
            CALL LINEA
            CALL LINEA
            JMP MENUPRINCIPAL
        
        Clrscr proc near
            Mov AH,0
            Mov Al,02
            int 10h
            ret
        
    SALIR:
    MOV AH,4CH
    INT 21H
END PROGRAMA