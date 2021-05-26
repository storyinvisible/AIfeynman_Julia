function combination(input)
    len= length(input)
    combinations=[]
    for i in 1:len-1
        all_combines=permutation(input, i)
        for j in all_combines
            append!(combinations, [j])
        end
    end
    return combinations
end

function permutation(input, len)

    j=1
    combination=[]

    if len==1
        for i in input
            append!(combination, [[i]])
        end
        return combination
    end
    if len==length(input)

        return [input]
    end

    while j<=(length(input)-len+1)
#         print("j ")
#         println(j)
        i=1
#         if len==1
#             for i in input
#                 append!(combination, [i])
#             end
#             return combination

#         else

            combins=permutation(input[(j+1):end], len-1)
#             if len==3
#                 println(combins)
#                 end
# #             println(combins)
            for arr in combins
                new_combine =vcat([input[j]],arr)
                append!(combination,[new_combine])
            end
#             if len==3
#                 println(combination)
#                 end
#         println(len)
#         print("combinations ")
#         println(combination)


        j=j+1
        end
    return combination
    end
    function notin(comb, complete)
    set2=[]
    for i in 1:length(complete)
        if complete[i] ∉ comb
            append!(set2, complete[i])
        end
    end
    return set2
end
function batchmodel(model, inputs)
    output=[]
    len= size(inputs)[2]
    for i in 1:len
        pred= model(inputs[:,i])
        append!(output, pred)
    end
    return transpose(output)

end
function plot_model(model, x_val, y_val)
    y_pred=model(x_val)
    p=sortperm(y_val[1,:])
    y_val=y_val[1,p]
    y_pred=y_pred[1,p]
    plot(y_val,label="actual")
    plot!(y_pred, label="pred")
    ylabel!("Values")
    xlabel!("Data Points")
end
