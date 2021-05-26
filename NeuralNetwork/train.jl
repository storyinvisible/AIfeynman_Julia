using MLDataUtils
using CSV
using DataFrames
using Flux
using Flux: @epochs
using Flux: Data.DataLoader
using Plots
using CUDA
using Statistics

function train_model(xvalue, yvalue,x_val,y_val,epochs=100)
    N_variables =length(xvalue[:,1])
    model_internal= Chain(Dense(N_variables,128),
            Dense(128,64,tanh),
            Dense(64,32,tanh),
            Dense(32,32,tanh),
            Dense(32,1))|>gpu
    yvalue=deepcopy(yvalue)
    xvalue=deepcopy(xvalue)
    train_dataloader = DataLoader(xvalue, yvalue, batchsize=100)
    ps3= Flux.params(model_internal)
    pred=model_internal(xvalue[:,1:100])
    final_val_loss=100
#     print(pred)

#     act_y=yvalue[:,1:100]
#     println(Flux.mse(pred, act_y))
#     print(size(pred))
#     print(size( act_y))
    opt= ADAM(0.001)
    loss(x,y) = Flux.mse(model_internal(x),y)
    for i in 1:epochs
        total_loss=0
        steps=1
        for batch in train_dataloader

            gradient = Flux.gradient(ps3) do
              # Remember that inside the loss() is the model
              # `...` syntax is for unpacking data
              training_loss = loss(batch...)
              total_loss= total_loss+loss(batch...)
              return training_loss
            end
            steps=steps+1
            Flux.update!(opt, ps3, gradient)

        end
        pred=model_internal(x_val)
        print("Epochs  :")
        print(i)
        print("  Validation loss :")
        print(Flux.mse(pred,y_val))
        final_loss =total_loss/steps
        print("  Training loss :")
        println(final_loss)
        final_val_loss= Flux.mse(pred,y_val)

    end
    return model_internal, final_val_loss
end
