
"""
Meta eXecution System

"""
module MXS

export Namespace, lookup, assign


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
Base.eltype(::Type{Namespace}) = Pair{Symbol,Any}
Base.length(ns::Namespace) = length(ns.names)

# give out snapshot values per all defined names
function Base.iterate(ns::Namespace, prev_i::Int=0)
  @assert prev_i >= 0
  i = prev_i + 1
  if i > length(ns.names)
    return nothing
  end
  return (ns.names[i] => ns.assignables[i], i)
end

"""    lookup(ns::Namespace, name::Symbol)::Union{Nothing,Ref{Any}}

lookup a name in the namespace

return a reference to the value slot (i.e. assignable) if it's ever assigned, or `nothing` if that name is never assigned.

"""
function lookup(ns::Namespace, name::Symbol)::Union{Nothing,Ref{Any}}
  i = get(ns.dict, name, nothing)
  if i === nothing
    return nothing
  end
  return Ref(ns.assignables, i)
end

"""    assign(ns::Namespace, name::Symbol, value::Any)::Ref{Any}

assign a value by a name in the namespace

return a reference to the value slot (i.e. assignable)

"""
function assign(ns::Namespace, name::Symbol, value::Any)::Ref{Any}
  lock(ns.mutex) do
    i = get(ns.dict, name, nothing)
    if i !== nothing
      ns.assignables[i] = value
      return Ref(ns.assignables, i)
    end
    i = length(ns.assignables) + 1
    resize!(ns.assignables, i)
    resize!(ns.names, i)
    ns.names[i] = name
    ns.assignables[i] = value
    ns.dict[name] = i
    return Ref(ns.assignables, i)
  end
end



function keyword_interpreter(kw::Symbol, interpreter::Function; context)

end


function assign_interp()

end


end # module MXS 
