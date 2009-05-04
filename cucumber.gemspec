# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cucumber}
  s.version = "0.3.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aslak Helles\303\270y"]
  s.date = %q{2009-05-05}
  s.description = %q{Executable Feature scenarios}
  s.email = ["aslak.hellesoy@gmail.com"]
  s.has_rdoc = true
  s.homepage = %q{http://cukes.info}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rspec}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Executable Feature scenarios}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<term-ansicolor>, [">= 1.0.3"])
      s.add_runtime_dependency(%q<treetop>, [">= 1.2.5"])
      s.add_runtime_dependency(%q<polyglot>, [">= 0.2.5"])
      s.add_runtime_dependency(%q<diff-lcs>, [">= 1.1.2"])
      s.add_runtime_dependency(%q<builder>, [">= 2.1.2"])
    else
      s.add_dependency(%q<term-ansicolor>, [">= 1.0.3"])
      s.add_dependency(%q<treetop>, [">= 1.2.5"])
      s.add_dependency(%q<polyglot>, [">= 0.2.5"])
      s.add_dependency(%q<diff-lcs>, [">= 1.1.2"])
      s.add_dependency(%q<builder>, [">= 2.1.2"])
    end
  else
    s.add_dependency(%q<term-ansicolor>, [">= 1.0.3"])
    s.add_dependency(%q<treetop>, [">= 1.2.5"])
    s.add_dependency(%q<polyglot>, [">= 0.2.5"])
    s.add_dependency(%q<diff-lcs>, [">= 1.1.2"])
    s.add_dependency(%q<builder>, [">= 2.1.2"])
  end
end
