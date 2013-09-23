module PaperTrail
  module Model
    module InstanceMethods
      def initialize_copy(source)
        obj = super(source)
        obj.tap { |o| o.send(:remove_instance_variable, :@globalize) } rescue obj
      end
    end
  end
end
