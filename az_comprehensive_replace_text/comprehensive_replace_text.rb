# Comprehensive Replace Text extension for SketchUp
# Find and Replace text in Component Names, Material Names, Tag Names (Layers), and Model Name

require 'sketchup.rb'

module AlexZahn
  module CRT

    def self.comprehensiveReplaceText ()
  
      # Prompt user for text to find
      find_text = UI.inputbox(
        ["Text to find:      "], 
        [""],
        "Text to Find"
      )[0]
  
      # Prompt user for replacement text
      replace_text = UI.inputbox(
        ["Replacement text:      "], 
        [""],
        "Replacement Text"
      )[0]
  
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
          if component.name.include? find_text
            original_name = component.name
            new_name = original_name.gsub(find_text, replace_text)
            component.name = new_name
          end
        end
    
        # Loop through each layer and rename any matches
        model.layers.each do |layer|
          if layer.name.include? find_text
            original_name = layer.name
            new_name = original_name.gsub(find_text, replace_text)
            layer.name = new_name
          end
        end
    
        # Loop through each material and rename any matches
        model.materials.each do |material|
          if material.name.include? find_text
            original_name = material.name
            new_name = original_name.gsub(find_text, replace_text)
            material.name = new_name
          end
        end
    
        # Rename the model
        model.name = model.name.gsub(find_text, replace_text)
        
        ## END UNDOABLE OPERATION
        # model.commit_operation
        
      end # unless

    end # comprehensiveReplaceText

    unless file_loaded?(__FILE__)
      command = UI::Command.new("Comprehensive Replace Text") {self.comprehensiveReplaceText}
      command.status_bar_text = "Find-and-Replace text in Components, Tags, Material Names, and Model Name."
      UI.menu('Plugins').add_item(command)
      
      file_loaded(__FILE__)
    end

  end # module CRT
end # module AlexZahn