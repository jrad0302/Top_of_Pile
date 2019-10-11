#     T o p  o f  P i l e
#
#
# This routine finds the color of the part on top of a pile.
#
# Name: Johnathan Radcliff
# Date: 10/09/19

.data
Pile:  .alloc   1024

.text

TopColor:   addi    $1, $0, Pile       # point to array base
            swi 545                                 # generate pile
                # your code goes here

            addi    $7, $0, 254    # ans = b11111110, where each bit represents a color
            addi    $2, $0, 64     # i = 64, where i is the iteration bit
            addi    $1, $0, 0      # counter

    Trav:   lb      $8, Pile($2)   # pix = Pile [i]
            beq     $8, $0, Loop   # if pix = 0, branch
            srlv    $6, $7, $8     # ans >> pix
            andi    $6, $6, 1      # (ans >> pix) & 1
            beq     $6, $0, Loop   # if the result above is zero, restart

            # Check the left and right
            addi    $6, $2, 1      # i + 1
            lb      $4, Pile($6)   # r_pix = Pile[i + 1]
            beq     $4, $0, Loop   # if r_pix == 0, restart
            addi    $6, $2, 64     # i + 64
            lb      $5, Pile($6)   # b_pix = Pile[i + 64]
            beq     $5, $0, Loop   # if b_pix == 0, restart

            beq     $4, $5, Loop   # if they're equal, restart
            beq     $4, $8, func   # if r_pix == pix, move to the next step 
            add     $5, $0, $4     # put b_pix in R4

    func:   beq     $4, $8, Loop   # if the pixels are equal, restart

            addi    $6, $0, 1      # 1
            sllv    $6, $6, $4     # 1 << pix
            nor     $6, $6, $6     # ~(1 << pix) 
            and     $7, $7, $6     # ans = ans & ~(1 << pix)

            addi    $1, $1, 1      # counter++
            addi    $6, $0, 6      # 6 - amount of max removals 
            beq     $1, $6, Prep   # break  

    Loop:   addi    $2, $2, 1      # i + 1
            j Trav         

    Prep:   addi    $2, $0, -1     # TopColor = -1

    Log2:   sra     $7, $7, 1      # ans >> 1
            addi    $2, $2, 1      # TopColor++
            bne     $7, $0, Log2   # do while(ans != 0) 

            
            swi 546         # submit answer and check
            jr  $31         # return to caller
