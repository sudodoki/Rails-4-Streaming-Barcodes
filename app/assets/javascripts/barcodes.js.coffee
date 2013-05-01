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

notify = (action, data) ->
  console.log 'notify was called with ', action, SHT['barcodes/notification'](data)
  data['action'] = action
  $('.top-right').notify
    message: SHT['barcodes/notification'](data)
  .show()


console.log 'started listening'
window.source = new EventSource("/barcodes/stream")
if document.getElementById('barcodes')
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
else
  source.addEventListener "barcodes.create", (e) ->
    data = JSON.parse(e.data)
    notify 'created', data

  source.addEventListener "barcodes.update", (e) ->
    data = JSON.parse(e.data)
    notify 'updated', data

  source.addEventListener "barcodes.destroy", (e) ->
    data = JSON.parse(e.data)
    message = if $("#barcode_#{data.id}").length then 'This' else '##{data.id}'
    $('.top-right').notify
      message: message + ' barcode was deleted. Sorry about that'
    .show()
$ ->
  $(window).onbeforeunload = ->
    console.log 'unloading'
    source.close()
