Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'newsie_q'
  s.version     = '0.0.1'
  s.summary     = 'Handles newsletter subscriptions asynchronously in a queue'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Evan Whalen'
  s.homepage          = 'http://github.com/evanwhalen'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency('hominid')
  s.add_dependency('resque')
end
