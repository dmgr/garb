module Garb
  def self.camelize str
    str.split('_').map { |w| w.capitalize }.join
  end
  
  Dir[File.expand_path "../*.rb", __FILE__].each do |path|
    autoload camelize(File.basename path, '.*'), path
  end
end