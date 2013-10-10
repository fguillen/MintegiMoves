# coding: utf-8

require "test_helper"

class StringTest < ActiveSupport::TestCase
  def test_to_md
    assert_equal("<p>wadus <strong>wadus</strong></p>", "wadus **wadus**".to_md)
  end

  def test_sanitize
    assert_equal("AEIOU aeiou Nn 12", "ÁÉÍÓÚ áéíóú Ññ 12".sanitize)
  end

  def test_to_url
    assert_equal("aeiou-aeiou-nn-12", "ÁÉÍÓÚ áéíóú Ññ  12".to_url)
  end
end
