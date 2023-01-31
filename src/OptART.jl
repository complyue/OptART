module OptART


include("OptART/Lexicon.jl")


export Namespace, lookup, assign
include("OptART/MXS.jl")
using .MXS


end # module OptART
