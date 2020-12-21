Settings = {
    Name = "ADX_TV", 
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
    DXi={}
    
    function Init()
        
        return #Settings.line
    end
    
    function OnCalculate(Index)
    P = Settings.Period
        if CandleExist(Index - P *2) then
            data(Index)
                  
    
        return tonumber(Settings.Horizontal_line), ADX, DIplus, DIminus
        end
        
    end
    
    function data(Index)
        P = Settings.Period

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
               
            if i > P then

                DIplus = ssma(DMplus) / ssma(TR) * 100
                DIminus = ssma(DMminus) / ssma(TR) * 100
                DXi[i-P] = math.abs(DIplus - DIminus) / (DIplus + DIminus) * 100
                
            end
        
        end
        
        DIplus = ssma(DMplus) / ssma(TR) * 100
        DIminus = ssma(DMminus) / ssma(TR) * 100
        ADX = sma(DXi)

    end
    
    
    function ssma(tab)
        P = Settings.Period
        local sum1 = 0
        
    
        for i,v in ipairs(tab) do
            if i <= P then
                sum1 = sum1 + v
                sum1 = sum1 / (P/2)
    
            else
    
                sum1 = sum1
                sum1 = ( (sum1*(P-1) + v) / P   
        
        end
    return sum1
    end

    function sma(tab)
        local sum = 0
        for i,v in ipairs(tab) do
            sum = sum + v
        end
    result sum/#tab
    end
    
    