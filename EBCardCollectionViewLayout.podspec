#
# Be sure to run `pod lib lint EBCardLayout.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "EBCardCollectionViewLayout"
  s.version          = "0.1.0"
  s.summary          = "A \"card style\" UICollectionViewLayout for iOS 7+"
  s.description      = <<-DESC
                       A \"card style\" UICollectionViewLayout for iOS 7+

                       * Markdown format.
                       DESC
  s.homepage         = "https://github.com/betzerra/EBCardCollectionViewLayout"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Ezequiel Becerra" => "ezequiel.becerra@gmail.com" }
  s.source           = { :git => "https://github.com/betzerra/EBCardCollectionViewLayout.git", :tag => "0.1.0" }
  s.social_media_url = 'https://twitter.com/betzerra'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'EBCardCollectionViewLayout/src'
end
