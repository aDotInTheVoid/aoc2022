program main
   ! use day03, only: say_hello
   use, intrinsic :: iso_fortran_env, only: input_unit, output_unit
   use stdlib_io, only: getline
   use day03, only: q1_score
   implicit none

   character(len=:), allocatable :: line
   integer :: stat
   integer :: input_len
   integer(kind=8) :: sum

   sum = 0

   open(unit=1, file="input.txt")

   do
      call getline(1, line, stat)
      if (stat /= 0) then
         exit
      end if
      input_len = LEN(line)
      sum = sum + q1_score(line, input_len)

   end do

   close(unit=1)

   write (*, *) sum

end program main
