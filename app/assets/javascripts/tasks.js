function handleChange(el) {
  url = $(el).data('request-url') + '.js'
  $.post(url, {completed: $(el).prop('checked')});
}
