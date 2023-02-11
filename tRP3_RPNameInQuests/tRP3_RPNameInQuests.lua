local TRPRPNAMEINQUESTS = select(2, ...);

local function trp3RPNameInQuestsInit()



	--for debug
	
	
	
	--[[local function tprint (t, s)
		for k, v in pairs(t) do
			local kfmt = '["' .. tostring(k) ..'"]'
			if type(k) ~= 'string' then
				kfmt = '[' .. k .. ']'
			end
			local vfmt = '"'.. tostring(v) ..'"'
			if type(v) == 'table' then
				tprint(v, (s or '')..kfmt)
			else
				if type(v) ~= 'string' then
					vfmt = tostring(v)
				end
				print(type(t)..(s or '')..kfmt..' = '..vfmt)
			end
		end
	end]]--



	if tRP3RPNameInQuests == nil then
		tRP3RPNameInQuests = 1
	end


	local useNewAPI = true


	if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) or (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC) then
		useNewAPI = true
	end

	if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) or (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC)    then
		useNewAPI = false
	end





	-- Function that does the actual renaming
	local TRP3_RPNameInQuests_VarToChange = UnitName("player")
	--UnitName("player")
	local function TRP3_RPNameInQuests_TextRename(textToRename, returnRPName)
	
		returnRPName = returnRPName or false
	

		--Get TRP 3 Name
		
		--print("TextRename")
		
		
		if (tRP3RPNameInQuests == 1) then
			-- ooc name, so do nothing
			return textToRename
		
		else
			--rename char
			local thisTRP3CharInfo = TRP3_API.profile.getData("player/characteristics")
		
			local thisTRP3CharName = ""
			
			if (tRP3RPNameInQuests == 2 or tRP3RPNameInQuests == 3 or tRP3RPNameInQuests == 4 or tRP3RPNameInQuests == 5) then
				if (thisTRP3CharInfo.TI) then
					thisTRP3CharName = thisTRP3CharName .. thisTRP3CharInfo.TI	.. " "
				end
			end
			
			if (tRP3RPNameInQuests == 3 or tRP3RPNameInQuests == 5 or tRP3RPNameInQuests == 6 or tRP3RPNameInQuests == 8) then
				if (thisTRP3CharInfo.FN) then
					thisTRP3CharName = thisTRP3CharName .. thisTRP3CharInfo.FN
				end
			end
			
			if (tRP3RPNameInQuests == 4 or tRP3RPNameInQuests == 5 or tRP3RPNameInQuests == 7 or tRP3RPNameInQuests == 8) then
				if (thisTRP3CharInfo.LN) then
					thisTRP3CharName = thisTRP3CharName .. " " ..  thisTRP3CharInfo.LN
				end
			end
			
			--trim space
			thisTRP3CharName = thisTRP3CharName:gsub("^%s*(.-)%s*$", "%1")
			
			if (thisTRP3CharName == "") then
				--empty, do nothing
				thisTRP3CharName = TRP3_RPNameInQuests_VarToChange
				
			else
			
				if (textToRename) then
					textToRename = textToRename:gsub(TRP3_RPNameInQuests_VarToChange, thisTRP3CharName)
				end
			end
			
			
			if (returnRPName == true) then
				return thisTRP3CharName
			else
				return textToRename
			end
			
			
		end
		
		
		
	end








	-- Quest Window
	
	hooksecurefunc("QuestInfo_Display", function()
		--print("QuestInfo_Display")

		local thisQuestDescription = QuestInfoDescriptionText:GetText()
		
		--Make sure RP name isn't already in the quest description to dodge dupes
		if (thisQuestDescription ~= nil) then
			if (strmatch(thisQuestDescription, TRP3_RPNameInQuests_VarToChange) and (not (strmatch(thisQuestDescription, TRP3_RPNameInQuests_TextRename("placeholder", true))))) then
				QuestInfoDescriptionText:SetText(TRP3_RPNameInQuests_TextRename(thisQuestDescription))
			end
		
		end

	end)
	










	
	
	if (useNewAPI == true) then
	
	
		-- Get Gossip Text
		local TRP3_RPNameInQuests_C_GossipInfoGetTextHook = C_GossipInfo.GetText
		C_GossipInfo.GetText = function (...)
		
			--print("TRP3_RPNameInQuests_C_GossipInfoGetTextHook")
			
			local thisGossipText = TRP3_RPNameInQuests_C_GossipInfoGetTextHook()
			
			if (strmatch(thisGossipText, TRP3_RPNameInQuests_VarToChange)) then
				return TRP3_RPNameInQuests_TextRename(thisGossipText)
			else
				return thisGossipText
			end
			
		end

	
	
	else 
	
		-- Get Gossip Text
		local TRP3_RPNameInQuests_GetGossipTextHook = GetGossipText
		GetGossipText = function (...)
		
			--print("TRP3_RPNameInQuests_GetGossipTextHook")
			
			local thisGossipText = TRP3_RPNameInQuests_GetGossipTextHook()
			
			if (strmatch(thisGossipText, TRP3_RPNameInQuests_VarToChange)) then
				return TRP3_RPNameInQuests_TextRename(thisGossipText)
			else
				return thisGossipText
			end
			
		end

	
	end
	
	
	

	
	
	-- Get Greeting Text
	local TRP3_RPNameInQuests_GetGreetingTextHook = GetGreetingText
	GetGreetingText = function (...)
	
		--print("TRP3_RPNameInQuests_GetGreetingTextHook")
		
		local thisGreetingText = TRP3_RPNameInQuests_GetGreetingTextHook()
		
		if (strmatch(thisGreetingText, TRP3_RPNameInQuests_VarToChange)) then
			return TRP3_RPNameInQuests_TextRename(thisGreetingText)
		else
			return thisGreetingText
		end
		
	end
	
	
	
	
	
	
	
	
	


	-- Get Quest Text
	local TRP3_RPNameInQuests_GetQuestTextHook = GetQuestText
	GetQuestText = function (...)
	
		--print("TRP3_RPNameInQuests_GetQuestTextHook")
		
		local thisQuestText = TRP3_RPNameInQuests_GetQuestTextHook()
		
		if (strmatch(thisQuestText, TRP3_RPNameInQuests_VarToChange)) then
			return TRP3_RPNameInQuests_TextRename(thisQuestText)
		else
			return thisQuestText
		end
		
	end








	-- Get Quest Progress Text
	local TRP3_RPNameInQuests_GetProgressTextHook = GetProgressText
	GetProgressText = function (...)
	
		--print("TRP3_RPNameInQuests_GetProgressTextHook")
		
		local thisProgressText = TRP3_RPNameInQuests_GetProgressTextHook()
		
		if (strmatch(thisProgressText, TRP3_RPNameInQuests_VarToChange)) then
			return TRP3_RPNameInQuests_TextRename(thisProgressText)
		else
			return thisProgressText
		end
		
	end




	-- Get Quest Reward Text
	local TRP3_RPNameInQuests_GetRewardTextHook = GetRewardText
	GetRewardText = function (...)
	
		--print("TRP3_RPNameInQuests_GetRewardTextHook")
		
		local thisRewardText = TRP3_RPNameInQuests_GetRewardTextHook()
		
		if (strmatch(thisRewardText, TRP3_RPNameInQuests_VarToChange)) then
			return TRP3_RPNameInQuests_TextRename(thisRewardText)
		else
			return thisRewardText
		end
		
	end




	if (useNewAPI == true) then


		-- Gossip Options
		local TRP3_RPNameInQuests_GetGossipOptions = C_GossipInfo.GetOptions
		C_GossipInfo.GetOptions = function (...)
		
			--print("TRP3_RPNameInQuests_GetGossipOptions")
		
			local thisGossipOptions = TRP3_RPNameInQuests_GetGossipOptions()
			--print(thisGossipOptions)
			
			for key, value in pairs(thisGossipOptions) do
							
				if (strmatch(thisGossipOptions[key]["name"], TRP3_RPNameInQuests_VarToChange)) then
					thisGossipOptions[key]["name"] =  TRP3_RPNameInQuests_TextRename(thisGossipOptions[key]["name"])
				end
				
			end

			return(thisGossipOptions)
		
		end
	
	
	else
		--TO DO - Classic version maybe?
	

	end


	-- NPC /s Chat
	ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_SAY", function(self, thisEvent, thisMessage, thisNPC, ...) 
		--print("monster say")

		if (strmatch(thisMessage, TRP3_RPNameInQuests_VarToChange) or strmatch(thisNPC, TRP3_RPNameInQuests_VarToChange)) then
			-- do NPC name as well in case player's been transformed e.g. Gamon
			local thisNewMessage = TRP3_RPNameInQuests_TextRename(thisMessage)
			local thisNewNPC = TRP3_RPNameInQuests_TextRename(thisNPC)
			TRP3_RPNameInQuests_ModSpeechBubbles()
			return false, thisNewMessage, thisNewNPC, ...
		end

	end)


	-- NPC /y Chat
	ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_YELL", function(self, thisEvent, thisMessage, thisNPC, ...) 
		--print("monster yell")

		if (strmatch(thisMessage, TRP3_RPNameInQuests_VarToChange) or strmatch(thisNPC, TRP3_RPNameInQuests_VarToChange)) then
			-- do NPC name as well in case player's been transformed e.g. Gamon
			local thisNewMessage = TRP3_RPNameInQuests_TextRename(thisMessage)
			local thisNewNPC = TRP3_RPNameInQuests_TextRename(thisNPC)
			TRP3_RPNameInQuests_ModSpeechBubbles()
			return false, thisNewMessage, thisNewNPC, ...
		end

	end)
	
	
	-- NPC /p Chat
	ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_PARTY", function(self, thisEvent, thisMessage, thisNPC, ...) 
		--print("monster party")

		if (strmatch(thisMessage, TRP3_RPNameInQuests_VarToChange) or strmatch(thisNPC, TRP3_RPNameInQuests_VarToChange)) then
			-- do NPC name as well in case player's been transformed e.g. Gamon
			local thisNewMessage = TRP3_RPNameInQuests_TextRename(thisMessage)
			local thisNewNPC = TRP3_RPNameInQuests_TextRename(thisNPC)
			TRP3_RPNameInQuests_ModSpeechBubbles()
			return false, thisNewMessage, thisNewNPC, ...
		end

	end)
	
	-- NPC /w Chat
	ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_WHISPER", function(self, thisEvent, thisMessage, thisNPC, ...) 
		--print("monster party")

		if (strmatch(thisMessage, TRP3_RPNameInQuests_VarToChange) or strmatch(thisNPC, TRP3_RPNameInQuests_VarToChange)) then
			-- do NPC name as well in case player's been transformed e.g. Gamon
			local thisNewMessage = TRP3_RPNameInQuests_TextRename(thisMessage)
			local thisNewNPC = TRP3_RPNameInQuests_TextRename(thisNPC)
			--TRP3_RPNameInQuests_ModSpeechBubbles()
			return false, thisNewMessage, thisNewNPC, ...
		end

	end)
	
	-- NPC /e Chat
	ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_EMOTE", function(self, thisEvent, thisMessage, thisNPC, ...) 
		--print("monster party")

		if (strmatch(thisMessage, TRP3_RPNameInQuests_VarToChange) or strmatch(thisNPC, TRP3_RPNameInQuests_VarToChange)) then
			-- do NPC name as well in case player's been transformed e.g. Gamon
			local thisNewMessage = TRP3_RPNameInQuests_TextRename(thisMessage)
			local thisNewNPC = TRP3_RPNameInQuests_TextRename(thisNPC)
			--TRP3_RPNameInQuests_ModSpeechBubbles()
			return false, thisNewMessage, thisNewNPC, ...
		end

	end)




	--Speech Bubbles
	--with Code Modified from https://www.wowinterface.com/forums/showpost.php?p=336696&postcount=2
	
	
	function TRP3_RPNameInQuests_ModSpeechBubbles()
	
		--print("TRP3_RPNameInQuests_ModSpeechBubbles")
		
		--Slight timer so the bubble has chance to fade in
		C_Timer.After(.05, function()
			for _, bubble in pairs(C_ChatBubbles.GetAllChatBubbles()) do -- This -should- only affect NPC speech bubbles, player speech bubbles are protected
				for i = 1, bubble:GetNumChildren() do
					local child = select(i, select(i, bubble:GetChildren()))
					if(child) then
						if (child:GetObjectType() == "Frame") and (child.String) and (child.Center) then
							for i = 1, child:GetNumRegions() do
								local region = select(i, child:GetRegions())
								if (region:GetObjectType() == "FontString") then
								
									thisBubbleText = region:GetText()
									
									
									if (strmatch(thisBubbleText, TRP3_RPNameInQuests_VarToChange) and (not (strmatch(thisBubbleText, TRP3_RPNameInQuests_TextRename("placeholder", true))))) then
										region:SetText(TRP3_RPNameInQuests_TextRename(thisBubbleText))
									end

								end
							end
						end
					end
				end
			
			end
		
		end)
		
	end
	
	
	local TRPRPNAMEINQUESTS_DROPDOWNSTUFF = {
		{ "OOC Character Name", 1 },
		{ "Title", 2 },
		{ "Title + First Name", 3 },
		{ "Title + Last Name", 4 },
		{ "Title + First Name + Last Name", 5 },
		{ "First Name", 6 },
		{ "Last Name", 7 },
		{ "First Name + Last Name", 8 },	
	}
	
	
TRPRPNAMEINQUESTS.CONFIG = {};

TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME = "trp3_rpnameinquests_whichrpname";

TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME, tRP3RPNameInQuests);

TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME, tRP3RPNameInQuests)

TRP3_API.configuration.registerConfigurationPage({
		id = "trp3_rpnameinquests_config",
		menuText = "Quest Text",
		pageText = "RP Name in Quest Text",
		elements = {
			{
				inherit = "TRP3_ConfigParagraph",
				title = "This AddOn attempts to put your Total RP 3 Character Name into quest text and dialogue.",
			},
			{
				inherit = "TRP3_ConfigDropDown",
				widgetName = "trp3_rpnameinquests_whichrpnamewidget",
				title = "How should NPCs address |cffffcc00" .. UnitName("player") .. "|r?",
				help = "This will replace your OOC Name in Quests, NPC Speech, and Speech Bubbles, with your chosen name format. Note: Will cause funky stuff to happen if your OOC name is a common word.",
				listContent = TRPRPNAMEINQUESTS_DROPDOWNSTUFF,
				configKey = TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME,
				listCallback = function(value)
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME, value)
					--print(TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME))
					tRP3RPNameInQuests = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME)
					--print(tRP3RPNameInQuests)
				end,

			},
			
		}
	
	});

end


TRP3_API.module.registerModule({
	name = "RP Name in Quest Text",
	description = "This AddOn attempts to put your Total RP 3 Character Name into quest text and dialogue.",
	version = "1.0.0",
	id = "trp3_rpnameinquests",
	onStart = trp3RPNameInQuestsInit,
	minVersion = 60,
});
