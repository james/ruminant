Gem::Specification.new do |s|
  s.name = %q{ruminant}
  s.version = "0.9.2"

  s.authors = ["James Darling"]
  s.cert_chain = nil
  s.date = %q{2008-09-15}
  s.description = %q{A ruby library to regurgitate MOO products}
  s.email = %q{james@abscond.org}
  s.files = %w(lib/moo.rb lib/design.rb lib/template.xml.builder lib/text_line.rb lib/core_ext/options_struct.rb README)
  s.has_rdoc = false
  s.homepage = %q{http://github.com/james/ruminant/tree/master}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubygems_version = %q{1.1.1}
  s.summary = %q{A ruby library to regurgitate MOO products}
  s.test_files = %w(spec/all.rb spec/design_spec.rb spec/moo_spec.rb spec/product_spec.rb spec/spec_helper.rb)

  s.add_dependency("hpricot")
  s.add_dependency("builder")
end
