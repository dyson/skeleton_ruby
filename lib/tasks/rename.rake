desc "Rename SkeletonRuby modules and skeleton_ruby files/directories"
task :rename, :new_module_name  do |t, args|
  module_name = args.new_module_name
  underscore_name = module_name.underscore

  puts "Replacing skeleton_ruby files/directories with #{underscore_name}"
  `find . -not -path "./vendor/*" | xargs rename -v 's/skeleton_ruby/#{underscore_name}/'`
  `find . -type f -not -path "./vendor/*" | xargs sed -i 's/skeleton_ruby/#{underscore_name}/g'`

  puts "Replacing SkeletonRuby module with #{module_name}"
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
