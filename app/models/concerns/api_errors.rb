module ApiErrors
  module ClassMethods

  end

  module InstanceMethods
    def full_errors
      self.errors.full_messages.join(', ')
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end