#     T o p  o f  P i l e
#
#
# This routine finds the color of the part on top of a pile.
#
# Name: Johnathan Radcliff
# Date: 10/30/19

.data
Pile:  .alloc   1024
ans:   .word    16843008, 16843009

.text

TopColor:   addi    $1, $0, Pile       # point to array base
            swi 545                              # generate pile
                # your code goes here
            addi    $2, $1, 128     # i = 64, where i is the iteration bit
            addi    $1, $0, 6       # 6    

    Trav:   lb      $3, 0($2)       # pix = Pile [i]
            beq     $3, $0, Loop    # if pix = 0, branch

            # Check the bottom and right
            lb      $4, 64($2)      # b_pix = Pile[i + 64]
            beq     $4, $0, Loop    # if b_pix == 0, restart
            lb      $5, 1($2)       # r_pix = Pile[i + 1]
            beq     $5, $0, Loop    # if r_pix == 0, restart

            beq     $4, $5, Loop    # if they're equal, restart
            lb      $6, -64($2)     # if b_pix is equal, set opp_pix to t_pix
            beq     $3, $5, func    # if b_pix == pix, move to the next step
            lb      $6, -1($2)      # if r_pix is equal, set opp_pix to l_pix
            bne     $3, $4, Loop    # if r_pix == pix, move to the next step

            add     $4, $0, $5      # the b_pix data on the chopping block

    func:   beq     $6, $0, Loop    # if that pixel equals zero, restart

            lb      $6, ans($4)     # grab the value at the point pix
            beq     $6, $0, Loop    # Loop if zero

            sb      $0, ans($4)     # remove from ans

            addi    $1, $1, -1      # count - 1
            beq     $0, $1, Prep    # break if it's zero

    Loop:   addi    $2, $2, 1       # i + 1
            j Trav  

    Prep:   addi    $2, $0, -1      # TopColor = -1

    Log2:   addi    $2, $2, 1
            lb      $6, ans($2)
            beq     $6, $0, Log2    # do while(ans != 0) 

            
            swi 546         # submit answer and check
            jr  $31         # return to caller
