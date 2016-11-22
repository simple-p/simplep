function handleChange(el) {
  console.log("URL: " + $(el).data('request-url')); 
  console.log("Completed: " + $(el).prop('checked'));
  url = $(el).data('request-url') + '.js'
  $.post(url, {completed: $(el).prop('checked')});
}
