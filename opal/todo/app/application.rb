require 'opal'
require 'jquery'
require 'opal-jquery'

require 'models/todo'
require 'views/todo_view'

class Application
  attr_accessor :el, :list, :add, :new_title, :todos

  def initialize(app_selector)
    self.el = Element.find app_selector
    self.list = el.find '[data-list]'
    self.add = el.find '[data-add]'
    self.new_title = el.find '[data-new-title]'
    self.todos = Array.new
  end

  def start
    add.on :click do
      create_todo
    end
  end

  def create_todo
    new_title.show

    new_title.focus

    new_title.on :blur do
      add_todo new_title.value
      new_title.hide
      new_title.off :blur
      new_title.value = ''
    end
  end

  def add_todo(title)
    todos << Todo.new(title: title)
    render
  end

  def remove_todo(todo)
    todos.delete todo
    render
  end

  def render
    list.empty

    todos.each do | todo |
      todo_view = TodoView.new(todo)
      
      rendered_todo = todo_view.render

      todo_view.add_delete_listener do | t |
        remove_todo t
      end

      list << rendered_todo
    end
  end

end

app = Application.new '#todo'
app.start