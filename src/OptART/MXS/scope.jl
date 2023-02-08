
struct Scope
  arts::Namespace # usual artifacts
  uoms::Dict{Symbol,UoMDef} # UoM definitions

  outer::Union{Nothing,Scope}

  Scope(outer::Union{Nothing,Scope}=nothing) = new(Namespace(), Dict{Symbol,UoMDef}(), outer)
end
