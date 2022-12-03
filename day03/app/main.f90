program main
   ! use day03, only: say_hello
   use, intrinsic :: iso_fortran_env, only: input_unit, output_unit
   use stdlib_io, only: getline
   implicit none

   character(len=:), allocatable :: line
   integer :: stat
   integer :: input_len

   open(unit=1, file="input.txt")

   do
      call getline(1, line, stat)
      if (stat /= 0) then
         exit
      end if
      input_len = LEN(line)
      write(*,*) line
      write(*,*) input_len
   end do

   close(unit=1)

end program main
