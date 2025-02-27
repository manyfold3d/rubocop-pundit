# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/pundit'
require_relative 'rubocop/pundit/version'
require_relative 'rubocop/pundit/inject'

RuboCop::Pundit::Inject.defaults!

require_relative 'rubocop/cop/pundit_cops'
