function Initialize()
	bSO='!SetOption'
	bSOG='!SetOptionGroup'
	bWKV='!WriteKeyValue'
	bSV='!SetVariable'
	bU='!Update'
	bRD='!Redraw'
	bUMT='!UpdateMeter'
	bSMG='!ShowMeterGroup'
	bHMG='!HideMeterGroup'
	bUMTG='!UpdateMeterGroup'
	bUMS='!UpdateMeasure'
	sE={'Hide','Show'}
	SKIN:Bang(bSV,'M',0)
	iM=0
	iT=0
end

function Update()
	if iM~=iT then
		iM=iM+math.abs(iT-iM)/(iT-iM)
		U()
		E()
	end
end

function M(lF)
	if iT~=lF then
		iT=lF
		SKIN:Bang(bSO,'MeasureForecast','UpdateDivider',1)
		SKIN:Bang(bSO,'MeterForecast','UpdateDivider',1)
		SKIN:Bang(bUMS,'MeasureForecast')
		SKIN:Bang(bUMT,'MeterForecast')
	end
end

function T()
	SKIN:Bang(bWKV,'Variables','WeatherForecast',(6-iT)/6,'#VARFILE#')
	SKIN:Bang(bSV,'WeatherForecast',(6-iT)/6,'NERV UI\\Weather')
	SKIN:Bang(bSO,'MeterWeather','ToolTipText','Open Weather.com#CRLF#Right-Click to '..sE[iT/6+1]..' Forecast#CRLF#Mid-Click to Update Weather','NERV UI\\Top')
	SKIN:Bang(bU,'NERV UI\\Top')
	M(6-iT)
end

function U()
	SKIN:Bang(bSV,'M',iM)
	if (iM==3)and(iM>iT) then
		SKIN:Bang(bHMG,'Forecast','NERV UI\\Weather')
		SKIN:Bang(bRD,'NERV UI\\Weather')
	elseif iM>3 then
		if (iM==4)and(iM<iT) then SKIN:Bang(bSMG,'Forecast','NERV UI\\Weather') end
		for i=0,2 do
			SKIN:Bang(bSOG,'F'..i,'TransformationMatrix',-math.cos(iM*math.pi/6)..';0;0;1;'..(38+i*57)*(1+math.cos(iM*math.pi/6))..';0','NERV UI\\Weather')
			SKIN:Bang(bUMTG,'F'..i,'NERV UI\\Weather')
		end
		SKIN:Bang(bRD,'NERV UI\\Weather')
	end
end

function E()
	if iM==iT then
		SKIN:Bang(bSO,'MeasureForecast','UpdateDivider',50)
		SKIN:Bang(bSO,'MeterForecast','UpdateDivider',50)
	end
end