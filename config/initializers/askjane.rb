require 'lib_core'

class String
  def cut_partial(length)
    if self.length > length
      self.first(length) + "..."
    else
      self
    end
  end
end
