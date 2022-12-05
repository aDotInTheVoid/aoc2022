module day03
   implicit none
contains
   function mask_score(mask) result(result)
      integer(kind=8), intent(in) :: mask
      integer(kind=8) :: result
      integer(kind=8) :: i
      result = 0
      do i = 1, 52
         if (IAND(2**i, mask) /= 0) then
            result = result + i
         end if
      end do
   end function

   function build_mask(line) result(mask)
      character(len=*), intent(in) :: line
      integer(kind=8) :: mask
      integer :: i

      mask = 0
      do i = 1, LEN(line)
         mask = IOR(mask, 2 ** get_prio(line(i:i)))
      end do
   end function

   function get_prio(c) result(prio)
      character, intent(in) :: c
      integer(kind=8) :: prio
      integer :: ic

      ic = ICHAR(c)

      if (ic >= ICHAR('A') .and. ic <= ICHAR('Z')) then
         prio = ic - ICHAR('A') + 27
      else if (ic >= ICHAR('a') .and. ic <= ICHAR('z')) then
         prio = ic - ICHAR('a') + 1
      else
         call abort()
      end if
   end function
end module day03
