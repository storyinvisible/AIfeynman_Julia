function brute_force(pathdir, filename,BF_try_time, BF_ops_file_type, sep_type="*", sigma="10.000", band="0.0000")
#     filename: the data files that in includes the variable x, and answer y

    try
        rm("results.dat")
    catch e
        end

    try
        rm("brute_solutions.dat")
    catch e
        end
    try
        rm("brute_constant.dat")
    catch e
        end
    try e
        rm("brute_formulas.dat")
    catch e
        end

    cp("$pathdir$filename", "mystery.dat",force=true)

    data = " '$BF_ops_file_type' 'arity2templates.txt' mystery.dat results.dat $sigma $band"
    open("args.dat", "w") do io
           write(io, data)
       end
    if sep_type == "*"
        # run(`feynman_sr_mdl_mult`)
         run_with_timeout(`feynman_sr_mdl_mult`, BF_try_time)
    elseif sep_type=="+"
        print("Brute Force for plus")
        run_with_timeout(`feynman_sr_mdl_plus`, BF_try_time)
    end

end
function run_with_timeout(command, timeout::Integer = 5)
           cmd = run(command; wait=false)
            for i in 1:timeout
                if !process_running(cmd) return success(cmd) end
                sleep(1)
            end
            kill(cmd)
            return false
       end
function polish_to_infix(polish_notation)
    infix=[]
    rpn = collect(polish_notation)
    n= length(polish_notation)
    for i in n:-1:1

    end
end
