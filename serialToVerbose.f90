program serialToVerbose

    !   Unfinished as of 7/28/22
    !   by Chance
    !   Converts lists of guass coefficients written in a serial format to a verbose format
    !   in which hl0 is explicitly stated to be zero and coeffs are formatted as:
    !       l   m   glm     hlm
    !
    !   Can read inputs in the form of CALS3k, SED3k, ARCH3k

    integer :: l, m, tStart, tEnd, lmax, nmax, npsl
    real*8 :: g, h
    character*30 :: modname

    print *, 'Enter model filename:'
    read (*, *) modfile

    open (7, file=modfile)

    READ (7,*) tStart , tEnd
    READ (7,*) lmax , nmax , nspl , (tknts(i),i=1,nspl+4)
    READ (7,*) gs
    
    CLOSE (7)