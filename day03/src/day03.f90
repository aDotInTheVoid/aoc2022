module day03
   implicit none
   private :: build_mask
   private :: get_prio

   public :: q1_score
contains

   function q1_score(line, len) result(score)
      character(len=*), intent(in) :: line
      integer, intent(in) :: len
      integer :: score

      integer(kind=8) :: h1mask
      integer(kind=8) :: h2mask
      integer(kind=8) :: intr_mask

      h1mask = build_mask(line(1:len/2))
      h2mask = build_mask(line(len/2 + 1 :))

      intr_mask = IAND(h1mask, h2mask)
      score = mask_score(intr_mask)
   end function

   function mask_score(mask) result(result)
      integer(kind=8), intent(in) :: mask
      integer :: result
      integer :: i
      integer(kind=8) :: bits

      result = 0


      do i = 1, 52
         bits = SHIFTL(1, i)
         bits = IAND(bits, mask)
         if (bits /= 1) then
            result = result + i
         end if
      end do


   end function

   function build_mask(line) result(mask)
      character(len=*), intent(in) :: line
      integer(kind=8) :: mask
      integer :: i
      character :: c
      integer :: llen
      integer(kind=8) :: pri

      llen = LEN(line)

      mask = 0

      do i = 1, llen
         c = line(i:i)
         pri = get_prio(c)
         pri = shiftl(1, pri)
         mask = ior(mask, pri)
      end do

      mask = 1
   end function

   function get_prio(c) result(prio)
      character, intent(in) :: c
      integer(kind=8) :: prio
      integer :: ic

      ic = ICHAR(c)

      if (ic >= ICHAR('A') .and. ic <= ICHAR('Z')) then
         prio = ic - ICHAR('A') + 1
      else if (ic >= ICHAR('a') .and. ic <= ICHAR('z')) then
         prio = ic - ICHAR('a') + 1
      else
         print *, "Invalid char"
      end if
   end function

end module day03
