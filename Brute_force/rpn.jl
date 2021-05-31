function polish_to_infix(polish_notation)
    infix=[]
    variables = ['0','1','a','b','c','d','e','f','g','h','i','j','k','l','m','n','P']
    operations_1 = ['>','<','~','\\','L','E','S','C','A','N','T','R','O','J']
    operations_2 = ['+','*','-','/']
    rpn = collect(polish_notation)
    print(rpn)
    n= length(polish_notation)
    for i in rpn
        println(i)
        if i in variables
            if i=='P'
                append!(infix,"pi")
            elseif i=='0'
                append!(infix,'0')
            elseif i=='1'
                append!(infix,'1')
            else
                str="x"*string(Int(Char(i))-97)

                push!(infix,str)

            end
        end
        if i in operations_2
            a1=infix[end]
            a2=infix[end-1]
            infix=infix[1:end-2]
            a="("*a1*i*a2*")"
            push!(infix,a)
        end
        if i in operations_1
            a1=infix[end]
            infix=infix[1:end-1]
            if i==">"
                a="("*a*"*1)"
                infix = push!(infix,a)
            elseif i=="<"
                a="("*a*"-1)"
                infix = push!(infix,a)
            elseif i=="~"
                a="(-"*a*")"
                infix = push!(infix,a)
            elseif i=="\\"
                a="("*a*")**(-1)"
                infix = push!(infix,a)
            elseif i=="L"
                a="log("*a*")"
                infix = push!(infix,a)
            elseif i=="E"
                a="exp("*a*")"
                infix = push!(infix,a)
            elseif i=="S"
                a="sin("*a*")"
                infix = push!(infix,a)
            elseif i=="C"
                a="cos("*a*")"
                infix = push!(infix,a)
            elseif i=="A"
                a="abs("*a*")"
                infix = push!(infix,a)
            elseif i=="N"
                a="asin("*a*")"
                infix = push!(infix,a)
            elseif i=="T"
                a="atan("*a*")"
                infix = push!(infix,a)
            elseif i=="R"
                a="sqrt("*a*")"
                infix = push!(infix,a)
            elseif i=="O"
                a="(2*("*a*"))"
                infix = push!(infix,a)
            elseif i=="J"
                a="(2*("*a*")*1)"
                infix = push!(infix,a)
            end
        end
    end

    return infix[end]
end
