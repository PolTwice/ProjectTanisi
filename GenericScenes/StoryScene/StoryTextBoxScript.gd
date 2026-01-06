extends Control

# The full text to show
@export var base_text: String = ""

# List of words to highlight and make clickable
# Each entry: {"word": "Photosynthesis", "id": "photosynthesis", "color": "#FFD54F", "underline": true, "case_sensitive": false}
@export var highlights: Array[Dictionary] = []

# Optional: if true, only replace whole-word matches
@export var whole_words_only: bool = true

# Signal you can listen to from outside
signal link_clicked(id: String)

@onready var label: RichTextLabel = %Label

func _ready() -> void:
	_build_bbcode()
	# Enable mouse if needed
	label.scroll_active = false
	label.fit_content = true

	# Connect click/hover signals for meta (url) segments
	label.meta_clicked.connect(_on_meta_clicked)
	label.meta_hover_started.connect(_on_meta_hover_started)
	label.meta_hover_ended.connect(_on_meta_hover_ended)

func _build_bbcode() -> void:
	# Start from a safe, BBCode-escaped version of your text
	var text := _escape_bbcode(base_text)

	# For multiple words, replace from longest to shortest to avoid nested partial replacements
	var items := highlights.duplicate()
	items.sort_custom(func(a, b): return (a.get("word","").length() > b.get("word","").length()))

	for item in items:
		var word: String = item.get("word", "")
		if word.is_empty():
			continue
		var id: String = item.get("id", word)  # meta value
		var color: String = item.get("color", "#00A2FF")
		var underline: bool = item.get("underline", true)
		var case_sensitive: bool = item.get("case_sensitive", false)

		# Build the BBCode wrapper for this word
		var open_tag := "[url=%s]" % id
		var style_tag := "[color=%s]" % color
		var underline_open := underline ? "[u]" : ""
		var underline_close := underline ? "[/u]" : ""
		var close_tag := "[/color][/url]"

		# Create a regex for finding the word
		var pattern := word
		if whole_words_only:
			# Add word boundaries (Unicode friendly behavior may vary)
			pattern = "\\b" + RegEx.escape(pattern) + "\\b"
		else:
			pattern = RegEx.escape(pattern)

		var rx := RegEx.new()
		var err := rx.compile(pattern, case_sensitive ? 0 : RegEx.UNICODE | RegEx.IGNORE_CASE)
		if err != OK:
			push_warning("Regex compile failed for word: %s" % word)
			continue

		# Replace matches with styled clickable BBCode
		# Use a callback replace to preserve original case in the match
		text = _regex_replace_with_callback(rx, text, func(m: RegExMatch) -> String:
			var matched := m.get_string()
			return "%s%s%s%s%s" % [open_tag, style_tag, underline_open, matched, underline_close + close_tag]
		)

	label.bbcode_enabled = true
	label.text = ""        # clear raw text
	label.bbcode_text = text

func _on_meta_clicked(meta):
	# Forward a clean signal to parent/consumers
	link_clicked.emit(str(meta))

func _on_meta_hover_started(meta):
	# Optional: show cursor change or tooltip
	label.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

func _on_meta_hover_ended(meta):
	label.mouse_default_cursor_shape = Control.CURSOR_ARROW

# --- Helpers ---

func _escape_bbcode(s: String) -> String:
	# Minimal escape for brackets so literal [ ] don't turn into tags.
	# (Godot 4.5 doesn’t expose a built-in full BBCode escape; this works for most cases.)
	return s.replace("[", "\\[").replace("]", "\\]")

func _regex_replace_with_callback(rx: RegEx, input: String, cb: Callable) -> String:
	var result := ""
	var last_end := 0
	for match in rx.search_all(input):
		var start := match.get_start(0)
		var end := match.get_end(0)
		result += input.substr(last_end, start - last_end)
		result += cb.call(match)
		last_end = end
	result += input.substr(last_end)
	return result
