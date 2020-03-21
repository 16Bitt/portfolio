states = [
  {
    abbreviation: 'AR',
    name: 'Arkansas'
  }
]

states.each do |state|
  State.find_or_initialize_by(abbreviation: state[:abbreviation]).update(state)
end
