program main
   ! use day03, only: say_hello
   use, intrinsic :: iso_fortran_env, only: input_unit, output_unit
   use stdlib_io, only: getline
   use day03, only: q1_score, build_mask, mask_score
   implicit none

   character(len=:), allocatable :: line
   integer :: stat
   integer :: input_len
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
      input_len = LEN(line)
      q1_sum = q1_sum + q1_score(line, input_len)
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
      write(*,*) "mask1: ", mask1, " mask2: ", mask2, " mask3: ", mask3, "q2_sum: ", q2_sum
   end do
   close(unit=2)

   write (*, *) "Q1: ", q1_sum
   write (*, *) "Q2: ", q2_sum

end program main
