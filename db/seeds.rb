
Rate.insert_all(
  JSON.parse(File.read(Rails.root.join('spec','fixtures','rates.json')))['rates']
)
