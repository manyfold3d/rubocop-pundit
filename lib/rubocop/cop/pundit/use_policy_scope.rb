# frozen_string_literal: true

module RuboCop
  module Cop
    module Pundit
      # Make sure ActiveRecord query methods are only used after Pundit policy scoping is applied.
      #
      # @example
      #   # bad
      #   ExampleModel.find(1)
      #
      #   # good
      #   policy_scope(ExampleModel).find(1)
      #
      class UsePolicyScope < Base
        MSG = 'Wrap model in policy_scope() before using Active Model query methods.'
        RESTRICT_ON_SEND = %i[
          count
          annotate
          find
          create_with
          distinct
          eager_load
          extending
          extract_associated
          from
          group
          having
          includes
          joins
          left_outer_joins
          limit
          lock
          none
          offset
          optimizer_hints
          order
          preload
          readonly
          references
          reorder
          reselect
          regroup
          reverse_order
          select
          where
        ].freeze
        ACTIVE_RECORD_CLASSES = %w[ActiveRecord::Base ApplicationRecord ActiveModel::Base ApplicationModel].freeze

        # def_node_matcher :missing_policy_scope_call?, <<~PATTERN
        #   (send (...) :find_each, :all)
        # PATTERN

        def on_send(node)
          # return unless missing_policy_scope_call?(node)
          return unless node.const_receiver?

          # parent_class_name = find_parent_class_name(node.receiver)
          # return unless active_model?(parent_class_name)

          add_offense(node) # , message: message(bad: node.method_name))
        end

        private

        def active_model?(parent_class_name)
          ACTIVE_RECORD_CLASSES.include?(parent_class_name)
        end

        def find_parent_class_name(node)
          return nil unless node

          if node.class_type?
            # puts node.node_parts
            parent_class_name = node.node_parts[1]

            return nil if parent_class_name.nil?

            return parent_class_name.source
          end

          find_parent_class_name(node.parent)
        end
      end
    end
  end
end
