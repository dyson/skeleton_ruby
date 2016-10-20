require 'find'

desc "Rename SkeletonRuby modules and skeleton_ruby files/directories"
task :rename, :new_module_name  do |t, args|
  module_name = args.new_module_name
  underscore_name = module_name.underscore

  CURRENT_MODULE_NAME = 'SkeletonRuby'
  CURRENT_UNDERSCORE_NAME = 'skeleton_ruby'

  puts "Replacing file/directory names containing #{CURRENT_UNDERSCORE_NAME} with #{underscore_name}..."

  Dir["**/*"].reject { |p| p['vendor'] }.reverse.each do |path|

    if FileTest.file? path
      # if we're working with a file, read its content and replace references to CURRENT_UNDERSCORE_NAME or CURRENT_MODULE_NAME

      file_content = File.readlines(path)

      # Determine whether this file contains references to CURRENT_UNDERSCORE_NAME, or CURRENT_MODULE_NAME
      includes_underscore_references = file_content.grep(/#{CURRENT_UNDERSCORE_NAME}/).any?
      includes_module_references = file_content.grep(/#{CURRENT_MODULE_NAME}/).any?

      if includes_module_references || includes_underscore_references

        puts "Replacing occurrences of #{CURRENT_UNDERSCORE_NAME} in #{path}..." if includes_underscore_references
        puts "Replacing occurrences of #{CURRENT_MODULE_NAME} in #{path}..." if includes_module_references

        new_content = []
        file_content.each do |line|

          # Replace CURRENT_UNDERSCORE_NAME with the desired underscore name
          line.gsub!(/#{CURRENT_UNDERSCORE_NAME}/, underscore_name) if includes_underscore_references

          # Replace the module name
          line.gsub!(/#{CURRENT_MODULE_NAME}/, module_name) if includes_module_references

          new_content << line
        end

        # Re-write the file, with the new changes
        File.open(path, 'w') do |f|
          new_content.each do |line|
            f.write line
          end
        end
      end
    end

    # Rename the file/folder, if necessary
    if path.include? CURRENT_UNDERSCORE_NAME
      new_path = path.gsub(CURRENT_UNDERSCORE_NAME, underscore_name)

      # If the path is a file, make sure the new parent directory exists
      if FileTest.file? path
        new_parent_directory = File.dirname new_path

        FileUtils.mkdir_p new_parent_directory
      end

      puts "Renaming #{path} to #{new_path}..."
      FileUtils.mv path, new_path
    end

  end
end

def underscore(camel_cased_word)
  word = camel_cased_word.to_s.gsub('::', '/')
  word.gsub!(/(?:([A-Za-z\d])|^)(#{inflections.acronym_regex})(?=\b|[^a-z])/) { "#{$1}#{$1 && '_'}#{$2.downcase}" }
  word.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
  word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
  word.tr!("-", "_")
  word.downcase!
  word
end
