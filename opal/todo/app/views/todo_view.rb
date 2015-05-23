class TodoView
  attr_accessor :todo, :el, :checkbox, :label, :remove

  def initialize(todo)
    self.todo = todo
  end

  def create_checkbox(complete = false)
    self.checkbox = Element.new(:input)

    checkbox.attr 'type', 'checkbox'
    checkbox.attr 'checked', complete
    checkbox.attr 'data-checkbox', true
  end

  def create_label(title)
    self.label = Element.new(:label)

    label.text = title
    label.attr 'data-label', true
  end

  def create_remove
    self.remove = Element.new(:span)

    remove.text = 'x'
    remove.add_class 'remove' 
    remove.attr 'data-remove', true
  end

  def add_delete_listener
    remove.on :click do
      yield todo, self
    end
  end

  def render
    self.el = Element.new(:li)
    
    el.add_class 'item'

    create_checkbox(todo.complete)
    create_label(todo.title)
    create_remove

    checkbox.on :change do

      if checkbox.is ':checked'
        el.add_class 'complete'
      else
        el.remove_class 'complete'
      end

      todo.toggle_complete
    end

    el << checkbox
    el << label
    el << remove

    el
  end
end