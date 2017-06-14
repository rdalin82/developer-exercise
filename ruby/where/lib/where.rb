module Where
  def where(**args)
    keys = args.keys
    results = self
    until keys.empty?
      key = keys.pop
      # reject from items if args value doesn't match self item value
      results.reject! { |item| not_match?(item[key], args[key]) }
    end
    results
  end

  protected

  def not_match?(item, matcher)
    !item.to_s.match(matcher.to_s)
  end
end

class Array
  include Where
end
