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
    write(*,*)"�������뺯�����Ա���:"
    ! read(*,'(a)') s
    s = 'x y z'
    allocate(varvals(f_numbervars(s))) ! f_numbervars(s)Ϊ�Ա����ĸ���
    
    write(*,*) "��������Ա����ĺ���:"
    ! read(*,'(a)') f
    f = 'x+y+z'
    write(*,*) "���������Ӧ�Ա�����ֵ:"
    ! read(*,*) varvals
    varvals = 1
    
    ! ��������
    call s_createfn(f, s, funcnum,error1) 
    ! ��ʾ������Ϣ
    write(*,'(a)')trim(error1)
    ! ���㺯��ֵ
    call s_evaluatefn(funcnum, varvals, r,error2) 
    ! ��ʾ������Ϣ
    write(*,'(a)')trim(error2) 
    write(*,*)"����ֵ����:",r
    ! ���ٺ���
    call s_destroyfn(funcnum) 
    
    stop    
    !---------------------------------------------------------------------------
    end program main