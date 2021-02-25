local greenPin = 3
local yellowPin = 4
local redPin = 5
local pwmFrequency = 1000

pwm.setup(greenPin, pwmFrequency, 1023)
pwm.start(greenPin)
pwm.setup(yellowPin, pwmFrequency, 0)
pwm.start(yellowPin)
pwm.setup(redPin, pwmFrequency, 0)
pwm.start(redPin)

local intervals = {4000, 500, 2000, 500}
local index = 1

local myTimer = tmr.create()
myTimer:alarm(intervals[1], tmr.ALARM_AUTO, function()
    local greenDuty = pwm.getduty(greenPin)
    local yellowDuty = pwm.getduty(yellowPin)
    local redDuty = pwm.getduty(redPin)

    if (greenDuty > 0) then
        pwm.setduty(greenPin, 0)
        pwm.setduty(yellowPin, 1023)
    end

    if (yellowDuty > 0) then
        pwm.setduty(yellowPin, 0)
        if (index == #intervals) then
            pwm.setduty(greenPin, 1023)
        else
            pwm.setduty(redPin, 1023)
        end
    end

    if (redDuty > 0) then
        pwm.setduty(redPin, 0)
        pwm.setduty(yellowPin, 1023)
    end

    if (index >= #intervals) then
        index = 1
    else
        index = index + 1
    end

    myTimer:interval(intervals[index])
end)
