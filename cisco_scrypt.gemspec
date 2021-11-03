# frozen_string_literal: true

require_relative "lib/cisco_scrypt/version"

Gem::Specification.new do |spec|
  spec.name          = "cisco_scrypt"
  spec.version       = CiscoScrypt::VERSION
  spec.authors       = ["Marek Skrobacki"]
  spec.email         = ["skrobul@skrobul.com"]

  spec.summary       = "Generate Cisco type 9 password hashes"
  spec.description   = "Generate Cisco type 9 password hashes, optionally with fixed salt."
  spec.homepage      = "https://github.com/skrobul/cisco_scrypt"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
end
