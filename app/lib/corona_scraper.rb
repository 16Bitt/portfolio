require 'nokogiri'
require 'open-uri'

# Scrape cases from healthy.arkansas.gov
# Heavy memoization because nokogiri is bulky and slow
class CoronaScraper
  CASE_REGEX = /Confirmed Cases of COVID-19 in Arkansas\s+(\d+)/i
  USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2'
  ACCEPT = 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8'

  def initialize(url)
    @url = url
  end
  
  def cases
    CASE_REGEX.match(text_content)
              .captures
              .first
              .to_i
  end

  private
  
  # single string of all text content from the tables on the page
  def text_content
    @text_content ||= nokogiri.xpath('.//body')
                              .xpath('.//table')
                              .map(&:inner_text)
                              .join('')
  end

  def nokogiri
    @nokogiri ||= Nokogiri::HTML(
      open(
        @url,
        'Accept' => ACCEPT,
        'User-Agent' => USER_AGENT
      )
    )
  end
end
