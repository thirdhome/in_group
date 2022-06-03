# frozen_string_literal: true

require_relative "in_group/version"
require_relative "in_group/mixin"
require_relative "in_group/definition"
require "active_record"

module InGroup
  class Error < StandardError; end

  def self.define(klass, &block)
    raise ArgumentError, "block required" if block.nil?
    definition = klass.instance_variable_get(:@_in_group_definition)

    if definition.nil?
      definition = Definition.new
      klass.instance_variable_set(:@_in_group_definition, definition)
      klass.subclasses.each do |sub_klass|
        sub_klass.instance_variable_set(:@_in_group_definition, definition)
      end
    end

    block.call(definition)
    if !klass.is_a?(Mixin)
      klass.include(Mixin)
    end
  end
end
