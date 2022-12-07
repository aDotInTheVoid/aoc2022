@.inputtxt = private constant [10 x i8] c"input.txt\00"
@.r = private constant [2 x i8] c"r\00"
@.printf_solved = private constant [9 x i8] c"Q%d: %d\0A\00"

declare ptr @fopen(ptr, ptr)
declare i32 @fgetc(ptr)
declare i32 @printf(ptr, ...)
declare i32 @fclose(ptr)
declare i32 @putchar(i32)
declare void @abort()

define private i1 @all_different(ptr %chars, i32 %len) {
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

define private void @add_new(ptr %vals, i32 %len, i32 %new) {

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
    store i32 %vals_i, ptr %vals_im1p
    br label %l1_head

l1_end:
    %len_m1 = sub i32 %len, 1
    %vals_len_m1p = getelementptr i32, ptr %vals, i32 %len_m1
    store i32 %new, ptr %vals_len_m1p
    ret void
}

define private void @solve(i32 %qno, i32 %nsame) alwaysinline {

entry:
    %nsame64 = zext i32 %nsame to i64
    %nums = alloca i32, i64 %nsame64

    %f = call ptr @fopen(ptr @.inputtxt, ptr @.r)
    %f_isnull = icmp eq ptr %f, null
    br i1 %f_isnull, label %fail, label %r1_loop

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

define i32 @main() {
    call void @solve(i32 1, i32 4)
    call void @solve(i32 2, i32 14)
    ret i32 0
}