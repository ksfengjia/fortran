    program main
    use params
    use extrafunc
    use interpreter
    implicit none
    !---------------------------------------------------------------------------
    character(len=255) :: s, f,error1,error2
    real(fdp) ::  r
    real(fdp), dimension(:),allocatable :: varvals
    integer :: funcnum
    !---------------------------------------------------------------------------
    
    !---------------------------------------------------------------------------
    write(*,*)"依次输入函数的自变量:"
    ! read(*,'(a)') s
    s = 'x y z'
    allocate(varvals(f_numbervars(s))) ! f_numbervars(s)为自变量的个数
    
    write(*,*) "输入关于自变量的函数:"
    ! read(*,'(a)') f
    f = 'x+y+z'
    write(*,*) "依次输入对应自变量的值:"
    ! read(*,*) varvals
    varvals = 1
    
    ! 创建函数
    call s_createfn(f, s, funcnum,error1) 
    ! 提示出错信息
    write(*,'(a)')trim(error1)
    ! 计算函数值
    call s_evaluatefn(funcnum, varvals, r,error2) 
    ! 提示出错信息
    write(*,'(a)')trim(error2) 
    write(*,*)"函数值等于:",r
    ! 销毁函数
    call s_destroyfn(funcnum) 
    
    stop    
    !---------------------------------------------------------------------------
    end program main