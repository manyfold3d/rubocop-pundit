# frozen_string_literal: true

module RuboCop
  module Cop
    module Pundit
      # Checks for overriding built-in Active Record methods instead of using
      # callbacks.
      #
      # @example
      #   # bad
      #   class Book < ApplicationRecord
      #     def save
      #       self.title = title.upcase!
      #       super
      #     end
      #   end
      #
      #   # good
      #   class Book < ApplicationRecord
      #     before_save :upcase_title
      #
      #     def upcase_title
      #       self.title = title.upcase!
      #     end
      #   end
      #
      class AvoidUnscoped < Base
        MSG = 'Avoid using `unscoped`, as it will remove any policy restrictions'
        RESTRICT_ON_SEND = [:unscoped].freeze

        def on_send(node)
          add_offense(node)
        end
      end
    end
  end
end
