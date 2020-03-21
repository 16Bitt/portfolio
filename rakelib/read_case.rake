desc 'Print out the current number of coronavirus cases'
task :read_case do
  scraper = CoronaScraper.new(ENV['ADH_URL'])
  puts("#{scraper.cases} cases in Arkansas")
end
