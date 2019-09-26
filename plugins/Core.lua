pat = { "^(ping)$",
        "^(help)$",
        "^(panel)$",
        "^(dump)$",
        "^(tagall)$",
        "^(private settings)$",
       "^(texttype) (.*)$",
       "^(markread) (.*)$",
       "^(biotime) (.*)$",
       "^(setmainbio) (.*)$",
       "^(self) (.*)$",
       "^(read message) (.*)$"
}

function run(msg,crco)
    if is_sudo(msg.sender_user_id) then
if crco[1] == 'ping' then
    return tdbot.editMessageText(msg.chat_id, msg.id, 'READY', 'md', false, 0, nil, nil, nil)
end
if crco[1] == 'panel' then
 markread = returndata(Get('for_all','markread'))
 if Get('for_all','self-off') then
    selfstatus = '|D|'
 else
    selfstatus = '|E|'
 end
 readmessage = returndata(Get('other','ReadMessage:'..msg.chat_id))
 texttype = returndata(Get('other','TextType'))
 timestatusBio = returndata(Get('other','Self-Time')) 
 textBioMain = returndata(Get('other','Self-Bio-MAIN'))
clerkmod = returndata(Get('other','clerkTYPE'))
clerkstatus = returndata(Get('other','ClerkMod'))
text_ = '☤ *Self Status* _:_ *'..selfstatus..'*\n☤ *Markread* `:` *'..markread..'*\n☤ *Clerk* `:` *'..clerkstatus..'*\n☤ *Clerk Type* `:` *'..clerkmod..'*\n☤ *Read Message* `:` *'..readmessage..'*\n☤ *Text Type* `:` *'..texttype:upper()..'*\n☤ *Time in Bio* `:` *'..timestatusBio..'*\n☤ *Main Bio* `:` *'..textBioMain..'*'
return tdbot.editMessageText(msg.chat_id, msg.id, text_..SelfVersion, 'md', false, 0, nil, nil, nil)
end
 if crco[1] == 'markread' and crco[2] then
    if crco[2] == 'on' then
              markread = true
elseif crco[2] == 'off' then
    markread = nil
else
    return
end
if markread then 
    save('for_all','markread',true)
    return tdbot.editMessageText(msg.chat_id,msg.id,'Message : Mark message in chats successfully enabled !', 'md', false, 0, nil, nil, nil)
else 
    del('for_all','markread')
    return tdbot.editMessageText(msg.chat_id,msg.id,'Message : Mark message in chats successfully disabled !', 'md', false, 0, nil, nil, nil)
end
end
if crco[1] == 'read message' and crco[2] then
    if crco[2] == 'on' then
        read = true
    elseif crco[2] == 'off' then
        read = nil
    else
        return
    end

    if read then
    save('other','ReadMessage:'..msg.chat_id,true)
       return tdbot.editMessageText(msg.chat_id, msg.id, 'Message: Read all the Mentions in Chat successfully enabled !', 'md', false, 0, nil, nil, nil)
    else
        del('other','ReadMessage:'..msg.chat_id)
        return tdbot.editMessageText(msg.chat_id, msg.id, 'Message: Read all the Mentions in Chat has beed disabled !', 'md', false, 0, nil, nil, nil)

    end
end 
if crco[1] == 'self' and crco[2] then
    if crco[2] == 'on' then
        self = true
    elseif crco[2] == 'off' then
        self = nil
    else
        return
    
    end
    if self then 
        del('for_all','self-off')
        return 'Message : SELF is enabled '
    else
       
        save('for_all','self-off',true)

        return 'Message : SELF is disabled'
    end
end

if crco[1] == 'private settings' then
  local  function  getstatus_(crco,pri)

    
    
            forwardMessage = getStatus(pri)
     

      function getprofilePhoto (arg,pri)
 
  
        ProfilePhotos = getStatus(pri)
  

    function getonlinestatus(arg,pri)
 
            StatusOnline = getStatus(pri)
       
      

     function getstatusinvate(arg,pri)
       
    
                InvateChat = getStatus(pri)
         

     function getstatuscalls(arg,pri)
     
    
            Calls = getStatus(pri)
text = '☤ *Self-Private-Settings* ☤ \n☤ *Forward Message* `:` *'..(forwardMessage or "i can't Get Data")..'*\n☤ *Profile Photos* `:` *'..(ProfilePhotos or "i can't Get Data")..'*\n☤ *Calls* `:` *'..(Calls or "i can't Get Data")..'*\n☤ *invate Chat* `:` *'..(InvateChat or "i can't Get Data")..'*\n☤ *Last Seen* `:` *'..(StatusOnline or "i can't Get Data")..'*'

tdbot.editMessageText(msg.chat_id, msg.id, text, 'md', false, 0, nil, nil, nil)
     end
  tdbot.getUserPrivacySettingRules('AllowCalls',getstatuscalls,nil)
end
tdbot.getUserPrivacySettingRules('AllowChatInvites',getstatusinvate,nil)
end
tdbot.getUserPrivacySettingRules('ShowStatus',getonlinestatus,nil)
end
tdbot.getUserPrivacySettingRules('ShowProfilePhoto',getprofilePhoto,nil)
end
tdbot.getUserPrivacySettingRules('ShowLinkInForwardedMessages',getstatus_,nil)

end
users = {}
    username_  = {}
if crco[1] == 'tagall' then
    local  text = 'Online users ==> \n'
    getchatMembers = function(add,crco)
    num = crco.total_count
    if num < 2 then
        num_ = 1
    elseif num > 201 then
        num_ = 200
    else
        num_ = num
    end
for number=1,num_ do
    table.insert(users,crco.members[number].user_id)
end

for key, value in pairs(users) do
getusername = function(add,crco_)
    if crco_.username  then
    table.insert(username_,crco_.username)

		 end
        end
tdbot.getUser(value, getusername, nil)
      end
    
    for key, value in pairs(username_) do
    
        text = text.." @"..value.."," 

    end
     tdbot.editMessageText(msg.chat_id, msg.id,text,'html',false, 0, nil, nil, nil)

    end
            tdbot.getSupergroupMembers(msg.chat_id, 'Recent', 0, 200, getchatMembers, nil)
end
if crco[1] == 'help' then
    text = [[
        ☤   Self-Bot   ☤
    *self* _on/off_
    `Enable or Disable Self-Project `

    *texttype* _mention/code/bold/italic/off_
    `Use TEXT TYPE for Message TEXT `

    *markread* _on/off_
    `Enable or Disable MARK READ IN CHAT`

    *readmessage* _on/off_
    `Enable or Disable READ ALL MENTIONS IN CHAT`

    *plugs* 
    `List of Plugs`

    *pl* _-/+  NAME_
    `Enable or Disable Plugs`

    *saveplug* _NAME_
    `Saveing File from` @CRCOPLUGINS `in to plugs`

    *delplug* _NAME_
    `Deleteing Plugins in DISK`

    *setmainbio* _text_ 
    `set MainBio for Time in bio`

    *biotime* _on/off_
    `Enable or Disable start Time in bio`
    
    *private settings*
    `Show Private Settings`

    *tagall*
    `Mention Online Users`

    *clerk* _on/off_
    `Enable or Disable Clerk Mod`

    *setclerk* reply in _gif_/videonote_/voicenote_/_text_
    `Set Clerk Return `

    *setenemy* _username/userid/reply_
    `adding user to MOTHER FUCKERS list`

    *delenemy* _username/userid/reply_
    `remove user from mother fuckers list`

    *clean enemylist*
    `clean enemies list`

    *enemylist*
    `Show MotherFuckers in list`  
    ]]
    return tdbot.editMessageText(msg.chat_id, msg.id,text..SelfVersion,'md',false, 0, nil, nil, nil)

end
if crco[1] == 'setmainbio' then
  
        if crco[2] and (tonumber(string.len(crco[2])) < 71 or tonumber(utf8.len(crco[2])) < 71) then

        save('other','Self-Bio-MAIN',crco[2])
        return tdbot.editMessageText(msg.chat_id, msg.id, 'Message : Main Bio seted  to : '..crco[2],'md',false, 0, nil, nil, nil)
        else 
            return tdbot.editMessageText(msg.chat_id, msg.id, 'Message : please using 70 char in text ','md',false, 0, nil, nil, nil)

    end
end
if crco[1] == 'dump' then 
    function VarDump(CerNer,Company)
    local text = encode_json.encode(Company)
  
    print(encode_json.encode(Company))
    return tdbot.editMessageText(msg.chat_id, msg.id, text,'html',false, 0, nil, nil, nil)

     end
    if tonumber(msg.reply_to_message_id) == 0 then
    else
    tdbot.getMessage(msg.chat_id, 
    tonumber(msg.reply_to_message_id),VarDump,nil)
    end
    end
if crco[1] == 'biotime' then
    if crco[2] == 'on' then
        biotime = true
    elseif crco[2] == 'off' then
        biotime = nil
    else
        return
    end
    if biotime then
        save('other','Self-Time',true)
        return tdbot.editMessageText(msg.chat_id, msg.id, 'Message : Time in bio has been enabled','md',false, 0, nil, nil, nil)
    else
        del('other','Self-Time')
        return  tdbot.editMessageText(msg.chat_id, msg.id, 'Message : Time in bio Has been Disable','md',false, 0, nil, nil, nil)
    end
end
if crco[1] == 'texttype' then
    if crco[2] == 'code' then
        type_mod = 'code'
    elseif crco[2] == 'mention' then
        type_mod = 'mention'
    elseif crco[2] == 'off' then
   type_mod = nil
    elseif crco[2] == 'bold' then
        type_mod = 'bold'
    elseif crco[2] == 'italic' then 
        type_mod = 'italic'
    else
        return

    end
    if type_mod then
        save('other','TextType',type_mod)
        return tdbot.editMessageText(msg.chat_id, msg.id, 'Message : Text Type seted to '..type_mod..' type !','md',false, 0, nil, nil, nil)
    else
        del('other','TextType')
        return  tdbot.editMessageText(msg.chat_id, msg.id, 'Message : TextType Has been Disable','md',false, 0, nil, nil, nil)
    end
end
end
end
function pre(msg,first_update)
    timenow = os.date("%M")
    if first_update and not Get('for_all','self-off') then
        if Get('other','Self-Time') and Get('other','Self-Bio-MAIN') and  tonumber(timenow) ~= tonumber(Get('other','timezone') or 0)then
            Time = os.date("%H:%M")
             tdbot.setBio(Get('other','Self-Bio-MAIN')..': |'..Time..'|', dl_cb, nil)
             save('other','timezone',timenow)

         end
end

    if msg then
    
    if not Get('for_all','self-off') then
      
             if Get('for_all','markread') then
          tdbot.viewMessages(msg.chat_id, msg.id, 1)
        end
    if Get('other','ReadMessage:'..msg.chat_id) then
         tdbot.readAllChatMentions(msg.chat_id,nil,nil)
                end
    if is_sudo(msg.sender_user_id) then
    if msg.content._ == "messageText" and  msg.content.text.text and tonumber(msg.edit_date) == 0 then
        if Get('other','TextType') and  tonumber(msg.edit_date) == 0  then
    if  Get('other','TextType')  == 'bold' then
         tdbot.editMessageText(msg.chat_id, msg.id, '*'..msg.content.text.text..'*','md',false, 0, nil, nil, nil)
    elseif  Get('other','TextType')  == 'mention' then
    function GETINGUSER(CR,CO)
        if tonumber(CO.edit_date) == 0 and CO.sender_user_id then
        tdbot.editMessageTextMention(msg.chat_id, msg.id, msg.content.text.text,0,utf8.len(msg.content.text.text),CO.sender_user_id)
        else 
        tdbot.editMessageTextMention(msg.chat_id, msg.id, msg.content.text.text,0,utf8.len(msg.content.text.text),bot.id)
        end
        end
     tdbot.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),GETINGUSER,nil)
    elseif Get('other','TextType')  == 'code' then 
    tdbot.editMessageText(msg.chat_id,msg.id,'`'..msg.content.text.text..'`','md',false, 0, nil, nil, nil)
    elseif Get('other','TextType')  == 'italic' then
         tdbot.editMessageText(msg.chat_id,msg.id,'_'..msg.content.text.text..'_','md',false, 0, nil, nil, nil)
        end
   
end
    end
end
end
end
end
return {
       patterns = pat,
                runing = run ,
            run = pre 
}

