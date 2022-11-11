input_mass:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 100016
        mov     DWORD PTR [rbp-4], 0
.L2:
        mov     rax, QWORD PTR stdin[rip]
        mov     rdi, rax
        call    fgetc
        mov     BYTE PTR [rbp-5], al
        mov     eax, DWORD PTR [rbp-4]
        lea     edx, [rax+1]
        mov     DWORD PTR [rbp-4], edx
        cdqe
        movzx   edx, BYTE PTR [rbp-5]
        mov     BYTE PTR [rbp-100016+rax], dl
        mov     eax, DWORD PTR [rbp-4]
        sub     eax, 1
        cdqe
        movzx   eax, BYTE PTR [rbp-100016+rax]
        cmp     al, 10
        jne     .L2
        mov     eax, DWORD PTR [rbp-4]
        cdqe
        mov     BYTE PTR [rbp-100016+rax], 0
        lea     rax, [rbp-100016]
        mov     QWORD PTR [rbp-16], rax
        mov     rax, QWORD PTR [rbp-16]
        leave
        ret
check:
        push    rbp # в первых двух строчках происходит обьявление функции
        mov     rbp, rsp # и тут тоже
        mov     eax, edi # здесь происходит передача параметра из edi в eax (в комментариях в мейне поясняю..)
        mov     BYTE PTR [rbp-4], al # где в edi кладется передаваемое значение
        cmp     BYTE PTR [rbp-4], 97 # далее просто происходят проверки
        je      .L5
        cmp     BYTE PTR [rbp-4], 101
        je      .L5
        cmp     BYTE PTR [rbp-4], 111
        je      .L5
        cmp     BYTE PTR [rbp-4], 105
        je      .L5
        cmp     BYTE PTR [rbp-4], 117
        je      .L5
        cmp     BYTE PTR [rbp-4], 121
        je      .L5
        cmp     BYTE PTR [rbp-4], 65
        je      .L5
        cmp     BYTE PTR [rbp-4], 69
        je      .L5
        cmp     BYTE PTR [rbp-4], 79
        je      .L5
        cmp     BYTE PTR [rbp-4], 73
        je      .L5
        cmp     BYTE PTR [rbp-4], 85
        je      .L5
        cmp     BYTE PTR [rbp-4], 89
        jne     .L6
.L5:
        mov     eax, 1 # если проверка успешна, то кладем в eax 1
        jmp     .L7
.L6:
        mov     eax, 0 # если не успешна, то кладем в eax 0
.L7:
        pop     rbp
        ret
.LC0:
        .string "%d"
main:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     eax, 0
        call    input_mass # вызываем функцию input_mass, которая кладет в rax возвращаемое значение
        mov     QWORD PTR [rbp-16], rax # здесь мы кладем в str rax
        mov     DWORD PTR [rbp-4], 0 # инициализация локальной переменной j нулем
        jmp     .L9
.L12:
        mov     eax, DWORD PTR [rbp-4] # здесь программа начинает выполнять проверку
        movsx   rdx, eax
        mov     rax, QWORD PTR [rbp-16]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax] # в следующих 3 строках (включая эту) происходит передача str[j] в параметр..
        movsx   eax, al # в регистры eax и edi, из которых происходит считывание в check
        mov     edi, eax # и тут
        call    check # вызываем check, который возвращает значение в eax
        cmp     eax, 1 сравниваем eax c 1
        jne     .L10 # а тут, закончив проверку, заходит / не заходит в else
        mov     eax, DWORD PTR [rbp-4] # тут начинаем печатать десятичный код гласных
        movsx   rdx, eax
        mov     rax, QWORD PTR [rbp-16]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        movsx   eax, al
        mov     esi, eax
        mov     edi, OFFSET FLAT:.LC0
        mov     eax, 0
        call    printf # тут заканчиваем
        jmp     .L11
.L10:
        mov     eax, DWORD PTR [rbp-4] # а тут просто начинаем печатать согласных (блок else)
        movsx   rdx, eax
        mov     rax, QWORD PTR [rbp-16]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        movsx   eax, al
        mov     edi, eax
        call    putchar # а тут заканчиваем
.L11:
        add     DWORD PTR [rbp-4], 1 # прибавляем к j 1
.L9:
        mov     eax, DWORD PTR [rbp-4] # здесь у нас проверка блока while
        movsx   rdx, eax
        mov     rax, QWORD PTR [rbp-16]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        test    al, al
        jne     .L12 # здесь заканчивается проверка блока вайл
        mov     eax, 0 
        leave
        ret