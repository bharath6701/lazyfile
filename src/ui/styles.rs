//! Terminal styling definitions.

use ratatui::style::{Color, Modifier, Style};

/// Default style.
pub const NORMAL_STYLE: Style = Style::new();

/// Style for selected items.
pub fn selected_style() -> Style {
    Style::new()
        .fg(Color::Black)
        .bg(Color::Cyan)
        .add_modifier(Modifier::BOLD)
}

/// Style for focused panels.
pub fn focused_style() -> Style {
    Style::new().fg(Color::Cyan).add_modifier(Modifier::BOLD)
}

/// Style for status bar.
pub fn status_bar_style() -> Style {
    Style::new().fg(Color::Black).bg(Color::Gray)
}

/// Style for headers.
pub fn header_style() -> Style {
    Style::new().fg(Color::Cyan).add_modifier(Modifier::BOLD)
}
