do ($ = jQuery, window = window) ->
  $.fn.addDelayedRemoveClass = (className, delay, interrupt = $.noop) ->
    console.log 'highlight was called with ', @, arguments
    @addClass(className)
    setTimeout((=>
      @removeClass(className)
    ), delay)
    setTimeout((=>
      interrupt.call @
    ), Math.floor(delay / 2))
    @
