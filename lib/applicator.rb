module Garb
  class Applicator
    Dir[File.expand_path "../applicator/*.rb", __FILE__].each do |path|
      autoload Garb.camelize(File.basename path, '.*'), path
    end
  end
end