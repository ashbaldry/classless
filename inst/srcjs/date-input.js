var classlessDateBinding = new Shiny.InputBinding();
$.extend(classlessDateBinding, {
  find: function(scope) {
    return $(scope).find("input[type='date']");
  },
  getValue: function(el) {
    return el.value;
  },
  getType: function(el) {
    return "shiny.date";
  },
  setValue: function(el, value) {
    el.value = value;
  },
  subscribe: function(el, callback) {
    $(el).on("change.classlessDateBinding", function(e) {
      callback(false);
    });
  },
  unsubscribe: function(el) {
    $(el).off(".classlessDateBinding");
  }
});

Shiny.inputBindings.register(classlessDateBinding);
