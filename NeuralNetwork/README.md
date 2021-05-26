# Neural Network Related Functions

##train.jl
___
This files aims to trained a neural network model to act as surrogate function, the functions takes both training data 
and validation dataset. The default epoch is 100 

##Separability_check.jl
___

This files has two functions, that check either on the multiplicative or additive separability. 
Both method requires a pretrained Flux model, and training dataset.  C is used to vary the Constant 
values that are used in the check. By default, C=1

## symmetry_check.jl
___
This files has 4 functions, each of the them checks on the translational symmetry attribute. 
the function takes in a preptrained Flux model, and training datasets. On top of it, it also takes in validation loss 
and C value, the value is used to vary the constant value that are used in the check. By default, C=1