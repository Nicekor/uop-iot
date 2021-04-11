local ledPin = 4
-- 1023 => OFF | 0 => ON
local brightnessLevels = {0, 204.6, 409.2, 613.8, 818.4, 1023}
local brightnessIndex = #brightnessLevels
pwm.setup(ledPin, 1000, brightnessLevels[brightnessIndex])
pwm.start(ledPin)

local function indexOf(tab, value)
    for index, val in ipairs(tab) do if value == val then return index end end
    return -1
end

local function closest(table, num)
    local curr = table[1]
    for _index, val in ipairs(table) do
        if (math.abs(num - val) < math.abs(num - curr)) then curr = val end
    end
    return curr
end

local adcPin = 0
local adcTimer = tmr.create()
adcTimer:alarm(300, tmr.ALARM_AUTO, function()
    local digitV = adc.read(adcPin)
    local dc = math.floor(digitV * 3)
    if (dc > 1023) then dc = 1023 end
    local closestBrightness = closest(brightnessLevels, dc)
    brightnessIndex = indexOf(brightnessLevels, closestBrightness)
    pwm.setduty(ledPin, brightnessLevels[brightnessIndex])
end)

local buttons = {
    switchBtn = {pin = 1, pushed = false},
    brightBtn = {pin = 2, pushed = false}
}

local switchBtn = buttons["switchBtn"]
gpio.mode(switchBtn.pin, gpio.INPUT)
gpio.write(switchBtn.pin, gpio.LOW)
local switchBtnPushTimer = tmr.create()
local switchBtnReleaseTimer = tmr.create()

local function onBtnPushed(button)
    if (gpio.read(button.pin) == gpio.HIGH and button.pushed == false) then
        button.pushed = true
    end
end

switchBtnPushTimer:alarm(100, tmr.ALARM_AUTO,
                         function() onBtnPushed(switchBtn) end)

switchBtnReleaseTimer:alarm(100, tmr.ALARM_AUTO, function()
    if (gpio.read(switchBtn.pin) == gpio.LOW and switchBtn.pushed == true) then
        switchBtn.pushed = false
        if (brightnessIndex < #brightnessLevels) then
            adcTimer:stop()
            brightnessIndex = #brightnessLevels
            pwm.setduty(ledPin, brightnessLevels[brightnessIndex])
        else
            adcTimer:start()
        end
    end
end)

local brightBtn = buttons["brightBtn"]
gpio.mode(brightBtn.pin, gpio.INPUT)
gpio.write(brightBtn.pin, gpio.LOW)
local brightBtnPushTimer = tmr.create()
local brightBtnReleaseTimer = tmr.create()

brightBtnPushTimer:alarm(100, tmr.ALARM_AUTO,
                         function() onBtnPushed(brightBtn) end)

brightBtnReleaseTimer:alarm(100, tmr.ALARM_AUTO, function()
    if (gpio.read(brightBtn.pin) == gpio.LOW and brightBtn.pushed == true) then
        adcTimer:stop()
        brightBtn.pushed = false
        brightnessIndex = brightnessIndex + 1
        if (brightnessIndex > #brightnessLevels) then brightnessIndex = 1 end
        pwm.setduty(ledPin, brightnessLevels[brightnessIndex])
    end
end)
