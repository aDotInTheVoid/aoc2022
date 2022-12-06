@.inputtxt = private constant [10 x i8] c"input.txt\00"
@.r = private constant [2 x i8] c"r\00"
@.printf_solved = private unnamed_addr constant [9 x i8] c"Q%d: %d\0A\00", align 1

declare ptr @fopen(ptr, ptr)
declare i32 @fgetc(ptr)
declare i32 @printf(ptr, ...)
declare i32 @fclose(ptr)
declare i32 @putchar(i32)
declare void @abort()

define void @print_arr(ptr %0, i32 %1) {
  %3 = call i32 @putchar(i32 91)
  %4 = icmp sgt i32 %1, 0
  br i1 %4, label %5, label %7

5:                                                ; preds = %2
  %6 = zext i32 %1 to i64
  br label %9

7:                                                ; preds = %9, %2
  %8 = tail call i32 @putchar(i32 93)
  %all_dir = call i1 @all_different(ptr %0, i32 %1)

  br i1 %all_dir, label %diff, label %no_diff
  diff:
    %d1 = call i32 @putchar(i32 42)
    br label %no_diff

  no_diff:
  %d2 = call i32 @putchar(i32 10)
  ret void

9:                                                ; preds = %5, %9
  %10 = phi i64 [ 0, %5 ], [ %14, %9 ]
  %11 = getelementptr inbounds i32, ptr %0, i64 %10
  %12 = load i32, ptr %11, align 4
  %13 = tail call i32 @putchar(i32 %12)
  %14 = add nuw nsw i64 %10, 1
  %15 = icmp eq i64 %14, %6
  br i1 %15, label %7, label %9
}

define i1 @all_different(ptr %chars, i32 %len) {
    ; for (int i = 0; i < len; i++)
    ;   for (int j = i+1; j < len; j++)
    ;      if (chars[i] == chars[j])
    ;         return false;
    ; return true;
    entry:
    br label %l1_head

    l1_head:
    %i = phi i32 [0, %entry], [%i_next, %l1_body]
    %i_next = add i32 %i, 1
    %i_lt_len = icmp slt i32 %i, %len
    br i1 %i_lt_len, label %l1_body, label %l1_end
    l1_body:

    %j = phi i32 [%i_next, %l1_head], [%j_next, %l2_body]
    %j_next = add i32 %j, 1
    %j_lt_len = icmp slt i32 %j, %len
    br i1 %j_lt_len, label %l2_body, label %l1_head

    l2_body:
    %chars_ip = getelementptr i32, ptr %chars, i32 %i
    %chars_i = load i32, ptr %chars_ip
    %chars_jp = getelementptr i32, ptr %chars, i32 %j
    %chars_j = load i32, ptr %chars_jp
    %chars_i_eq_chars_j = icmp eq i32 %chars_i, %chars_j
    br i1 %chars_i_eq_chars_j, label %l1_end_found, label %l1_body


l1_end:
    ret i1 1
l1_end_found:
    ret i1 0
}

define void @add_new(ptr %vals, i32 %len, i32 %new) {
    ; for (int i=1;i<len;i++)
    ;    vals[i-1] = vals[i];

    entry:
    br label %l1_head

    l1_head:
    %i = phi i32 [1, %entry], [%i_next, %l1_body]
    %i_next = add i32 %i, 1
    %i_prev = sub i32 %i, 1
    %i_lt_len = icmp slt i32 %i, %len
    br i1 %i_lt_len, label %l1_body, label %l1_end

    l1_body:
    %vals_ip = getelementptr i32, ptr %vals, i32 %i
    %vals_i = load i32, ptr %vals_ip
    %vals_im1p = getelementptr i32, ptr %vals, i32 %i_prev

   ; call void @print_arr(ptr %vals, i32 %len)
    store i32 %vals_i, ptr %vals_im1p
    ;call void @print_arr(ptr %vals, i32 %len)

    br label %l1_head

    l1_end:

    ; vals[len-1] = new;

    %len_m1 = sub i32 %len, 1
    %vals_len_m1p = getelementptr i32, ptr %vals, i32 %len_m1
    ;call void @print_arr(ptr %vals, i32 %len)

    store i32 %new, ptr %vals_len_m1p

     ;   call void @print_arr(ptr %vals, i32 %len)

    ret void
}

define void @solve(i32 %qno, i32 %nsame) {
entry:
    %nsame64 = zext i32 %nsame to i64
    %nums = alloca i32, i64 %nsame64

    %f = call ptr @fopen(ptr @.inputtxt, ptr @.r)
    %f_isnull = icmp eq ptr %f, null
    br i1 %f_isnull, label %fail, label %r1_loop

    ; for (int i=1; i<n; i++)
r1_loop:
    %i = phi i32 [1, %entry], [%i_next, %r1_loop_body]
    %i_next = add i32 %i, 1

    %c = call i32 @fgetc(ptr %f)
    %c_iseof = icmp eq i32 %c, -1
    br i1 %c_iseof, label %fail, label %r1_loop_body

r1_loop_body:
    %nums_i = getelementptr i32, ptr %nums, i32 %i
    store i32 %c, ptr %nums_i
    %i_lt_n = icmp slt i32 %i_next, %nsame
    br i1 %i_lt_n, label %r1_loop, label %r1_loop_end
r1_loop_end:
    

    br label %r2_loop

r2_loop:
    %n = phi i32 [%nsame, %r1_loop_end], [%n_next, %r2_loop_body]
    %n_next = add i32 %n, 1
    %nc = call i32 @fgetc(ptr %f)
    %nc_iseof = icmp eq i32 %nc, -1
    br i1 %nc_iseof, label %fail, label %r2_loop_body

r2_loop_body:
    call void @add_new(ptr %nums, i32 %nsame, i32 %nc)
    call void @print_arr(ptr %nums, i32 %nsame)
    %all_diff = call i1 @all_different(ptr %nums, i32 %nsame)
    br i1 %all_diff, label %found, label %r2_loop


found:

    call void @printf(ptr @.printf_solved, i32 %qno, i32 %n)
    call i32 @fclose(ptr %f)
    ret void

fail:
    call void @abort()
    unreachable
}

define void @main() {
    call void @solve(i32 1, i32 4)
    call void @solve(i32 2, i32 14)
    ret void
}