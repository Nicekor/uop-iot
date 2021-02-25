local dc = 1023
local pinDIM = 3
pwm.setup(pinDIM, 1000, dc)
pwm.start(pinDIM)

local myTimer = tmr.create()
myTimer:alarm(200, tmr.ALARM_AUTO, function()
    dc = dc - 50
    pwm.setduty(pinDIM, dc)

    if (dc < 10) then dc = 1023 end
end)
