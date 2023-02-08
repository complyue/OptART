
"""
Meta eXecution System

"""
module MXS


export UoMDef
include("./MXS/uom.jl")


export Namespace, defined, define
include("./MXS/ns.jl")


export Scope
include("./MXS/scope.jl")



function keyword_interpreter(kw::Symbol, interpreter::Function; context)

end


function assign_interp()

end


end # module MXS 
