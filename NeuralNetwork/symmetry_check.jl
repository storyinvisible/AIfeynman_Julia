include("utility.jl")
function check_translational_symmetry_minus(model, input_x, ground_truth_y, val_error,c=1)
    model= model|>cpu
    input_x=input_x|>cpu
    ground_truth_y=ground_truth_y|>cpu
    N_variables =length(input_x[:,1])
    len= length(input_x[1,:])
    variables=Array((1:N_variables))

    if N_variables==1

        return (-1,-1,-1)
    end
    min_error = 1000
    best_i = -1
    best_j = -1
    best_mu = 0
    best_sigma = 0
    for i in 1:N_variables
        for j in 1:N_variables
            if i>j || i==j
                  continue

            end
            factor_translate=deepcopy(input_x)
            a= min(std(factor_translate[:,j]), std(factor_translate[:,i]))
            print(a)
            factor_translate[:,i]= factor_translate[:,i] .+a
            factor_translate[:,j]= factor_translate[:,j] .+a
            error= Flux.mse(model(factor_translate), ground_truth_y)
            sm=model(factor_translate)
            # list_errors= broadcast(abs, ground_truth_y.- model(transpose(factor_translate)) )
            # error= median(list_errors)
            print("i: ")
            print(i)
            print(" j :")
            print(j)
            print(" Error :")
            println(error)
            print("  Median Error ")
            errors= broadcast(abs,ground_truth_y-sm)
            median_error= median(errors)
            println(median_error)
            if min_error >error
                min_error=error
                best_i=i
                best_j=j
            end
        end
    end
    return min_error,best_i,best_j
    # if min_error*10 <val_error
    #     return true
    # else
    #     return false
    #     end


end
function check_translational_symmetry_divide(model, input_x, ground_truth_y, val_error)
    model= model|>cpu
    input_x=input_x|>cpu
    ground_truth_y=ground_truth_y|>cpu
    N_variables =length(input_x[:,1])
    len= length(input_x[1,:])
    variables=Array((1:N_variables))

    if N_variables==1

        return (-1,-1,-1)
    end
    min_error = 1000
    best_i = -1
    best_j = -1
    best_mu = 0
    best_sigma = 0
    for i in 1:N_variables
        for j in 1:N_variables
            if i>j || i==j
                  continue
            end
            factor_translate=deepcopy(input_x)
            # a= min(std(factor_translate[:,j]), std(factor_translate[:,i]))*10
            a=10
            factor_translate[:,i]= factor_translate[:,i] .*a
            factor_translate[:,j]= factor_translate[:,j] .*a
            error= Flux.mse(model(factor_translate), ground_truth_y)
            sm=model(factor_translate)
            # list_errors= broadcast(abs, ground_truth_y.- model(transpose(factor_translate)) )
            # error= median(list_errors)
            print("i: ")
            print(i)
            print(" j :")
            print(j)
            print(" Error :")
            println(error)
            print("  Median Error ")
            errors= broadcast(abs,ground_truth_y-sm)
            median_error= median(errors)
            println(median_error)
            if min_error >error
                min_error=error
                best_i=i
                best_j=j
            end
        end
    end
    return min_error,best_i,best_j

end

function check_translational_symmetry_multiply(model, input_x, ground_truth_y, val_error)
    model= model|>cpu
    input_x=input_x|>cpu
    ground_truth_y=ground_truth_y|>cpu
    N_variables =length(input_x[:,1])
    len= length(input_x[1,:])
    variables=Array((1:N_variables))

    if N_variables==1

        return (-1,-1,-1)
    end
    min_error = 1000
    best_i = -1
    best_j = -1
    best_mu = 0
    best_sigma = 0
    for i in 1:N_variables
        for j in 1:N_variables
            if i>j || i==j
                  continue
            end
            factor_translate=deepcopy(input_x)
            # a= min(std(factor_translate[:,j]), std(factor_translate[:,i]))*10
            a=10
            factor_translate[:,i]= factor_translate[:,i] ./a
            factor_translate[:,j]= factor_translate[:,j] ./a
            sm=model(factor_translate)
            error= Flux.mse(model(factor_translate), ground_truth_y)
            # list_errors= broadcast(abs, ground_truth_y.- model(transpose(factor_translate)) )
            # error= median(list_errors)
            print("i: ")
            print(i)
            print(" j :")
            print(j)
            print(" Error :")
            print(error)
            print("  Median Error ")
            errors= broadcast(abs,ground_truth_y-sm)
            median_error= median(errors)
            println(median_error)
            if min_error >error
                min_error=error
                best_i=i
                best_j=j
            end
        end
    end
    return min_error,best_i,best_j

end


function check_translational_symmetry_plus(model, input_x, ground_truth_y, val_error)
    model= model|>cpu
    input_x=input_x|>cpu
    ground_truth_y=ground_truth_y|>cpu
    N_variables =length(input_x[:,1])
    len= length(input_x[1,:])
    variables=Array((1:N_variables))

    if N_variables==1

        return (-1,-1,-1)
    end
    min_error = 1000
    best_i = -1
    best_j = -1
    best_mu = 0
    best_sigma = 0
    for i in 1:N_variables
        for j in 1:N_variables
            if i>j || i==j
                  continue
            end
            factor_translate=deepcopy(input_x)
            # a= min(std(factor_translate[:,j]), std(factor_translate[:,i]))*10
            a=10
            factor_translate[:,i]= factor_translate[:,i] .-a
            factor_translate[:,j]= factor_translate[:,j] .-a
            error= Flux.mse(model(factor_translate), ground_truth_y)
            sm=model(factor_translate)
            # list_errors= broadcast(abs, ground_truth_y.- model(transpose(factor_translate)) )
            # error= median(list_errors)
            print("i: ")
            print(i)
            print(" j :")
            print(j)
            print(" Error :")
            println(error)
            print("  Median Error ")
            errors= broadcast(abs,ground_truth_y-sm)
            median_error= median(errors)
            println(median_error)
            if min_error >error
                min_error=error
                best_i=i
                best_j=j
            end
        end
    end
    return min_error,best_i,best_j

end
