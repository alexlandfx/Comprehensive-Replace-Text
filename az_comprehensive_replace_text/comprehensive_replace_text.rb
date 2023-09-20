# Comprehensive Replace Text extension for SketchUp
# Find and Replace text in Component Names, Material Names, Tag Names (Layers), and Model Name

require 'sketchup.rb'

module AlexZahn
  module CRT

    def comprehensiveReplaceText ()
  
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
      if model then
        
        # BEGIN UNDOABLE OPERATION  
        model.start_operation('Comprehensive Replace Text', true)
    
        # Get all components in the model
        components = model.definitions.select { |definition| definition.is_a?(Sketchup::ComponentDefinition) }
    
        # Loop through each component and rename
        components.each do |component|
          original_name = component.name
          new_name = original_name.gsub(find_text, replace_text)
          component.name = new_name
        end
    
        # Loop through each layer and rename
        model.layers.each do |layer|
          original_name = layer.name
          new_name = original_name.gsub(find_text, replace_text)
          layer.name = new_name
        end
    
        # Loop through each material and rename
        model.materials.each do |material|
          original_name = material.name
          new_name = original_name.gsub(find_text, replace_text)
          material.name = new_name
        end
    
        # Rename the model
        model.name = model.name.gsub(find_text, replace_text)
        
        # END UNDOABLE OPERATION
        model.commit_operation
        
      end # if
    end # comprehensiveReplaceText

    unless file_loaded?(__FILE__)
      command = UI::Command.new("Comprehensive Replace Text") {comprehensiveReplaceText}
      command.status_bar_text = "Find-and-Replace text in Components, Tags, Material Names, and Model Name."
      UI.menu('Plugins').add_item(command)
      
      file_loaded(__FILE__)
    end

  end # module CRT
end # module AlexZahn