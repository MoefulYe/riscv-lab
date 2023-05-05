sum:
  add t0, a0, zero; # 传参数n
  addi t1, zero, 1;  # i = 1
  addi t2, zero, 0;  # sum = 0
.l1:
  bgt t1, t0, .l2;   # if i > n goto .l2
  add t2, t2, t1;    # sum += i
  addi t1, t1, 1;    # i++
  j .l1;             # goto .l1
.l2:
  add a0, t2, zero;  # return sum
  jr ra;             # 

main:
  addi a0, zero, 10; # 调用sum(10)
  jal sum;
