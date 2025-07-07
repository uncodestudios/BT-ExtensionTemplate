# BadTag Lua Extension Template

This is a template for creating Lua extensions (mods) for **BadTag**.
It demonstrates best practices for code organization, event subscription, and cleanup.

If you want a plain empty extension template, it's inside the **EmptyTemplate** folder. The **Template** folder contains template code to give you a usage idea.

---

## 📁 Structure (Template)

```
TemplateExtension/
├── main.lua                # Main extension code
├── Callbacks/
│   └── Callbacks.lua       # Event callback functions
└── TemplateExtension.config # Extension configuration
```

## 📁 Structure (EmptyTemplate)

```
TemplateExtension/
├── main.lua                # Main extension code
└── TemplateExtension.config # Extension configuration
```

---

## 📝 Files

* **main.lua**
  Core logic for the extension.

  * Initializes references (e.g., player, controller).
  * Creates and configures objects (like a trigger cube).
  * Subscribes to Unity events.
  * Handles cleanup and unsubscription.

* **Callbacks/Callbacks.lua**
  Functions that handle events (such as `OnTriggerEnter`), kept separate for organization.

* **TemplateExtension.config**
  The extension’s manifest/config file.
  Lists all files (with subfolder paths if needed) and declares metadata.

---

## ⚙️ Config Example

```json
{
  "name": "TemplateExtension",
  "version": "1.0.0",
  "gameVersion": "1.0.0",
  "description": "A simple extension template for BadTag",
  "dependencies": [],
  "files": [
    "main.lua",
    "Callbacks/Callbacks.lua"
  ]
}
```

> **Note:**
> All Lua files (including those in subfolders) must be listed in the `files` array, using their paths relative to the extension’s root.

---

## 🚀 Getting Started

To install the extension **locally**, copy your extension’s folder into one of the following directories:

**PC (Steam) (Coming Soon):**
`AppData\LocalLow\UncodeStudios\Bad Tag\mod.io\Local`

If the directory does not exist, create it.

**Android (Standalone):**
`Android\data\com.CozProductionsInc.BadTag\files\mod.io\Local`

A `.config` file represents the root directory of an extension—ensure your extension is in a subfolder inside `\Local`.

Extensions installed in-game from mod.io are inside the same `mod.io` directory but in a different folder.

1. **Copy the template folder** to a subdirectory in your BadTag extensions directory (as above). For example: `\mod.io\Local\MyExtensionName`.
2. **Edit `main.lua`** and `Callbacks/Callbacks.lua` to implement your mod’s logic.
3. **List all your Lua files** (with subfolder paths) in the `.config` file.
4. **Launch BadTag** with Lua modding enabled.

---

## 📚 Documentation

The full API docs are here: [BT-Lua-Docs on GitHub](https://github.com/uncodestudios/BT-Lua-Docs.git)

---

## 🔗 Dependencies & Public Functions

This extension has **no dependencies** by default.

To use another extension as a dependency:

* Add the extension’s name to the `dependencies` list in your config.
* Example:

  ```json
  "dependencies": ["CoolMod"]
  ```
* To call a function from a dependency, use:

  ```lua
  ExtensionName.Function()
  ```

  The function **must** be marked as public.

### Declaring Public Functions

* Public functions are declared by adding the line `--[PublicMethod]--` above your function:

  ```lua
  --[PublicMethod]--
  function MyFunction()
  end
  ```
* If the extension is called `CoolMod`, you invoke that with:

  ```lua
  CoolMod.MyFunction()
  ```
* Only public functions can be called from other extensions. **You do not need to mark functions as public** to call them from other files in your own extension.

---

## 🗂 Sharing Variables and Functions Across Files

You can reference any variable or function you have in your extension from any other Lua file in the same extension as if it was in the same file.

**Example:**

* Test.lua

  ```lua
  local addRate = 55
  ```
* OtherFile.lua

  ```lua
  myRate = myRate + addRate
  ```

It’s the same for functions:

* Test.lua

  ```lua
  function CoolFunc()
  end
  ```
* OtherFile.lua

  ```lua
  function Start()
      CoolFunc()
  end
  ```

**You do NOT need `--[PublicMethod]--` for your own internal functions**—only for cross-extension API.

> **Note:** Variables cannot currently be referenced by other extensions, only functions can be made public.

If you need more examples, check out the LUtilla extension source code. (Coming Soon)

---

## 🧠 Tips

* Keep event callbacks in a separate file for better organization.
* Use `canRun` or similar guards to avoid errors in `Update`.
* Always unsubscribe from events and clean up objects in your `OnUnloaded` handler.

---

## ⚠️ Notes

* The API is in development—**things can change at any moment.**
* Extensions are game-version specific. Make sure your `gameVersion` matches the version of BadTag you’re targeting.

---

Happy modding!
