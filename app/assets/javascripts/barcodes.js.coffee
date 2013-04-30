# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


console.log 'started listening'
window.source = new EventSource("/barcode/stream")
source.addEventListener "barcodes.create", (e) ->
  data = JSON.parse(e.data)
  console.log data.id, 'create'
  console.log SHT['barcodes/show'](data)

source.addEventListener "barcodes.update", (e) ->
  data = JSON.parse(e.data)
  console.log data.id, 'update'
  $("#barcode_#{data.id}").addClass('highlight-update')
  console.log SHT['barcodes/show'](data)
source.addEventListener "barcodes.destroy", (e) ->
  data = JSON.parse(e.data)
  $("#barcode_#{data.id}").addClass('highlight-remove').fadeOut('fast', (-> @remove()))
  console.log data.id, 'destroy'
$ ->
  $(window).onbeforeunload = ->
    console.log 'unloading'
    source.close()