require 'spec_helper'

module TestAutotestStepsRu

  include BaseElementsAndMethods

  step 'пользователь открывает "rubygems.org"' do
    open_rubygems
  end

  step 'вводит в поле поиска "acceptance_testing"' do
    entering_text
  end

  step 'нажимает клавишу "enter"' do
    press_enter_button
  end

  step 'открывается gem "acceptance_testing"' do
    visible_gem_name
  end
end

RSpec.configure { |c| c.include TestAutotestStepsRu }
