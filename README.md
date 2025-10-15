# ProjectTanisi
2025-2026 CST Project Tanisi

# GlobalState.gd
**This is an autoload singleton.**
---
## 📣 Signals
- `signal lesson_completed(lesson_id: StringName)`
- `signal quiz_completed(quiz_id: StringName, score: int, total: int)`

---

## 🧮 Variables
### `lessonsCompleted: Dictionary = {}`
- Holds lessons and whether they’re complete.
- **Example:**
  ```gdscript
  { "beaver": true, "wolf": false }
  ```

### `quizScores: Dictionary = {}`
- Holds quizzes as keys, each value is a dictionary with `score` and `total`.
- **Example:**
  ```gdscript
  { "beaverQuiz": { "score": 3, "total": 5 } }
  ```
---

## 🎬 SceneManager

- Holds an instance of the scene manager so that it is accessible globally.

---

## 🔧 Methods

- Setters and getters for `lessonsCompleted` and `quizScores`.

---

## 📝 Summary

This holds dictionaries for lessons and quizzes completed.  
Signals for lesson and quiz completion can be emitted from global state.

---

# SceneManager.gd

**This script is attached to the root node.**

---

## 🔧 Exports

### `@export var nodeContainerOne: Node`
- `nodeContainerOne` is a container for other nodes.

---

## 🔗 Node Reference

### `@onready var ui: MainUI = $UI`

---

## 🧠 Methods

### `_ready() -> void`
- Sets `GlobalState.SceneManager` to `self`.
- Sets current container and path to variables for later use.

### `changeNodeOne(new_scene: String, pushToStack = true, delete: bool = true, keep_running: bool = false)`
- Main function for changing `nodeContainerOne`.

---

# Animal.gd

**Script attached to each animal in the `animalSelectScene`.**

---
