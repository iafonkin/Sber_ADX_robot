Settings = {
    Name = "zxADX_TV", 
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
            if Index > (P * 2) then
            
            ADXg, DIplusg, DIminusg = data(Index)
            end
                  
    
        return tonumber(Settings.Horizontal_line), ADXg, DIplusg, DIminusg
        end
        
    end
    
    function data(Index)
        P = Settings.Period
        TR={}
        DMplus={}
        DMminus={}
        DXi={}

        for i = 1, P*2 do
    
            x = Index - 1 - (P * 2) + i
                
            if CandleExist(x) and CandleExist(x-1) then
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
        end
        
        DIplus = ssma(DMplus) / ssma(TR) * 100
        DIminus = ssma(DMminus) / ssma(TR) * 100
        ADX = sma(DXi)
        return DIplus, DIminus, ADX

    end
    
    
    function ssma(tab)
        P = Settings.Period
        local sum1 = 0
        local sum2 = 0
        local j = 0
        
    
        for i,v in ipairs(tab) do

            if i <= P then
                sum1 = sum1 + v
             else
                if j==0 then
                    sum2 = sum1 / P
                    j=1
                end

                sum2 = (sum2*(P-1) + v) / P
            end  
        
        end
        return sum2
    end

    function sma(tab)
        local sum = 0
        for i,v in ipairs(tab) do
            sum = sum + v
        end
        result = sum/#tab
        return result
    end
    
    