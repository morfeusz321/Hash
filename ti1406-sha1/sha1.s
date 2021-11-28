.global sha1_chunk

sha1_chunk:
	push %rbx
	push %r12
	push %r13
	push %r14
	push %r15
start:
	movq $16,%r11
loop1:
	movq %r11,%r12
	subq $3,%r12
	movl (%rsi,%r12,4),%ebx


	subq $5,%r12
	movl (%rsi,%r12,4),%r13d

	xorl %r13d,%ebx
	
	subq $6,%r12
	movl (%rsi,%r12,4),%r13d

	xor %r13d,%ebx

	subq $2,%r12
	movl (%rsi,%r12,4),%r13d
	
	xor %r13d,%ebx
	
	roll $1,%ebx
	movl %ebx,(%rsi,%r11,4)
	incq %r11
	cmp $79,%r11
	jle loop1

	movq $0,%r12
	movl (%rdi),%r12d
	movq $0,%r13
	movl 4(%rdi),%r13d
	movq $0,%r14
	movl 8(%rdi),%r14d
	movq $0,%r15
	movl 12(%rdi),%r15d
	movq $0,%rbx
	movl 16(%rdi),%ebx
	movq $0,%r11

loop2:
	cmp $20,%r11
	je loop3
	movl %r14d,%r9d #move c to r9
	movl %r15d,%r10d #move d to r10
	andl %r13d,%r14d # b and c (store c)
	notl  %r13d
	andl %r13d,%r15d
	or %r14d,%r15d
	movl %r15d,%r8d
	movl %r9d,%r14d
	movl %r10d,%r15d
	not %r13d


	movl $0,%r9d
	movl %r12d,%r10d
	rol $5,%r12d
	addl %r12d,%r8d #a+f
	movl %r10d,%r12d
	addl %ebx,%r8d #a+f+e
	addl $0x5A827999,%r8d #a+f+e+k
	addl (%rsi, %r11, 4),%r8d#a+f+e+k+w


	movl %r8d,%r9d #temp = line above
	movl %r15d,%ebx # e = d
	movl %r14d,%r15d #d = c
	rol $30,%r13d #leftrotate 30
	movl %r13d,%r14d #c = b leftrotate 30
	movl %r12d,%r13d #b = a
	movl %r9d,%r12d #a = temp
	incq %r11
	jmp loop2
loop3:
	cmp $40,%r11
	je loop4
	movl %r13d,%r10d
	xor %r14d,%r13d # b xor c
	xor %r15d,%r13d # b xor c xor d
	movl %r13d,%r8d # f = b xor c xor d
	movl %r10d,%r13d
	movq $0,%r9
	movl %r12d,%r10d
	rol $5,%r12d
	addl %r12d,%r8d #a+f
	movl %r10d,%r12d
	addl %ebx,%r8d #a+f+e
	addl $0x6ED9EBA1,%r8d #a+f+e+k
	addl (%rsi, %r11, 4),%r8d#a+f+e+k+w
	movl %r8d,%r9d #temp = line above
	movl %r15d,%ebx # e = d
	movl %r14d,%r15d #d = c
	rol $30,%r13d #leftrotate 30
	movl %r13d,%r14d #c = b leftrotate 30
	movl %r12d,%r13d #b = a
	movl %r9d,%r12d #a = temp
	incq %r11
	jmp loop3
loop4:
	cmp $60,%r11
	je loop5
	movl %r15d,%r10d
	movl %r14d,%r9d
	movl %r14d,%r9d
	and %r14d,%r15d #(c and d) 
	and %r13d,%r14d #(b and c)
	or %r15d,%r14d #(b and c) or (c and d) 
	movl %r14d,%r8d#f=(b and c) or (c and d)
	movl %r10d,%r15d
	and %r13d,%r15d #(b and d)
	or %r15d,%r8d
    movl %r10d,%r15d
	movl %r9d,%r14d
	movl $0,%r9d
	movl %r12d,%r10d
	rol $5,%r12d
	addl %r12d,%r8d #a+f
	movl %r10d,%r12d
	addl %ebx,%r8d #a+f+e
	movl $0x8F1BBCDC,%eax
	addl %eax,%r8d #a+f+e+k
	addl (%rsi, %r11, 4),%r8d#a+f+e+k+w
	movl %r8d,%r9d #temp = line above
	movl %r15d,%ebx # e = d
	movl %r14d,%r15d #d = c
	rol $30,%r13d #leftrotate 30
	movl %r13d,%r14d #c = b leftrotate 30
	movl %r12d,%r13d #b = a
	movl %r9d,%r12d #a = temp
	incq %r11
	jmp loop4
loop5:
	cmp $80,%r11
	je end
	movl %r13d,%r10d
	xor %r14d,%r13d # b xor c
	xor %r15d,%r13d # b xor c xor d
	movl %r13d,%r8d # f = b xor c xor d
	movl %r10d,%r13d
	movq $0,%r9
	movl %r12d,%r10d
	rol $5,%r12d
	addl %r12d,%r8d #a+f
	movl %r10d,%r12d
	addl %ebx,%r8d #a+f+e
	addl $0xCA62C1D6,%r8d #a+f+e+k
	addl (%rsi, %r11, 4),%r8d#a+f+e+k+w
	movl %r8d,%r9d #temp = line above
	movl %r15d,%ebx # e = d
	movl %r14d,%r15d #d = c
	rol $30,%r13d #leftrotate 30
	movl %r13d,%r14d #c = b leftrotate 30
	movl %r12d,%r13d #b = a
	movl %r9d,%r12d #a = temp
	incq %r11
	jmp loop5
end:

	addl %r12d,(%rdi)
	addl %r13d,4(%rdi)
	addl %r14d,8(%rdi)
	addl %r15d,12(%rdi)
	addl %ebx,16(%rdi)

	pop %r15
	pop %r14
	pop %r13
	pop %r12
	pop %rbx



	ret
