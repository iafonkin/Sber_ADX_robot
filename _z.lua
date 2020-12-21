Settings = {
Name = "ADX_SSMA", 
Period = 14, 

line = {	{
			Name = "Horizontal line",
			Type = TYPE_LINE, 
			Color = RGB(0, 0, 255)
			},

			{
            Name = "ADX", 
            Type = TYPE_LINE, 
            Color = RGB(0, 162, 232)
			},
			
            {
            Name = "ADX +DI",
            Type = TYPE_LINE, 
            Color = RGB(0, 206, 0)
			},
			
            {
            Name = "ADX -DI",
            Type = TYPE_LINE,
			Color = RGB(221, 44, 44)
			}
		},

Horizontal_line="35"
}

TR={}
DMplus={}
DMminus={}

function Init()
	
	return #Settings.line
end

function OnCalculate(Index)
P = Settings.Period
	if CandleExist(Index - P *2) then
		data(Index)
		Res = ssma_TR()
	

	return tonumber(Settings.Horizontal_line), Res
	end
	
end

function data(Index)
	
	for i = 1, P*2 do

		x = Index - 1 - (P * 2) + i
			
			TR[i] = math.max( math.max (H(x) - L(x), H(x) - L(x - 1)), math.abs(L(x)-C(x -1)) ) 
			
			if H(x) - H(x -1) > L(x -1) - L(x) then
				DMplus[i] = math.max(H(x) - H(x -1), 0) 
			else
				DMplus[i] = 0	
			end

			if L(x-1) - L(x) > H(x) - H(x -1) then
				DMminus[i] = math.max(L(x-1) - L(x), 0) 
			else
				DMminus[i] = 0	
			end
	end
end


function ssma_TR()
	P = Settings.Period
	local sum1 = 0
	local sum2 = 0

	for i=1, P*2 do
		if i <= P / 2 then
			sum1 = sum1 + TR[i]
			sum1 = sum1 / (P/2)

		else

			sum2 = sum1
			sum2 = ( (sum2*(P-1) + TR[i]) / P   
	
	end
return sum2
end

function SMA_array(...)
	local sum = 0
	local arg = {...}
	arg.n = select('#', ...)
	for i=1, arg.n /2 do
		sum = sum + arg[i]
	end
	sma = sum /(arg.n/2)
	return sma

end

function SSMA_aray(...)

	local arg = {...}
	arg.n = select('#', ...)
	
	P = Settings.Period
	local sum1 = 0
	local sum2 = {}
		
	for i=1, arg.n do
		if i <= P / 2 then
			sum1 = sum1 + arg[i]
			sum1 = sum1 / (arg.n/2)

		else

			sum2[1] = sum1
			sum2[i - P] = ( (sum2[i-P-1]*(P-1) + arg[i]) / P   )
		end

		
	end

	return sum2[arg.n]
end

function sma(fCandle, lCandle)

	for i=fCandle , lCandle do
	sum = sum + C(i)
	end
	sma = sum / (lCandle - fCandle)

	return sma

end

function ssma(Index)
	sum1 = sma(Index - (Settings.Period * 2), Index - Settings.Period)
	p = Settings.Period
	sum2[1] = sum1

	for i=2, P do
		sum2[i] = ( sum2[i-1]*(P-1) + C(Index - (P-i)) ) / P
	end

	return sum2[P]

end