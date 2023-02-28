
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


include("./MXS/interp.jl")


end # module MXS 
