-- include useful files
u_execScript("utils.lua")
u_execScript("common.lua")
u_execScript("commonpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
		if mKey == 0 then pAltBarrage(math.random(2, 4), 2)
	elseif mKey == 1 then pMirrorSpiral(math.random(2, 5), getHalfSides() - 3)
	elseif mKey == 2 then pBarrageSpiral(math.random(0, 3), 1, 1)
	elseif mKey == 3 then pInverseBarrage(0)
	elseif mKey == 4 then pTunnel(math.random(1, 3))
	elseif mKey == 5 then pSpiral(l_getSides() * math.random(1, 2), 0)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 1, 1, 2, 2, 3, 3, 4, 5, 5 }
shuffle(keys)
index = 0
achievementUnlocked = false

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
	l_setSpeedMult(1.55)
	l_setSpeedInc(0.125)
	l_setSpeedMax(5)
	l_setRotationSpeed(0.07)
	l_setRotationSpeedMax(1)
	l_setRotationSpeedInc(0.04)
	l_setDelayMult(1.0)
	l_setDelayInc(0)
	l_setFastSpin(0.0)
	l_setSides(6)
	l_setSidesMin(5)
	l_setSidesMax(6)
	l_setIncTime(15)

	l_setPulseMin(75)
	l_setPulseMax(91)
	l_setPulseSpeed(1.2)
	l_setPulseSpeedR(1)
	l_setPulseDelayMax(23.9)

	l_setBeatPulseMax(17)
	l_setBeatPulseInitialDelay(53 / 2)
	l_setBeatPulseDelayMax(53) -- BPM is 68
	l_setBeatPulseSpeedMult(0.35) -- Slows down the center going back to normal

	enableSwapIfDMGreaterThan(3)
	disableIncIfDMGreaterThan(4)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	e_messageAdd("tutorials are over", 130)
	e_messageAdd("good luck getting high scores!", 130)
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
	addPattern(keys[index])
	index = index + 1

	if index - 1 == #keys then
		index = 1
		shuffle(keys)
	end
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
	enableSwapIfSpeedGEThan(4.5);
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	if not achievementUnlocked and l_getLevelTime() > 120 and u_getDifficultyMult() >= 1 then
		steam_unlockAchievement("a1_pointless")
		achievementUnlocked = true
	end
end
