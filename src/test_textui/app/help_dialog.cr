class HelpDialog < TextUi::Dialog
  CONTENTS = "HELP CONTENT"
  VERSION  = "whatevs"

  def initialize(ui)
    super(ui, "Program v#{VERSION} - Help")
    close_when_lose_focus

    size = TextUi::Widget.text_dimensions(CONTENTS, ui.width - 2, ui.height - 2)
    resize(size[:width] + 2, size[:height] + 2)

    label = TextUi::Label.new(self, 1, 1, CONTENTS)
    label.resize(size[:width], size[:height])

    old_focus = ui.focused_widget

    ui.focus(self)

    dismissed.on { ui.focus(old_focus) }
  end

  def on_key_event(event)
    dismiss
  end
end
