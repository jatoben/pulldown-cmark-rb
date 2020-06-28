# frozen_string_literal: true

require "test_helper"

class TestPulldownCmark < Minitest::Test
  def test_its_aliiiive
    assert_equal(
      "<p><em>Hello</em>, <strong>World</strong>!</p>\n",
      PulldownCmark.render_html("_Hello_, **World**!").to_s
    )
  end
end
