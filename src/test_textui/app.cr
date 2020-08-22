class App
  delegate error, info, to: @status_bar

  @focusable_widgets : Array(TextUi::Widget)?
  @main_ctl : MainControl

  @ui = TextUi::Ui.new

  def initialize
    @ui.resized.on(&->handle_resize(Int32, Int32))
    @ui.key_typed.on(&->on_key_typed(TextUi::KeyEvent))

    @main_ctl = MainControl.new(@ui)
    @status_bar = TextUi::StatusBar.new(@ui)

    setup_shortcuts
  end

  def main_loop
    puts "UI main loop"
    @ui.main_loop
  end

  private def focusable_widgets : Array(TextUi::Widget)
    @focusable_widgets ||= @main_ctl.focusable_widgets
  end

  private def handle_resize(width, height)
    @main_ctl.handle_resize(width, height)

    @status_bar.y = height - 1
    @status_bar.width = width
  end

  private def setup_shortcuts
    @status_bar.add_shortcut("^X", "Exit")
    @status_bar.add_shortcut("F1", "Help")
  end

  private def on_key_typed(event) : Nil
    case event.key
    when TextUi::KEY_CTRL_X then @ui.shutdown!
    when TextUi::KEY_CTRL_C then copy_line
    when TextUi::KEY_F1
      event.accept
      show_help
    when TextUi::KEY_F2  then @main_ctl.focus_editor
    when TextUi::KEY_F3  then @main_ctl.focus_state
    when TextUi::KEY_TAB then cycle_focus
    else
      # Key not handled
    end
  end

  private def copy_line
    #
  end

  private def show_help
    HelpDialog.new(@ui)
  end

  private def cycle_focus
    focus_next = false
    focusable_widgets.each.cycle.each_with_index do |widget, i|
      return @ui.focus(widget) if focus_next
      focus_next = widget.focused?

      return @ui.focus(focusable_widgets.first) if i > focusable_widgets.size
    end
  end
end
