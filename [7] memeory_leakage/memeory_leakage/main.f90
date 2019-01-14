    module grist_domain_types
    implicit none
    public :: aaa

    type bbb
        real (8), allocatable :: c(:)
    end type bbb

    type aaa
        type(bbb), allocatable :: b(:)
    end type aaa

    end module grist_domain_types

    program main
    use grist_domain_types
    type(aaa) :: a
    integer(4) :: time,i
    integer(4) :: vdim
    
    time=20
    vdim = 10000000
    
    allocate(a%b(1:vdim))
    call sleep(time)!--------------1

    do i=1,vdim
        allocate(a%b(i)%c(1:1))
    enddo
    call sleep(time)!--------------2

    do i=1,vdim
        deallocate(a%b(i)%c)
    enddo
    call sleep(time)!--------------3

    deallocate(a%b)
    call sleep(time+20)!--------------4
    
    
    end program