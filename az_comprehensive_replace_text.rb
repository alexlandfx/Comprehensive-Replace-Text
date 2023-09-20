require 'sketchup.rb'
require 'extensions.rb'

module AlexZahn
  module CRT
    unless file_loaded?(__FILE__)

      extension = SketchupExtension.new('Comprehensive Replace Text', 'az_comprehensive_replace_text/comprehensive_replace_text.rb')
      extension.description = 'Find-and-Replace text in Components/Tags/Materials/ModelName'
      extension.version     = '1.0.0'
      extension.creator     = 'Alex Zahn'
      extension.copyright   = '2023, Alex Zahn, Creative Commons.'

      Sketchup.register_extension(extension, true)

      file_loaded(__FILE__)

    end
  end # module CRT
end # module AlexZahn