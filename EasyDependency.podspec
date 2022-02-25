Pod::Spec.new do |s|
  s.name             = 'EasyDependency'
  s.version          = '3.0.7'
  s.summary          = 'EasyDependency is a very lightweight dependency injection framework, without magic.'
  s.description      = <<-DESC
EasyDependency is a very lightweight dependency injection framework, without magic. Just a container to register and resolve dependencies.
There is no focus on adding support for circular dependencies. Simplicity is key.
                       DESC
  s.homepage         = 'https://github.com/bynelus/EasyDependency'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'NielsKoole' => 'nielskoole@icloud.com' }
  s.source           = { :git => 'https://github.com/bynelus/EasyDependency.git', :tag => s.version.to_s }
  s.swift_version 	 = '5.1'
  s.social_media_url = 'https://twitter.com/NielsKoole'
  s.source_files 	 = 'EasyDependency/Classes/**/*'
  s.ios.deployment_target = '8.0'

end
