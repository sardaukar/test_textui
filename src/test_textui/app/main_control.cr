class MainControl
  def initialize(ui : TextUi::Ui)
    @editor_box = TextUi::Box.new(ui, "Main", "F2")
    @editor_box.border_style = TextUi::Box::BorderStyle::Fancy

    @editor = TextUi::TextEditor.new(@editor_box, 1, 1, 0, 0)
    @editor.tab_width = 0
    @editor.show_line_numbers = false
    @editor.word_wrap = false
    @editor.key_typed.on(&->on_key_typed(TextUi::KeyEvent))

    ui.focus(@editor)

    @state_box = TextUi::Box.new(ui, "State", "F3")
    @state_box.border_style = TextUi::Box::BorderStyle::Fancy
    @state_list = TextUi::List.new(@state_box, 1, 1)
    @state_list.width = 18
  end

  private def on_key_typed(event) : Nil
    case event.key
    else
      # Key not handled
    end
  end

  def handle_resize(width, height)
  end

  def focusable_widgets
    [@editor, @state_list]
  end

  def focus_editor
    @editor.focus
  end

  def focus_state
    @state_list.focus
  end
end
