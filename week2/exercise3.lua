local dc = 1023
local pinDIM = 3
pwm.setup(pinDIM, 1000, dc)
pwm.start(pinDIM)
local dcRate = 60

local myTimer = tmr.create()
myTimer:alarm(200, tmr.ALARM_AUTO, function()
    dc = dc - dcRate
    if (dc > 1023) then
        dc = 1023
        dcRate = -dcRate
    end
    if (dc < 10) then
        dc = 10
        dcRate = -dcRate
    end

    print(dc)
    pwm.setduty(pinDIM, dc)
end)
