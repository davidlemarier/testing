Wo0otView = require './wo0ot-view'
{CompositeDisposable} = require 'atom'

module.exports = Wo0ot =
  wo0otView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @wo0otView = new Wo0otView(state.wo0otViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @wo0otView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'wo0ot:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @wo0otView.destroy()

  serialize: ->
    wo0otViewState: @wo0otView.serialize()

  toggle: ->
    console.log 'Wo0ot was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
