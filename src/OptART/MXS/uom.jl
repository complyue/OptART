
struct UoMDef
  id::Symbol # identifier
  conversions::Dict{UoMDef,Function}  # conversion rules
end
