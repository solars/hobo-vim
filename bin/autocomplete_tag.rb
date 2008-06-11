require '~/lib/drnic/extract_tag'
puts Hobo::Dryml.autocomplete_tag(ENV['HOBO_TAG_NAME'], ENV['HOBO_ROOT'])
