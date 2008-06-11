require '~/lib/drnic/extract_tag.rb'
puts Hobo::Dryml.extract_tag(ENV['HOBO_TAG_NAME'],ENV['HOBO_ROOT'])
