x={}

for i=1,10 do
x[i]=i
end

function f(...)
    local arg = {...}
    arg.n = select('#', ...)
    for i = 1, arg.n do
        message (tostring(arg[i]))
    end
end

function average(...)
    result = 0
    local arg = {...}
    for i,v in ipairs(arg) do
       result = result + v
    end
    --return result/#arg
    message (tostring(result/#arg))
    
end

function aaverage(tab)
    result = 0
    --local arg = {...}
    for i,v in ipairs(tab) do
       result = result + v
    end
    --return result/#arg
    message (tostring(result/#tab))
    
end


f(x)
aaverage(x)



--f(1, 2, 3, "rrrrrr") -- выведет соответственно 1, 2, 3, "Вася"