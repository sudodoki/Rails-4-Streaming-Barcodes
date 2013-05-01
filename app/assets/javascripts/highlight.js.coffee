do ($ = jQuery, window = window) ->
  $.fn.addDelayedRemoveClass = (className, delay, interrupt = $.noop) ->
    @addClass(className)
    setTimeout((=>
      @removeClass(className)
    ), delay)
    setTimeout((=>
      interrupt.call @
    ), Math.floor(delay / 2))
    @
