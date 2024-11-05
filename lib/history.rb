# frozen_string_literal: true

require_relative "history/version"

module History

  class Admin
    def initialize(model_name, class_name, class_id, changes, admin_id, change_content)
      @model_name = Object.const_get(model_name)
      @class_name = class_name
      @class_id = class_id
      @changes = changes
      @update_user_id = admin_id
      @change_content = change_content
    end
    
    def history_write(*args)
      history_code = args[0]  
      unless history_code.present?
        history_code = generate_history_code
      end    
      @changes.each do |attribute_name, values|
        next if attribute_name == "updated_at"
        before_value = remove_special_characters(truncate(values[0].to_s, length: 700)) if !values[0].nil?
        after_value = remove_special_characters(truncate(values[1].to_s, length: 700)) if !values[1].nil?      
        
        @model_name.create!({
        history_code: history_code,
        class_name: @class_name,
        class_id: @class_id,
        column_name: attribute_name,
        before_value: before_value.to_s,
        after_value: after_value.to_s,
        change_content: @change_content,
        admin_id: @update_user_id})
      end
      "hello, #{history_code}!"
    end

    private

    def generate_history_code
      loop do
        token = SecureRandom.hex(10)
        history_code = "#{Date.today.to_s}#{token}"
  
        break history_code unless @model_name.where(history_code: history_code).exists?
        
      end
    end

    def remove_special_characters(input_string)
      special_characters = /[<>:;?]/
      input_string.gsub(special_characters, '')
    end
    
    def truncate(text, length: 30, omission: '...')
      return text if text.length <= length

      truncated_text = text[0, length - omission.length] # Cut the string to fit within the length
      truncated_text + omission # Append the omission (default '...')
    end
  end


  def self.greet(name)
    "Hello, #{name}!"
  end

  
end
