desc 'Snapshot the current state of the ADH case number'
task :take_snapshot do
  begin
    adapter = TwilioAdapter.new
    scraper = CoronaScraper.new(ENV['ADH_URL'])
    state = State.find_by(abbreviation: 'AR')
    latest = state.snapshots.order(id: :asc).last
    state.snapshots << Snapshot.new(case_count: scraper.cases)

    if latest.case_count != scraper.cases
      Contact.confirmed.each do |contact|
        adapter.text(contact.phone, "COVID-19 cases in AR has changed to #{scraper.cases}")
      end
    end
  rescue StandardError => e
    warn("Failed to snapshot: #{e}")
    adapter.text(ENV['PAGE_NUMBER'], 'Snapshot task failed, check logs for info')
  end
end
