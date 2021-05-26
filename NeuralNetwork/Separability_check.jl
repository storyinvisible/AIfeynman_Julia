include("../Utils/utility.jl")
using Flux

function check_additive(model, input_x, ground_truth_y,c=1.0)
    model= model|>cpu
    input_x=input_x|>cpu
    ground_truth_y=ground_truth_y|>cpu
    N_variables =length(input_x[:,1])
    len= length(input_x[1,:])
    variables=Array((1:N_variables))
    combinations= combination(variables)
    factor_vary=zeros((N_variables,len))
    min_error=1000000
    separate_1=nothing
    separate_2=nothing
    for i in 1:N_variables
        factor_median= median(input_x[i,:])
        factor_row= zeros((len,1))
        fill!(factor_row,factor_median)
        factor_vary[i,:]=factor_row
    end
    for combines in combinations

        combines2 = notin(combines, variables)

        factor_vary_one=deepcopy(input_x)# x1,
        factor_vary_two=deepcopy(input_x)#x2,
        for i in combines
            factor_median= median(input_x[i,:])
            factor_row= zeros((len,1))
            fill!(factor_row,factor_median*c)
            factor_vary_one[i,:]=factor_row
        end
        for i in combines2
            factor_median= median(input_x[i,:])
            factor_row= zeros((len,1))
            fill!(factor_row,factor_median*c)
            factor_vary_two[i,:]=factor_row
        end
        sm = model(factor_vary_one) .+ model(factor_vary_two) .- model(factor_vary)
        error= Flux.mse(ground_truth_y,sm)
        print("Combinations :")
        print(combines)
        print("  Error :")
        print(error)
        print("  Median Error ")
        errors= broadcast(abs,ground_truth_y.-sm)
        median_error= median(errors)
        println(median_error)
        if error <min_error
            min_error=error
            separate_1=combines
            separate_2=combines2
        end

    end
    return separate_1,separate_2,min_error

end
function check_multiplicative(model, input_x, ground_truth_y,c=1.0)
    model= model|>cpu
    input_x=input_x|>cpu
    ground_truth_y=ground_truth_y|>cpu
    N_variables =length(input_x[:,1])
    len= length(input_x[1,:])
    variables=Array((1:N_variables))
    combinations= combination(variables)
    factor_vary=zeros((N_variables,len))
    min_error=100000
    separate_1=nothing
    separate_2=nothing
    for i in 1:N_variables
        factor_median= median(input_x[i,:])
        factor_row= zeros((1,len))
        fill!(factor_row,factor_median*c)
        factor_vary[i,:]=factor_row
    end
    factor_vary=factor_vary
    for combines in combinations
        combines2 = notin(combines, variables)
        factor_vary_one=deepcopy(input_x)# x1,
        factor_vary_two=deepcopy(input_x)#x2,
        for i in combines
            factor_median= median(input_x[i,:])
            factor_row= zeros((1,len))
            fill!(factor_row,factor_median*c)
            factor_vary_one[i,:]=factor_row
        end
        for i in combines2
            factor_median= median(input_x[i,:])
            factor_row= zeros((1,len))
            fill!(factor_row,factor_median*c)
            factor_vary_two[i,:]=factor_row
        end
        pd = model(factor_vary_one) .* model(factor_vary_two)
        pd1= model(factor_vary)
        pd2=pd ./pd1
        error= Flux.mse(ground_truth_y ,pd2)
        print("Combinations :")
        print(combines)
        print("  Error :")
        print(error)
        print("  Median Error ")
        errors= broadcast(abs,ground_truth_y.-pd2)
        median_error= median(errors)
        println(median_error)
        if error <min_error
            min_error=median_error
            separate_1=combines
            separate_2=combines2
        end

    end
    return separate_1,separate_2,min_error

end
