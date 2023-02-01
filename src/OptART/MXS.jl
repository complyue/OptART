
"""
Meta eXecution System

"""
module MXS


export UoMDef

export Namespace, defined, define

export Scope


struct UoMDef
  id::Symbol # identifier
  conversions::Dict{UoMDef,Function}  # conversion rules
end


struct Namespace
  mutex::ReentrantLock
  assignables::Vector{Any}
  names::Vector{Symbol}
  dict::Dict{Symbol,Int}

  Namespace() = new(ReentrantLock(), Any[], Symbol[], Dict{Symbol,Int}())

  function Namespace(popu::Vector{Pair{Symbol,Any}})
    ns = new(
      ReentrantLock(),
      Any[v for (_, v) in popu],
      Symbol[n for (n, _) in popu],
      Dict(n => i for (i, (n, _)) in enumerate(popu))
    )
    @assert(
      length(ns.dict) == length(ns.names),
      "Duplicate names provided to Namespace ?!"
      # TODO accept it and compact the storage instead?
      # NOTE without compaction, dead values by former names will leak
    )
    return ns
  end

  function Namespace(popu::Dict{Symbol,Any})
    names = collect(Symbol, keys(popu))
    return new(
      ReentrantLock(), collect(values(popu)), names,
      Dict(n => i for (n, i) in zip(names, 1:length(popu)))
    )
  end

  Namespace(popu) = Namespace(collect(Pair{Symbol,Any}, popu))

end

# note: these are per default as of Julia 1.8, though we define it explicitly
Base.IteratorSize(::Type{Namespace}) = Base.HasLength()
Base.IteratorEltype(::Type{Namespace}) = Base.HasEltype()

# trivial impl.
Base.length(ns::Namespace) = length(ns.names)
Base.eltype(::Type{Namespace}) = Pair{Symbol,Any}

# give out snapshot values per all defined names
function Base.iterate(ns::Namespace, prev_i::Int=0)
  @assert prev_i >= 0
  i = prev_i + 1
  if i > length(ns.names)
    return nothing
  end
  return (ns.names[i] => ns.assignables[i], i)
end


"""    defined(ns::Namespace, name::Symbol)::Union{Nothing,Ref{Any}}

lookup a named value slot (i.e. assignable) in the namespace

"""
function defined(ns::Namespace, name::Symbol)::Union{Nothing,Ref{Any}}
  i = get(ns.dict, name, nothing)
  if i === nothing
    return nothing
  end
  return Ref(ns.assignables, i)
end

"""    define(ns::Namespace, name::Symbol )::Ref{Any}

define a named value slot (i.e. assignable) in the namespace

"""
function define(ns::Namespace, name::Symbol)::Ref{Any}
  lock(ns.mutex) do
    i = get(ns.dict, name, nothing)
    if i === nothing
      i = length(ns.names) + 1
      resize!(ns.names, i)
      resize!(ns.assignables, i)
      ns.names[i] = name
      ns.dict[name] = i
    end
    return Ref(ns.assignables, i)
  end
end


struct Scope
  arts::Namespace # usual artifacts
  uoms::Dict{Symbol,UoMDef} # UoM definitions

  outer::Union{Nothing,Scope}

  Scope(outer::Union{Nothing,Scope}=nothing) = new(Namespace(), Dict{Symbol,UoMDef}(), outer)
end



function keyword_interpreter(kw::Symbol, interpreter::Function; context)

end


function assign_interp()

end


end # module MXS 
