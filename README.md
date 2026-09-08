# Maclib UI Library (Modern Edition v2.0)

![image](https://github.com/user-attachments/assets/991cd465-8a61-4753-9fa6-dfd590bc4322)

> A modern, sleek macOS-inspired User Interface library for Roblox scripting. Re-engineered with native mobile support, Lucide icons, customizable themes, memory leak prevention, and comprehensive bug fixes.

---

## 🌟 What's New in v2.0 (Modern Edition)

- 📱 **Full Mobile & Touch Device Support**:
  - **Auto-Responsive Scaling**: Automatically fits any mobile, tablet, or smaller screen via dynamic `UIScale` calculations.
  - **Draggable Mobile Floating Toggle Button**: A sleek floating circular button for mobile/touch users to toggle the UI easily without needing a physical keybind.
  - **Viewport Clamping**: Prevents window headers from being dragged off-screen.
- 🎨 **Lucide Icons & Sprite Sheets**:
  - Full native support for `ImageRectOffset` and `ImageRectSize`.
  - Directly compatible with [`latte-soft/lucide-roblox`](https://github.com/latte-soft/lucide-roblox) and sprite sheet packages.
  - Built-in Lucide icon name resolver (e.g. `Image = "home"`, `Image = "settings"`, `Image = "shield"`, `Image = "crosshair"`, etc.).
- 🎯 **Dynamic Themes & Accent Colors**:
  - Customize accent colors on the fly (`Settings.AccentColor` or `Window:SetAccentColor(color)`).
  - Built-in presets: `Blue`, `Graphite`, `Purple`, `Pink`, `Red`, `Orange`, `Green`, `Cyan`, `Yellow`.
  - Toggles, slider heads, active tab badges, and primary buttons adapt to your chosen accent color.
- 🧹 **100% Memory Leak Free**:
  - Integrated `Maid` system: All `UserInputService` connections, `RunService.RenderStepped` loops, and `Lighting` DepthOfField/camera blur effects are properly cleaned up upon calling `Window:Unload()`.
- 🛠️ **Crucial Bug Fixes**:
  - **Keybind Crash**: Fixed `KeybindFunctions.KeybindFunctions.Settings.Blacklist` typo.
  - **Keybind UpdateName**: Fixed `keybindName = Name` bug that broke the label.
  - **Keybind Config Saving**: Keybinds are now properly saved to the config file.
  - **Config System Toggle 'false' Value**: Fixed `and data.state` truthiness check that prevented `false` toggles from loading.
  - **Slider Bar Click & Drag**: You can now click or drag anywhere on the slider bar directly.
  - **Slider FocusLost Crash**: Fixed `ValueDisplayMethod` receiving a TextBox instance.
  - **Dropdown Height Constraint**: Added max height and scrolling so long option lists no longer break out of bounds.
  - **InsertConfigSection Side Parameter**: Now properly respects the `Side` argument (`"Left"` or `"Right"`).
  - **100% Backward Compatible**: Existing scripts (such as ExaminationHub) continue to function with zero changes needed.

---

## 🚀 Quick Start

```lua
local MacLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/biggaboy212/Maclib/main/maclib.lua"))()

local Window = MacLib:Window({
    Title = "Maclib Demo",
    Subtitle = "Modern Edition v2.0",
    Size = UDim2.fromOffset(868, 650),
    DragStyle = 1,
    DisabledWindowControls = {},
    ShowUserInfo = true,
    Keybind = Enum.KeyCode.RightControl,
    AcrylicBlur = true,
    AccentColor = MacLib.Themes.Blue, -- Theme / Accent Color
    MobileToggle = true,              -- Floating toggle button on mobile
    AutoAdjustScale = true,           -- Responsive scaling for smaller screens
})

local TabGroup = Window:TabGroup()
local Tab = TabGroup:Tab({
    Name = "Main",
    Image = "home", -- Lucide icon or rbxassetid://...
})

Tab:SetBadge("v2.0")

local Section = Tab:Section({ Side = "Left" })

Section:Header({ Name = "Controls" })

Section:Toggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(state)
        print("Auto Farm:", state)
    end,
}, "AutoFarmToggle")

Section:Slider({
    Name = "WalkSpeed",
    Default = 16,
    Minimum = 16,
    Maximum = 120,
    DisplayMethod = "Value",
    Precision = 0,
    Callback = function(value)
        print("Speed:", value)
    end,
}, "SpeedSlider")

local Dropdown = Section:Dropdown({
    Name = "Select Weapon",
    Multi = false,
    Required = true,
    Options = {"Sword", "Bow", "Staff", "Dagger"},
    Default = 1,
    Callback = function(weapon)
        print("Selected weapon:", weapon)
    end,
}, "WeaponDropdown")

-- Adding Config Section (Left or Right)
Tab:InsertConfigSection("Right")

-- Select active tab
Tab:Select()
```

---

## 📖 API Reference

### `MacLib:Window(Settings)`
| Setting | Type | Default | Description |
|---|---|---|---|
| `Title` | string | `"Maclib"` | The main window title |
| `Subtitle` | string | `""` | Subtitle text displayed next to title |
| `Size` | UDim2 | `UDim2.fromOffset(868, 650)` | Default window size |
| `AccentColor` | Color3 / string | `Color3.fromRGB(0, 122, 255)` | Accent color or theme name |
| `MobileToggle` | boolean | `isTouchDevice` | Enables floating draggable mobile toggle button |
| `MobileToggleIcon` | string / number / table | `assets.globe` | Icon for the floating button |
| `AutoAdjustScale` | boolean | `true` | Automatically scales UI to fit small screens |
| `Keybind` | Enum.KeyCode | `Enum.KeyCode.RightControl` | Menu toggle keybind |
| `AcrylicBlur` | boolean | `true` | Enables glass blur effects |
| `ShowUserInfo` | boolean | `true` | Displays player avatar and username in sidebar |

### `Window:SetAccentColor(color)`
Dynamically updates the accent color across the window.

### `Window:SetMobileToggle(visible)`
Shows or hides the mobile toggle button.

### `Tab:SetBadge(text)`
Adds a stylish badge tag (e.g. `"NEW"`, `"PRO"`, `"5"`) next to the tab name. Pass `nil` to hide.

### `Tab:SetName(newName)`
Updates the tab switcher name.

### `Tab:SetImage(image, rectOffset, rectSize)`
Updates the tab icon dynamically with optional sprite sheet rects.

### `Dropdown:SetValues(optionsTable, defaultSelection)`
Dynamically replaces the options in the dropdown and updates selection.

### `Dropdown:Refresh(optionsTable)`
Refreshes the options while preserving the currently active selection if still valid.

### `Window:Unload()`
Cleanly destroys the window, disconnects every listener, restores lighting effects, and prevents memory leaks.

---

## 👥 Credits

- **@biggaboy212** - Original creator of Maclib UI Library
- **[latte-soft/lucide-roblox](https://github.com/latte-soft/lucide-roblox)** - Lucide icon spritesheet integration
- **[dawid-scripts/Fluent](https://github.com/dawid-scripts/Fluent)** - Configuration system foundations
