# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

removeEl = ->
  @fadeOut('fast', (=> @remove()))

replaceContent = (elToSet) ->
  idChanging = @attr('id')
  @attr('id', 'old_' + idChanging)
  @after(elToSet)
  $('#' + idChanging)
    .css('opacity', 0)
    .addDelayedRemoveClass(@attr('class'), 2500)
    .animate
      'opacity': 1
    , 'fast'
  $('#old_' + idChanging).remove()

console.log 'started listening'
window.source = new EventSource("/barcode/stream")

source.addEventListener "barcodes.create", (e) ->
  data = JSON.parse(e.data)
  element =  SHT['barcodes/show'](data)
  $('#barcodes tbody').prepend(element)
  $("#barcode_#{data.id}").addDelayedRemoveClass('highlight-create', 5000)

source.addEventListener "barcodes.update", (e) ->
  data = JSON.parse(e.data)
  updatedDomEl = SHT['barcodes/show'](data)
  $el = $("#barcode_#{data.id}")
  $el.addDelayedRemoveClass('highlight-update', 5000, (-> replaceContent.call $el, updatedDomEl))

source.addEventListener "barcodes.destroy", (e) ->
  data = JSON.parse(e.data)
  $("#barcode_#{data.id}").addDelayedRemoveClass('highlight-remove', 5000, removeEl)

$ ->
  $(window).onbeforeunload = ->
    console.log 'unloading'
    source.close()
