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

  # def test_history_write
  #   # assert_equal "hello, world!", History::Admin.history_write("world")
  #   assert_equal "hello, 100!", History::Admin.new(MockHistory, "Admin::Association", 1, {"address"=>["update  address 281", "update  address 281aa"], "display_address"=>["〒 160-0002 東京都 新宿区 Yangon update  address 281", " 
  #       〒 160-0002 東京都 新宿区 Yangon update  address 281aa"]}, 1, "content").history_write("100")
  # end

  # def setup
  #   @history_creator = History::Admin.new(MockHistory, "Admin::Association", 1, {"address"=>["update  address 281", "update  address 281aa"], "display_address"=>["〒 160-0002 東京都 新宿区 Yangon update  address 281", " 
  # #       〒 160-0002 東京都 新宿区 Yangon update  address 281aa"]}, 1, "content").history_write("100")
  # end

  def test_history_write
    # Act: Create history record
    # record = @history_creator.create_history(
    #   history_code: "TEST_CODE",
    #   class_name: "TestClass",
    #   class_id: 1,
    #   attribute_name: "attribute_name",
    #   before_value: "old_value",
    #   after_value: "new_value",
    #   change_content: "change made",
    #   admin_id: 100
    # )
    record = History::Admin.new(MockHistory, "Admin::Association", 1, {"address"=>["update  address 281", "update  address 281aa"], "display_address"=>["〒 160-0002 東京都 新宿区 Yangon update  address 281", " 
      #       〒 160-0002 東京都 新宿区 Yangon update  address 281aa"]}, 1, "content").history_write("100")

    # Assert: Check attributes on created record
    assert_equal "Admin::Association", record.class_name
    assert_equal 1, record.class_id
    assert_equal "update  address 281", record.before_value
    assert_equal "update  address 281aa", record.after_value
    assert_equal "content", record.change_content
    assert_equal 1, record.admin_id
  end

end