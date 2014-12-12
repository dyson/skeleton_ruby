desc "Rename SkeletonRuby modules and skeleton_ruby files/directories"
task :rename, :new_module_name  do |t, args|
  module_name = args.new_module_name
  underscore_name = module_name.underscore

  puts "Replacing file/directory names containing skeleton_ruby with #{underscore_name}"
  `find . -type d -not -path "./.*" -not -path "./.*/*" -not -path "./vendor" -not -path "./vendor/*" | xargs rename -v 's/skeleton_ruby$/#{underscore_name}/'`
  `find . -type f -not -name ".*" -not -path "./.*/*" -not -path "./vendor/*" | xargs rename -v 's/skeleton_ruby/#{underscore_name}/'`

  puts "Replacing skeleton_ruby references inside files with #{underscore_name}"
  `find . -type f -not -name ".*" -not -path "./.*/*" -not -path "./vendor/*" | xargs sed -i 's/skeleton_ruby/#{underscore_name}/g'`

  puts "Replacing SkeletonRuby module references inside files with #{module_name}"
  `find . -type f -not -path "./vendor/*" | xargs sed -i 's/SkeletonRuby/#{module_name}/g'`
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
