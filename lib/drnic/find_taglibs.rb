# Original code pastie by Christoph Blank http://pastie.org/203129
module Hobo; end
module Hobo::Dryml
  extend self

  def find_taglibs(rails_root)
    files = []
    if rails_root
      files = Dir["#{rails_root}/app/views/#{taglibs_dir_pattern}"] # user taglibs
      if Dir["#{rails_root}/vendor/{plugins/hobo,gems/hobo,gems/hobo-*}/"].empty? # proj without gem/plugin
        files.concat system_gem_taglibs
      end
      files.concat Dir["#{rails_root}/vendor/{plugins,gems}/*/#{taglibs_dir_pattern}"]
    else #  no rails proj
      files.concat system_gem_taglibs
    end
    files.uniq
  end
  
  def system_gem_taglibs
    require 'rubygems'
    gem_path = Gem.source_index.find_name('hobo').last.full_gem_path
    Dir[File.join(gem_path, taglibs_dir_pattern)]
  end
  
  def taglibs_dir_pattern
    '**/taglibs/**/*.dryml'
  end
end
