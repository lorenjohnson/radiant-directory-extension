require File.dirname(__FILE__) + '/../test_helper'

class ChurchFinderExtensionTest < Test::Unit::TestCase
  
  # Replace this with your real tests.
  def test_this_extension
    flunk
  end
  
  def test_initialization
    assert_equal RADIANT_ROOT + '/vendor/extensions/church_finder', ChurchFinderExtension.root
    assert_equal 'Church Finder', ChurchFinderExtension.extension_name
  end
  
end
