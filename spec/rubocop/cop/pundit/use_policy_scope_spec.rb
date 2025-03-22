# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Pundit::UsePolicyScope do
  let(:config) do
    RuboCop::Config.new(
      'Pundit/UsePolicyScope' => {
        'Enabled' => true
      }
    )
  end
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when policy scope is missing' do
    expect_offense(<<~RUBY)
      def index
        @records = Record.all
                   ^^^^^^^^^^ Wrap model in policy_scope() before using Active Model query methods.
      end
    RUBY
  end

  it 'does not register an offense when policy scope is used' do
    expect_no_offenses(<<~RUBY)
      def index
        @records = policy_scope(Record).all
      end
    RUBY
  end
end
