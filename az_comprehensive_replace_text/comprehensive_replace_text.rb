# Comprehensive Replace Text extension for SketchUp
# Find and Replace text in Component Names, Material Names, Tag Names (Layers), and Model Name

require 'sketchup.rb'

module AlexZahn
  module ComprehensiveReplaceText

    def self.comprehensiveReplaceText ()
  
      # Prompt user for text to find
      text_to_find = UI.inputbox(
        ["Text to find:      "], 
        [""],
        "Text to Find"
      )
      if (text_to_find == false)
        return false
      else
        text_to_find = text_to_find[0]
      end
  
      # Prompt user for replacement text
      replacement_text = UI.inputbox(
        ["Replacement text:      "], 
        [""],
        "Replacement Text"
      )
      if (replacement_text == false)
        return false
      else
        replacement_text = replacement_text[0]
      end
  
      model = Sketchup.active_model

      unless model.nil?
    
        # Get all components in the model
        components = model.definitions.select { |definition| definition.is_a?(Sketchup::ComponentDefinition) }

        ## When the following code is made an operation, component renaming stops working, 
        ##   and the operation does not appear in the undo menu. Undo menu only shows "Undo Rename Tag".
        ## BEGIN UNDOABLE OPERATION
        # model.start_operation('Comprehensive Replace Text', true, false, false)
    
        # Loop through each component and rename any matches
        components.each do |component|
          if component.name.include? text_to_find
            original_name = component.name
            new_name = original_name.gsub(text_to_find, replacement_text)
            component.name = new_name
          end
        end
    
        # Loop through each layer and rename any matches
        model.layers.each do |layer|
          if layer.name.include? text_to_find
            original_name = layer.name
            new_name = original_name.gsub(text_to_find, replacement_text)
            layer.name = new_name
          end
        end
    
        # Loop through each material and rename any matches
        model.materials.each do |material|
          if material.name.include? text_to_find
            original_name = material.name
            new_name = original_name.gsub(text_to_find, replacement_text)
            material.name = new_name
          end
        end
    
        # Rename the model
        model.name = model.name.gsub(text_to_find, replacement_text)
        
        ## END UNDOABLE OPERATION
        # model.commit_operation
        
      end # unless

    end # comprehensiveReplaceText

    unless file_loaded?(__FILE__)

      UI.menu('Plugins').add_item('Comprehensive Replace Text') {self.comprehensiveReplaceText}
      
      file_loaded(__FILE__)

    end

  end # module ComprehensiveReplaceText
end # module AlexZahn