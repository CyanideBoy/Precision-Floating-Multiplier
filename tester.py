def to_int(bin):
    x = int(bin, 2)
    return x


import numpy as np

f = open("TRACEFILE.txt","w")

for x in range(256):
    for y in range(256):
        
        s1 = bin(x)[2:].zfill(8)
        s2 = bin(y)[2:].zfill(8)

        ex1 = to_int(s1[1:4])-3
        man1 = to_int('1'+s1[4:])
        man1 = man1/16

        ex2 = to_int(s2[1:4])-3
        man2 = to_int('1'+s2[4:])
        man2 = man2/16

        if(s1[0]=='1'):
            v1 = -man1*(2**(ex1))
        else:
            v1 = man1*(2**(ex1))


        if(s2[0]=='1'):
            v2 = -man2*(2**(ex2))
        else:
            v2 = man2*(2**(ex2))
        
        sol = v1*v2

        
        ansb = bin(np.float16(sol).view('H'))[2:].zfill(16)
        f.write(s1+s2+" "+ansb+" 1111111111111111"+"\n")


