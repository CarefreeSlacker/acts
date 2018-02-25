class RubyGemsPage < SitePrism::Page
  set_url "/"

  element :search_field, "input#home_query"
  element :gem_name, "a.t-link--black"

end

module BaseElementsAndMethods

  def open_rubygems
    @rgp = RubyGemsPage.new
    @rgp.load
  end

  def entering_text
    @rgp.search_field.set "acceptance_testing"
  end

  def press_enter_button
    @rgp.search_field.send_keys :enter
  end

  def visible_gem_name
    expect(@rgp.gem_name).to have_text("acceptance_testing")
  end

end
