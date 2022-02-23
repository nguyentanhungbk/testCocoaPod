Pod::Spec.new do |spec|
  spec.name             = 'CommonExtension'
  spec.version          = '1.0.0'
  spec.summary          = 'A short description'
  spec.description      = 'A detail description'
  spec.homepage         = ''
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { 'SPHTech' => 'itdios@sph.com.sg' }
  spec.platform         = :ios, '11.2'
  spec.swift_version    = '5.1'
  
  spec.homepage         = 'https://github.com/HungNguyen/CommonExtension'
  spec.source           = { :git => 'https://github.com/HungNguyen/CommonExtension.git', :tag => spec.version.to_s }
  
  spec.framework        = 'Foundation', 'UIKit'
  
  spec.ios.deployment_target = '11.2'

  spec.source_files = 'Sources/**/*'
  end