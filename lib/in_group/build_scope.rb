module InGroup
  module BuildScope
    def self.call(relation, group)
      criteria_sets =
        relation.klass.base_class.instance_variable_get(:@_in_group_definition).fetch(group).dup

      relation.instance_exec do
        criteria_sets.reduce(nil) do |previous_scope, set|
          new_scope = where(set)
          if previous_scope
            new_scope = previous_scope.or(new_scope)
          end
          new_scope
        end
      end
    end
  end
end
