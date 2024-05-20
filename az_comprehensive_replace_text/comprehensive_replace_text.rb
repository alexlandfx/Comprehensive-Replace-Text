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
  # Early return if 'Cancel' button pressed or no string was entered
  return false if text_to_find == false || text_to_find == ""
  
  text_to_find = text_to_find[0]

  # Prompt user for replacement text
  replacement_text = UI.inputbox(
    ["Replacement text:      "], 
    [""],
    "Replacement Text"
  )
  # Early return if 'Cancel' button pressed
  return false if replacement_text == false
  
  replacement_text = replacement_text[0]

  # Begin text replacement
  model = Sketchup.active_model
  unless model.nil?
    # Get all component definitions in the model
    components = model.definitions.select { |definition| definition.is_a?(Sketchup::ComponentDefinition) }

    # Loop through each component definition and rename any matches
    components.to_a.each do |component|
      if component.name.include? text_to_find
        original_name = component.name
        new_name = original_name.gsub(text_to_find, replacement_text)
        component.name = new_name
      end
    end

    # Loop through each layer and rename any matches
    model.layers.to_a.each do |layer|
      if layer.name.include? text_to_find
        original_name = layer.name
        new_name = original_name.gsub(text_to_find, replacement_text)
        layer.name = new_name
      end
    end

    # Loop through each material and rename any matches
    model.materials.to_a.each do |material|
      if material.name.include? text_to_find
        original_name = material.name
        new_name = original_name.gsub(text_to_find, replacement_text)
        material.name = new_name
      end
    end

    # Rename the model
    model.name = model.name.gsub(text_to_find, replacement_text)
    
    # Refresh inspectors so mouse-hover tooltip names update
    UI.refresh_inspectors
  end # unless
end # comprehensiveReplaceText

unless file_loaded?(__FILE__)
  UI.menu('Plugins').add_item('Comprehensive Replace Text') {self.comprehensiveReplaceText}
  file_loaded(__FILE__)
end

end # module ComprehensiveReplaceText
end # module AlexZahn