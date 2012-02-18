fs      = require 'fs'
yaml    = require 'js-yaml'
data    = yaml.load fs.readFileSync './data/municipios-data.yml'
outfile = './data/municipios-data.json'

# save data
fs.writeFileSync outfile, JSON.stringify data
console.log "data saved in #{outfile}."
