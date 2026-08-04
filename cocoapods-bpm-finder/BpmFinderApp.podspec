Pod::Spec.new do |s|
  s.name             = 'BpmFinderApp'
  s.version          = '1.0.0'
  s.summary          = 'Audio tempo detection, tap BPM counter, and delay timing calculator.'
  s.description      = <<-DESC
BPM Finder App is a Swift library for iOS and macOS to calculate audio song tempo (BPM), tap beat intervals, and audio delay note divisions.
                       DESC
  s.homepage         = 'https://bpmfinderapp.com'
  s.license          = { :type => 'MIT', :file => 'cocoapods-bpm-finder/LICENSE' }
  s.author           = { 'BPM Finder Team' => 'nazzal5448@gmail.com' }
  s.source           = { :git => 'https://github.com/nazzal5448/bpm-finder-app.git', :tag => 'v1.0.0' }
  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'
  s.swift_version    = '5.0'
  s.source_files     = 'cocoapods-bpm-finder/Classes/**/*'
end
