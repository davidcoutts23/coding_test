# frozen_string_literal: true

class String
  def is_integer?
    to_i.to_s == self
  end
end
