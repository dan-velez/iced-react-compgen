# IcedReact(IR) Interactive Component Generator

out = console.log
fs = require 'fs'
readline = require 'readline'
path = require 'path'
mkdirp = require 'mkdirp'

class IRCompGen
  prompts:
    componentName: 'Enter name of component(CamelCase): '
    dirname: 'Enter directory to save this component to(relative to current directory): '

  constructor: ->
    @rl = readline.createInterface
      input: process.stdin
      output: process.stdout

  runInteractive: =>
    await @rl.question @prompts.componentName, defer componentName
    out 'Generating', componentName, '...'
    componentString = @genComponent componentName
    await @rl.question @prompts.dirname, defer dirname
    filename = @genFileName dirname, componentName
    await @confirmWrite filename, defer confirm
    if not confirm
      out 'Canceling component gen!'
      return @runInteractive()
    out '>> Writing to', filename
    @writeFile filename, componentString
    @rl.close()

  writeFile: (filename, string)->
    await fs.writeFile filename, string, defer err
    if err
      out 'Dir does not exist, creating', path.dirname filename
      await mkdirp path.dirname(filename), defer err
      return console.err if err
      return @writeFile filename, string
    out 'Component written to disk.'

  genComponent: (componentName)-> """
    React = require 'react'

    class #{componentName} extends React.Component
      constructor: (props)->
        super props

      render: ->
        <div>
        </div>

    module.exports = #{componentName}
    """

  confirmWrite: (filename, callb)->
    await @rl.question "Confirm write to #{filename}[yn]: ", defer resp
    resp = resp.toLowerCase().trim()
    if resp.startsWith 'y' then return callb true
    else if resp.startsWith 'n' then return callb false
    else return @confirmWrite filename, callb

  genFileName: (dirname, component)->
    path.resolve './'+dirname+'/'+component+'.iced'

new IRCompGen().runInteractive()
