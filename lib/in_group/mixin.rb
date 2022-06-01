require_relative "build_scope"
require_relative "evaluate_membership"

module InGroup
  module Mixin
    def self.included(klass)
      klass.scope :in_group, ->(group) { BuildScope.call(self, group) }
    end

    def in_group?(group)
      EvaluateMembership.call(self, group)
    end
  end
end
