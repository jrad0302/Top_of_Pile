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
            swi 545                              # generate pile
                # your code goes here
            addi    $7, $0, 254     # ans = b11111110, where each bit represents a color
            addi    $2, $1, 128      # i = 64, where i is the iteration bit
            addi    $1, $0, 1       # 1 for the shift     

    Trav:   lb      $8, 0($2)    # pix = Pile [i]
            beq     $8, $0, Loop    # if pix = 0, branch

            # Check the bottom and right
            lb      $4, 64($2)    # b_pix = Pile[i + 64]
            beq     $4, $0, Loop    # if b_pix == 0, restart
            lb      $5, 1($2)    # r_pix = Pile[i + 1]
            beq     $5, $0, Loop    # if r_pix == 0, restart

            beq     $4, $5, Loop    # if they're equal, restart
            addi    $6, $2, -64     # if b_pix is equal, set opp_pix to t_pix
            beq     $8, $5, func    # if b_pix == pix, move to the next step
            addi    $6, $2, -1      # if r_pix is equal, set opp_pix to l_pix
            bne     $8, $4, Loop    # if r_pix == pix, move to the next step

            add     $4, $0, $5      # the b_pix data on the chopping block

    func:   lb      $6, 0($6)    # Pile[i - 64] OR Pile[i - 1]
            beq     $6, $0, Loop    # if that pixel equals zero, restart

            srlv    $6, $7, $4      # ans >> pix
            andi    $6, $6, 1       # (ans >> pix) & 1
            beq     $6, $0, Loop    # if the result above is zero, restart

            sllv    $6, $1, $4      # 1 << pix
            nor     $6, $6, $6      # ~(1 << pix) 
            and     $7, $7, $6      # ans = ans & ~(1 << pix)

            sub     $6, $7, $1      # ans - 1
            and     $6, $6, $7      # ans & (ans - 1)
            beq     $0, $6, Prep    # break if it's zero

    Loop:   addi    $2, $2, 1       # i + 1
            j Trav  

    Prep:   addi    $2, $0, -1      # TopColor = -1

    Log2:   sra     $7, $7, 1       # ans >> 1
            addi    $2, $2, 1       # TopColor++
            bne     $7, $0, Log2    # do while(ans != 0) 

            
            swi 546         # submit answer and check
            jr  $31         # return to caller
