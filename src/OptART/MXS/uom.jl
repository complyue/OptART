
struct UoMDef
  id::Symbol # identifier
  conversions::Dict{UoMDef,Function}  # conversion rules
end

struct Qty
  n::Number
  uom::UoMDef
end
