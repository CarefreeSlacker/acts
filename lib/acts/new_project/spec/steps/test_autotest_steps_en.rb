require 'spec_helper'

module TestAutotestStepsEn

  step 'the user opens the site "rubygems.org"' do
    open_rubygems
  end

  step 'input for search "acceptance_testing"' do
    entering_text
  end

  step 'press "enter"' do
    press_enter_button
  end

  step 'the gem will open "acceptance_testing"' do
    visible_gem_name
  end
end

RSpec.configure { |c| c.include TestAutotestStepsEn }
