require 'nokogiri'
require 'open-uri'

# Scrape cases from healthy.arkansas.gov
# Heavy memoization because nokogiri is bulky and slow
class CoronaScraper
  CASE_REGEX = /Confirmed Cases of COVID-19 in Arkansas\s+(\d+)/i

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
    @nokogiri ||= Nokogiri::HTML(open(@url))
  end
end
