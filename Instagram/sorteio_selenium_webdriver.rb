require 'selenium-webdriver'

Selenium::WebDriver::Chrome.driver_path="C:/chromedriver.exe"

options = Selenium::WebDriver::Chrome::Options.new
#options.add_argument('--headless')
@driver = Selenium::WebDriver.for :chrome, options: options

#@driver = Selenium::WebDriver.for :chrome
@driver.manage.timeouts.implicit_wait = 10

@driver.navigate.to "https://www.instagram.com"

@driver.find_element(:name => 'username').send_keys("apartamento258")        
@driver.find_element(:name => 'password').send_keys("portyner123")
@driver.action.send_keys(:enter).perform

@driver.find_element(:class => 'XTCLo').send_keys("binhoovideos")
@driver.find_element(:class => 'z556c').click

x = 0

while x < 20
    y = 0
    page = '/html/body/div[5]/div[2]/div/article/div[3]/section[3]'
    
    while y < 10
        @driver.find_element(:class => '_9AhH0').click
        @driver.find_element(:xpath => "#{page}/div/form").click
        @driver.find_element(:xpath => "#{page}/div/form/textarea").send_keys("Esse é meu!!")
        @driver.action.send_keys(:enter).perform

        if @driver.find_element(:class => 'JBIyP').click
           @driver.find_element(:xpath => "#{page}/div/form/textarea").send_keys("")
           sleep 50
        end
        sleep 8
        
        @driver.find_element(:xpath => '/html/body/div[5]/div[3]/button').click
        y+=1
        sleep 5
    end

    sleep 50
    x+=1

end

#Não foi possível publicar o comentário.

#:class => 'JBIyP'

#:xpath => '/html/body/div[4]/div/div/div/p'

#/html/body/div[4]/div/div/div/p


