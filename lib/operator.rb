module Garb
  class Operator
    Dir[File.expand_path "../operator/*.rb", __FILE__].each do |path|
      autoload Garb.camelize(File.basename path, '.*'), path
    end
  end
end