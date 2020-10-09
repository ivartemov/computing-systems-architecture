format PE console
include 'win32a.inc'
entry start
section 'data' data readable writeable
        integer db '%d',0
        space db ' ',0
        Enter_size db 'Enter A array size:',13,10,0
        Enter_elements db 'Enter A array:',13,10,0
        stop dd 0
        array_size dd 0
        array_1 dd 0
        array_2 dd 0
        array_1.length dd 0
        array_2.length dd 0
section 'text' code readable executable
start:
        cinvoke printf,Enter_size
        cinvoke scanf,integer,array_1.length
        mov eax,[array_1.length]
        dec eax
        mov [array_2.length],eax
        mov eax,[array_1.length]
        shl eax,2
        mov [array_size],eax
        cinvoke malloc,[array_size]
        mov [array_1],eax
        cinvoke malloc,[array_size]
        mov [array_2],eax
        call LoadArray
        call Main
        call PrintResult
        cinvoke free,[array_1]
        cinvoke free,[array_2]
        cinvoke scanf,integer,stop
        ret
LoadArray:
        cinvoke printf,Enter_elements
        mov edx,[array_1]
        mov ecx,[array_1.length]
        .input_loop:
        push edx ecx
        cinvoke scanf,integer,edx
        pop ecx edx
        add edx,4
        loop .input_loop
        ret
Main:
        mov eax,[array_1]
        mov ecx,[array_1.length]
        mov edx,[array_2]
        cmp ecx,1
        jbe .end
        dec ecx
        .fl:
        mov ebx,[eax]
        add ebx,[eax+4]
        mov [edx],ebx
        add eax,4
        add edx,4
        loop .fl
        .end:
        ret
PrintResult:
        cinvoke printf,space
        mov eax,[array_2]
        mov ecx,[array_2.length]
        .print_loop:
        push eax ecx
        cinvoke printf,integer,[eax]
        cinvoke printf,space
        pop ecx eax
        add eax,4
        loop .print_loop
        ret

section 'import' import readable

library msvcrt,'msvcrt.dll'
import msvcrt,\
       printf,'printf',\
       scanf,'scanf',\
       free,'free',\
       malloc,'malloc'
