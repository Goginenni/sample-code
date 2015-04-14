# This file provides setup and common functionality across all features.  It's
# included first before every test run, and the methods provided here can be 
# used in any of the step definitions used in a test.  This is a great place to
# put shared data like the location of your app, the capabilities you want to
# test with, and the setup of selenium.

require 'appium_lib'
require 'cucumber/ast'
require 'selenium-webdriver'

# Create a custom World class so we don't pollute `Object` with Appium methods
class AppiumWorld
end

# Load the desired configuration from appium.txt, create a driver then
# Add the methods to the world
caps = Appium.load_appium_txt file: File.expand_path('./', __FILE__), verbose: true
Appium::Driver.new(caps)

World do
  AppiumWorld.new
end

Before {
  @browser = $driver.start_driver
  @browser.get('http://saucelabs.com/test/guinea-pig')
  Selenium::WebDriver::Wait.new(timeout:3).until { @browser.title.start_with?'I am a page title'  }
}
After { $driver.driver_quit }
