{exec, child} = require 'child_process'
linterPath = atom.packages.getLoadedPackage("linter").path
Linter = require "#{linterPath}/lib/linter"
class LinterJavac extends Linter

# The syntax that the linter handles. May be a string or
# list/tuple of strings. Names should be all lowercase.
# TODO: research if there are other java resources must be added
@syntax: 'source.julia'
# A string, list, tuple or callable that returns a string, list or tuple,
# containing the command line (with arguments) used to lint.
cmd: 'julia -Xlint:all'
linterName: 'julia'

# A regex pattern used to extract information from the executable's output.
regex: 'java:(?<line>\\d+): ((?<error>error)|(?<warning>warning)): (?<message>.+)[\\n\\r]'
constructor: (editor) ->
super(editor)
atom.config.observe 'linter-julia.javaExecutablePath', =>
@executablePath = atom.config.get 'linter-julia.javaExecutablePath'
destroy: ->
atom.config.unobserve 'linter-julia.javaExecutablePath'
errorStream: 'stderr'
