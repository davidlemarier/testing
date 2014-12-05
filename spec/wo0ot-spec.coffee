Wo0ot = require '../lib/wo0ot'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Wo0ot", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('wo0ot')

  describe "when the wo0ot:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.wo0ot')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'wo0ot:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.wo0ot')).toExist()

        wo0otElement = workspaceElement.querySelector('.wo0ot')
        expect(wo0otElement).toExist()

        wo0otPanel = atom.workspace.panelForItem(wo0otElement)
        expect(wo0otPanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'wo0ot:toggle'
        expect(wo0otPanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.wo0ot')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'wo0ot:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        wo0otElement = workspaceElement.querySelector('.wo0ot')
        expect(wo0otElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'wo0ot:toggle'
        expect(wo0otElement).not.toBeVisible()
