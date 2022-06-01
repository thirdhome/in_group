module InGroup
  module EvaluateMembership
    def self.call(instance, group)
      criteria_sets =
        instance.class.instance_variable_get(:@_in_group_definition).fetch(group)

      criteria_sets.any? do |set|
        set.all? do |(field_name, values)|
          if !values.is_a?(Array)
            values = [values]
          end
          field_value = instance.send(field_name)
          values.include?(field_value)
        end
      end
    end
  end
end
