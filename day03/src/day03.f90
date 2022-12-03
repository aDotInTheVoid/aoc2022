module day03
   implicit none
   private :: build_mask

   public :: q1_score
contains

   function q1_score(line, len) result(score)
      character(len=*), intent(in) :: line
      integer, intent(in) :: len
      integer :: score

      integer(kind=8) :: h1mask
      integer(kind=8) :: h2mask

      h1mask = build_mask(line(1:len/2))
      h2mask = build_mask(line(len/2 + 1 :))

      score = len
   end function

   function build_mask(line) result(mask)
      character(len=*), intent(in) :: line
      integer(kind=8) :: mask
      integer :: i
      character :: c
      integer :: llen

      llen = LEN(line)
      ! write(*,*) line

      do i = 1, llen
         c = line(i:i)
         !    write(*,*) c
         write(*,*) c
      end do

      write(*,*) "Done mask"

      mask = 1
   end function

end module day03
