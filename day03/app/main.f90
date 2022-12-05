program main
   use stdlib_io, only: getline
   use day03, only: build_mask, mask_score
   implicit none

   character(len=:), allocatable :: line
   integer :: stat
   integer(kind=8) :: q1_sum, q2_sum
   integer(kind=8) :: mask1, mask2, mask3

   q1_sum = 0
   q2_sum = 0

   open(unit=1, file="input.txt")
   do
      call getline(1, line, stat)
      if (stat /= 0) then
         exit
      end if
      q1_sum = q1_sum + q1_score(line)
   end do
   close(unit=1)

   open(unit=2, file="input.txt")
   do
      call getline(2, line, stat)
      if (stat /= 0) then
         exit
      end if
      mask1 = build_mask(line)
      call getline(2, line, stat)
      mask2 = build_mask(line)
      call getline(2, line, stat)
      mask3 = build_mask(line)

      q2_sum = q2_sum + mask_score(IAND(mask1, IAND(mask2, mask3)))
   end do
   close(unit=2)

   write (*, *) "Q1: ", q1_sum
   write (*, *) "Q2: ", q2_sum

contains
   function q1_score(l) result(score)
      character(len=*), intent(in) :: l
      integer(kind=8) :: score
      integer :: ln

      integer(kind=8) :: h1mask
      integer(kind=8) :: h2mask
      integer(kind=8) :: intr_mask

      ln = LEN(l)

      h1mask = build_mask(l(1:ln/2))
      h2mask = build_mask(l(ln/2 + 1 :))
      intr_mask = IAND(h1mask, h2mask)
      score = mask_score(intr_mask)
   end function

end program main
