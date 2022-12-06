@.inputtxt = private constant [10 x i8] c"input.txt\00"
@.r = private constant [2 x i8] c"r\00"
@.printf_arr4 = private unnamed_addr constant [15 x i8] c"[%c %c %c %c]\0A\00", align 1
@.printf_q1 = private unnamed_addr constant [8 x i8] c"Q1: %d\0A\00", align 1


declare ptr @fopen(ptr, ptr)
declare i32 @fgetc(ptr)
declare i32 @printf(ptr, ...)


define i1 @add_vals(ptr  %v0, i32 %v4val) {
    %v1 = getelementptr inbounds i32, ptr %v0, i64 1
    %v2 = getelementptr inbounds i32, ptr %v0, i64 2
    %v3 = getelementptr inbounds i32, ptr %v0, i64 3

    %v1val = load i32, ptr %v1
    store i32 %v1val, ptr %v0

    %v2val = load i32, ptr %v2
    store i32 %v2val, ptr %v1

    %v3val = load i32, ptr %v3
    store i32 %v3val, ptr %v2

    store i32 %v4val, ptr %v3

    %v1eqv2 = icmp eq i32 %v1val, %v2val
    %v1eqv3 = icmp eq i32 %v1val, %v3val
    %v1eqv4 = icmp eq i32 %v1val, %v4val
    %v2eqv3 = icmp eq i32 %v2val, %v3val
    %v2eqv4 = icmp eq i32 %v2val, %v4val
    %v3eqv4 = icmp eq i32 %v3val, %v4val

    %o2 = or i1 %v1eqv2, %v1eqv3
    %o3 = or i1 %o2, %v1eqv4
    %o4 = or i1 %o3, %v2eqv3
    %o5 = or i1 %o4, %v2eqv4
    %o6 = or i1 %o5, %v3eqv4
    
    ret i1 %o6
}

define dso_local void @print_arr(ptr %0) {
  %2 = load i32, ptr %0
  %3 = getelementptr inbounds i32, ptr %0, i64 1
  %4 = load i32, ptr %3
  %5 = getelementptr inbounds i32, ptr %0, i64 2
  %6 = load i32, ptr %5
  %7 = getelementptr inbounds i32, ptr %0, i64 3
  %8 = load i32, ptr %7
  %9 = tail call i32 (ptr, ...) @printf(ptr @.printf_arr4, i32 %2, i32 %4, i32 %6, i32 %8)
  ret void
}

define i32 @main() {
    %vals = alloca [4 x i32]

    %f = call ptr @fopen(ptr @.inputtxt, ptr @.r)
    %f_isnull = icmp eq ptr %f, null

    %v0p = getelementptr inbounds i32, ptr %vals, i64 0
    %v1p = getelementptr inbounds i32, ptr %vals, i64 1
    %v2p = getelementptr inbounds i32, ptr %vals, i64 2
    %v3p = getelementptr inbounds i32, ptr %vals, i64 3

    br i1 %f_isnull, label %error, label %ok1
ok1:    
    %v1init = call i32 @fgetc(ptr %f)
    %v2init = call i32 @fgetc(ptr %f)
    %v3init = call i32 @fgetc(ptr %f)

    store i32 %v1init, ptr %v1p
    store i32 %v2init, ptr %v2p
    store i32 %v3init, ptr %v3p

    br label %loop_head

loop_head:
    %n = phi i32 [4, %ok1], [%n_plus_1, %ok2] 

    %newchar = call i32 @fgetc(ptr %f)
    %newchar_isEOF = icmp eq i32 %newchar, -1

    %n_plus_1 = add i32 %n, 1

    br i1 %newchar_isEOF, label %error, label %ok2
ok2:
    %same = call i1 @add_vals(ptr %vals, i32 %newchar)


    br i1 %same, label %loop_head, label %found

found:
    call void @print_arr(ptr %vals)
    call void @printf(ptr @.printf_q1, i32 %n)
    
    ret i32 0

error:
    ret i32 1
}