// Generated by CoffeeScript 1.10.0
(function(window, $) {
  return ($('#handle-list')).filtered({
    selector: 'a',
    input: '#handle-filter',
    getText: function(element) {
      var text;
      element = $(element);
      text = element.text().trim();
      return text.toLowerCase();
    }
  });
})(this, this.jQuery);
