class Todo
  attr_accessor :title, :complete

  def initialize(attributes)
    self.title = attributes.fetch 'title'
    self.complete = attributes.fetch 'complete', false
  end

  def toggle_complete
    self.complete = !self.complete
  end
end