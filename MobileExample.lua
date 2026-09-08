local MacLib
if isfile and isfile("Maclib/maclib.lua") then
	MacLib = loadstring(readfile("Maclib/maclib.lua"))()
elseif isfile and isfile("maclib.lua") then
	MacLib = loadstring(readfile("maclib.lua"))()
else
	MacLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/NongTham/Maclib/main/maclib.lua"))()
end

--// สร้างหน้าต่าง UI พร้อมตั้งค่าสำหรับการใช้งานบนมือถือ (Mobile Optimized)
local Window = MacLib:Window({
	Title = "Maclib Mobile",
	Subtitle = "Modern Edition v2.0",
	Size = UDim2.fromOffset(720, 500),   -- ขนาดที่เหมาะกับทั้งมือถือและจอคอม
	DragStyle = 1,
	DisabledWindowControls = {},
	ShowUserInfo = true,
	Keybind = Enum.KeyCode.RightControl,
	AcrylicBlur = false,                -- ปิด Blur เพื่อให้ลื่นไหล (FPS สูงสุด) บนมือถือ
	AccentColor = MacLib.Themes.Blue,    -- สี Accent หลัก
	MobileToggle = true,                 -- เปิดปุ่มลอยสำหรับทัชสกรีน (ลากไปไหนก็ได้บนจอ)
	AutoAdjustScale = true,              -- ย่อ/ขยาย UI อัตโนมัติตามขนาดหน้าจอมือถือ
	Scale = 0.85,                        -- ขนาดมาตราส่วนเริ่มต้น
})

--// แท็บเมนู (รองรับ Lucide Icons สวยงาม)
local tabGroups = {
	Group1 = Window:TabGroup()
}

local tabs = {
	Mobile = tabGroups.Group1:Tab({ Name = "หน้าจอมือถือ", Image = "smartphone" }),
	Controls = tabGroups.Group1:Tab({ Name = "ปุ่มและสวิตช์", Image = "sliders" }),
	Settings = tabGroups.Group1:Tab({ Name = "ตั้งค่า", Image = "settings" })
}

tabs.Mobile:SetBadge("Mobile")

--// ==========================================
--// แท็บ 1: ทดสอบการปรับแต่งหน้าจอและปุ่มลอย (Mobile)
--// ==========================================
local mobileLeft = tabs.Mobile:Section({ Side = "Left" })
local mobileRight = tabs.Mobile:Section({ Side = "Right" })

mobileLeft:Header({ Name = "ปรับขนาดหน้าจอ (Scale)" })

mobileLeft:Slider({
	Name = "ขนาด UI (Scale %)",
	Default = 85,
	Minimum = 50,
	Maximum = 120,
	DisplayMethod = "Percent",
	Precision = 0,
	Callback = function(value)
		Window:SetScale(value / 100)
	end
}, "UIScaleSlider")

mobileLeft:Toggle({
	Name = "ปุ่มลอยบนหน้าจอ (Floating Button)",
	Default = true,
	Callback = function(bool)
		Window:SetMobileToggle(bool)
		Window:Notify({
			Title = "Mobile Toggle",
			Description = (bool and "แสดง" or "ซ่อน") .. " ปุ่มลอยบนหน้าจอแล้ว",
			Lifetime = 2.5
		})
	end
}, "MobileToggleSwitch")

mobileLeft:Toggle({
	Name = "กระจกเบลอ (Acrylic Blur)",
	Default = false,
	Callback = function(bool)
		Window:SetAcrylicBlurState(bool)
		Window:Notify({
			Title = "UI Blur",
			Description = (bool and "เปิด" or "ปิด") .. " ระบบเบลอพื้นหลัง",
			Lifetime = 2.5
		})
	end
}, "AcrylicBlurSwitch")

mobileRight:Header({ Name = "ทดสอบการแจ้งเตือนและ Dialog" })

mobileRight:Button({
	Name = "ทดสอบ Dialog Pop-up",
	Callback = function()
		Window:Dialog({
			Title = "แจ้งเตือนสำหรับมือถือ",
			Description = "ระบบ Dialog สามารถกดปุ่ม Confirm หรือ Cancel เพื่อปิดหน้าต่างได้ปกติบนทัชสกรีน",
			Buttons = {
				{
					Name = "ยืนยัน (Confirm)",
					Callback = function()
						Window:Notify({
							Title = "สำเร็จ",
							Description = "คุณกดปุ่มยืนยันแล้ว!",
							Lifetime = 3
						})
					end,
				},
				{
					Name = "ยกเลิก (Cancel)"
				}
			}
		})
	end,
})

mobileRight:Button({
	Name = "ทดสอบ Notification",
	Callback = function()
		Window:Notify({
			Title = "Maclib Mobile",
			Description = "การแจ้งเตือนทำงานได้อย่างถูกต้องบนหน้าจอขนาดเล็ก!",
			Lifetime = 3
		})
	end,
})

mobileRight:Header({ Name = "เปลี่ยนสี Accent Color" })

mobileRight:Button({
	Name = "สีฟ้า (System Blue)",
	Callback = function()
		Window:SetAccentColor(MacLib.Themes.Blue)
	end
})

mobileRight:Button({
	Name = "สีม่วง (Purple)",
	Callback = function()
		Window:SetAccentColor(MacLib.Themes.Purple)
	end
})

mobileRight:Button({
	Name = "สีเขียว (Emerald)",
	Callback = function()
		Window:SetAccentColor(MacLib.Themes.Green)
	end
})

--// ==========================================
--// แท็บ 2: ทดสอบ Controls ต่างๆ บนทัชสกรีน
--// ==========================================
local ctrlLeft = tabs.Controls:Section({ Side = "Left" })
local ctrlRight = tabs.Controls:Section({ Side = "Right" })

ctrlLeft:Header({ Name = "ทดสอบการสัมผัส (Touch Elements)" })

ctrlLeft:Toggle({
	Name = "เปิด / ปิด สวิตช์",
	Default = false,
	Callback = function(state)
		Window:Notify({
			Title = "Toggle",
			Description = "สถานะ: " .. (state and "ON" or "OFF"),
			Lifetime = 2
		})
	end
}, "DemoToggle")

ctrlLeft:Slider({
	Name = "ความเร็วเดิน (WalkSpeed)",
	Default = 16,
	Minimum = 16,
	Maximum = 200,
	DisplayMethod = "Value",
	Precision = 0,
	Callback = function(val)
		local char = game.Players.LocalPlayer.Character
		if char and char:FindFirstChildOfClass("Humanoid") then
			char:FindFirstChildOfClass("Humanoid").WalkSpeed = val
		end
	end
}, "WalkSpeedSlider")

ctrlLeft:Slider({
	Name = "แรงกระโดด (JumpPower)",
	Default = 50,
	Minimum = 50,
	Maximum = 300,
	DisplayMethod = "Value",
	Precision = 0,
	Callback = function(val)
		local char = game.Players.LocalPlayer.Character
		if char and char:FindFirstChildOfClass("Humanoid") then
			char:FindFirstChildOfClass("Humanoid").JumpPower = val
		end
	end
}, "JumpPowerSlider")

ctrlLeft:Input({
	Name = "กล่องข้อความ (Input Box)",
	Placeholder = "แตะเพื่อพิมพ์ข้อความ...",
	AcceptedCharacters = "All",
	Callback = function(text)
		Window:Notify({
			Title = "Input",
			Description = "ข้อความที่พิมพ์: " .. text,
			Lifetime = 3
		})
	end,
}, "DemoInput")

ctrlRight:Header({ Name = "Dropdown & Colorpicker" })

ctrlRight:Dropdown({
	Name = "เลือกอาวุธ (Single Dropdown)",
	Multi = false,
	Required = true,
	Options = {"ดาบ Katana", "ปืนสั้น Gun", "คทาเวทย์ Wand", "ธนู Bow"},
	Default = 1,
	Callback = function(item)
		Window:Notify({
			Title = "Dropdown",
			Description = "เลือก: " .. tostring(item),
			Lifetime = 2
		})
	end
}, "WeaponDropdown")

ctrlRight:Dropdown({
	Name = "เลือกบัฟ (Multi Dropdown พร้อมค้นหา)",
	Search = true,
	Multi = true,
	Required = false,
	Options = {"เพิ่มเลือด HP", "เพิ่มสปีด Speed", "ตีแรงขึ้น Attack", "เกราะป้องกัน Defense", "ต้านทานสถานะ Immune"},
	Default = {"เพิ่มเลือด HP"},
	Callback = function(selected)
		local names = {}
		for k, v in pairs(selected) do
			table.insert(names, k)
		end
		print("Selected buffs: ", table.concat(names, ", "))
	end
}, "BuffsDropdown")

ctrlRight:Colorpicker({
	Name = "เลือกสี (Colorpicker)",
	Default = Color3.fromRGB(0, 170, 255),
	Callback = function(c)
		-- Color update callback
	end
}, "DemoColorPicker")

--// ==========================================
--// แท็บ 3: ตั้งค่าและบันทึก Config
--// ==========================================
MacLib:SetFolder("MaclibMobileConfig")
tabs.Settings:InsertConfigSection("Left")

local settingsRight = tabs.Settings:Section({ Side = "Right" })
settingsRight:Header({ Name = "การทำงานทั่วไป" })

settingsRight:Button({
	Name = "ปิดและถอนการติดตั้ง UI (Unload)",
	Callback = function()
		Window:Unload()
	end
})

Window.onUnloaded(function()
	print("[Maclib Mobile] ปิดการทำงาน UI เรียบร้อยแล้ว")
end)

--// เปิดหน้าแท็บแรกเริ่มต้น
tabs.Mobile:Select()
