module InitUtils

  def init_capybara
    register_selenium_chrome
    select_driver :chrome
    Capybara.match = :first
    Capybara.default_max_wait_time = 15
    Capybara.app_host = "http://#{ENV['SERVER']}"
  end

  def select_driver(driver_name)
    Capybara.javascript_driver = driver_name
    Capybara.default_driver = driver_name
  end

  def register_selenium_chrome
     args = %w(--screen 0 1920x1080x24--screenshot --headless --disable-gpu --window-size=1920,1080 --allow-insecure-localhost --ignore-certificate-errors
               --allow-failed-policy-fetch-for-test --disable-popup-blocking --enable-automation --start-maximized --disable-web-security
               --disable-prompt-on-repost --disable-extensions-file-access-check --disable-default-apps)
     Capybara.register_driver :chrome do |app|
       Capybara::Selenium::Driver.new(app,
                                      browser: :chrome,
                                      desired_capabilities: {
                                        :browser_name => 'chrome',
                                        :javascript_enabled => true,
                                        :css_selectors_enabled => true,
                                        :loggingPrefs => {browser: 'ALL',
                                                          driver: 'ALL'},
                                        'chromeOptions' => {
                                          'args' => args
                                        }
                                      })
     end
   end

  def init_rspec
    RSpec.configure do |config|
      config.color = true
      config.formatter = :progress

      config.before(chrome: true) do
        select_driver :chrome
      end
      config.after(chrome: true) do
        select_driver :chrome
      end
    end
  end

  def init_site_prism
    SitePrism.configure do |config|
      config.use_implicit_waits = true
    end
  end

end
