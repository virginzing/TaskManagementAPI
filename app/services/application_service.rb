# frozen_string_literal: true

class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def SUCCESS(value)
    { success: true, value: value }
  end

  def FAILED(value)
    { success: false, value: value }
  end
end
