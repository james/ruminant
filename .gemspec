Gem::Specification.new do |s|
  s.name = "Ruminant"
  s.version = "0.0.1"
  s.date = "2008-07-02"
  s.summary = "A ruby library to regurgitate MOO products"
  s.email = "james@abscond.org"
  s.homepage = "http://github.com/james/ruminant"
  s.description = "A ruby library to regurgitate MOO products"
  s.has_rdoc = false
  s.authors = ["James Darling"]
  s.files = %w(lib/moo.rb lib/design.rb lib/text_line.rb lib/template.xml.builder lib/core_ext/options_struct.rb)
  s.test_files = %w(spec/all.rb spec/minicard_spec.rb spec/moo_spec.rb spec/product_spec.rb spec/spec_helper.rb)
  s.rdoc_options = ["--main", "README.txt"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.add_dependency("rc-rest", ["> 0.0.0"])
end