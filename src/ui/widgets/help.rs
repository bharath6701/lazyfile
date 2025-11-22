//! Help widget.

use crate::ui::styles;
use ratatui::{prelude::*, widgets::Paragraph};

/// Widget for displaying help text.
pub struct HelpWidget;

impl HelpWidget {
    /// Render the help widget.
    ///
    /// # Arguments
    /// * `f` - Frame for rendering
    /// * `area` - Area to render in
    pub fn render(f: &mut Frame, area: Rect) {
        let help_text = "j/k: Navigate | a: Add | e: Edit | d: Delete | Enter: Open | Backspace: Back | Tab: Panel | q: Quit";
        let paragraph = Paragraph::new(help_text).style(styles::header_style());
        f.render_widget(paragraph, area);
    }
}
