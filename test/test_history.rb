# test/test_my_gem.rb
require "minitest/autorun"
require "history"  # Replace "my_gem" with the actual name of your gem file

class TestHistory < Minitest::Test
  def test_example
    assert_equal "Hello, world!", History.greet("world")
  end

  # def test_history_write
  #   # assert_equal "hello, world!", History::Admin.history_write("world")
  #   assert_equal "hello, 100!", History::Admin.new("Admin::History","Admin::Association", 1, {"address"=>["update  address 281", "update  address 281aa"], "display_address"=>["〒 160-0002 東京都 新宿区 Yangon update  address 281", " 
  #       〒 160-0002 東京都 新宿区 Yangon update  address 281aa"]}, 1, "content").history_write("100")
  # end

  # Setup a mock model with expected methods
  MockHistory = Struct.new(:history_code, :class_name, :class_id, :column_name, :before_value, :after_value, :change_content, :admin_id) do
    def self.create!(attrs)
      new(*attrs.values_at(:history_code, :class_name, :class_id, :column_name, :before_value, :after_value, :change_content, :admin_id))
    end
  end

  def test_history_write
    assert_equal "hello, 100!", History::Admin.new(MockHistory, "Admin::Association", 1,   {"phone_no_1"=>["09111111111", "09222222222"]}, 1, "content").history_write("100")
  end

end