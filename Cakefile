{exec} = require 'child_process'
fs     = require 'fs'

mdjson = './data/municipios-data.json'
munijs = './build/muni14.js'


config =
  srcDir:  'coffee'
  outDir:  'js'
  inFiles: [ 'muni14' ]
  #outFile: 'client'
  #yuic:    '~/Dropbox/toolbox/dotfiles/bin/yuicompressor-2.4.2.jar'

# deal with errors from child processes
exerr  = (err, sout,  serr)->
  process.stdout.write err  if err
  process.stdout.write sout if sout
  process.stdout.write serr if serr

task 'extract', 'data.YML -> data.JSON', ->
  exec 'coffee ./tasks/extract.coffee', exerr

task 'test', 'runs jasmine tests', ->
  exec 'jasmine-node --coffee --verbose spec', exerr

# watch files and run tests automatically
task 'watch', 'watch and run tests', ->
  console.log 'watching...'

  whenChanged = (filename, fun)->
    fs.watchFile filename, (curr, prev)->
      fun() if curr.mtime > prev.mtime

  for f in config.inFiles
    whenChanged "#{f}.coffee", ->
      console.log "=====TEST #{new Date().toLocaleString()} ====="
      invoke 'test'

task 'build', 'builds the script', ->
  code  = fs.readFileSync( config.inFiles[0] + '.coffee' ).toString()
  code += 'root.Muni14.data = ' + fs.readFileSync( mdjson ).toString()
  fs.writeFileSync( '___TMP', code )
  exec  "coffee -cp ./___TMP > #{munijs} && rm ___TMP", exerr
