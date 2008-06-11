require "~/lib/drnic/extract_tag.rb"
print Hobo::Dryml.instantiate_tag(ENV['HOBO_TAG_NAME'],ENV['HOBO_ROOT'])
