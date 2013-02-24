module ActiveAdmin
  class FormBuilder
    def translate_inputs(*args, &proc)
      pati = Polyglotism::ActiveAdmin::TranslateInputs.new(self, *args, &proc)
      pati.render
    end
  end
end

