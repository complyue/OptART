
struct KeyPhraseInput

  # left hand side tokens
  lhs::Vector{String}

  # middle token groups among the keywords forming the keyphrase
  mids::Vector{Vector{String}}

  # right hand side tokens
  rhs::Vector{String}

end


function keyphrase_interpreter(kws::Vector{String}, interpreter::Function; context)

end


function assign_interp(lhs::Vector{String}, rhs::Vector{String})

end
