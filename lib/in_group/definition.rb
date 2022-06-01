module InGroup
  class Definition
    class GroupNotDefined < StandardError; end

    def initialize
      @hash = {}
    end

    def add(group, criteria)
      (@hash[group.to_sym] ||= []).then do |array|
        array << criteria
      end
    end

    def fetch(group)
      @hash.fetch(group)
    rescue KeyError
      raise GroupNotDefined, "group not defined #{group}"
    end
  end
end
