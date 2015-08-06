module NilBeGone

# abstract superclass defining the monadic interface
class Monad

  def and_then
    raise NotImplementedError
  end

  def from_value
    raise NotImplementedError
  end

  def value
    raise NotImplementedError
  end
end

end
